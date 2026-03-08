package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.Customer;
import com.aml.domain.WatchlistEntry;
import com.aml.domain.WatchlistScreen;
import com.aml.mapper.CustomerMapper;
import com.aml.mapper.WatchlistMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class WatchlistService {

    private final WatchlistMapper watchlistMapper;
    private final CustomerMapper customerMapper;

    @Transactional(readOnly = true)
    public PageResult<WatchlistEntry> searchEntries(String wlNm, String wlSrcCd, String wlTpCd,
                                                    String useYn, int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("wlNm", wlNm);
        params.put("wlSrcCd", wlSrcCd);
        params.put("wlTpCd", wlTpCd);
        params.put("useYn", useYn != null ? useYn : "Y");
        params.put("size", size);
        params.put("offset", offset);

        List<WatchlistEntry> content = watchlistMapper.findEntryByParams(params);
        long total = watchlistMapper.countEntryByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public WatchlistEntry getEntry(Long wlId) {
        WatchlistEntry entry = watchlistMapper.findEntryById(wlId);
        if (entry == null) {
            throw new IllegalArgumentException("워치리스트 항목을 찾을 수 없습니다: " + wlId);
        }
        return entry;
    }

    @Transactional
    public WatchlistEntry createEntry(WatchlistEntry entry) {
        if (entry.getUseYn() == null) {
            entry.setUseYn("Y");
        }
        watchlistMapper.insertEntry(entry);
        log.info("Watchlist entry created: {}", entry.getWlNm());
        return watchlistMapper.findEntryById(entry.getWlId());
    }

    @Transactional
    public WatchlistEntry updateEntry(Long wlId, WatchlistEntry entry) {
        WatchlistEntry existing = watchlistMapper.findEntryById(wlId);
        if (existing == null) {
            throw new IllegalArgumentException("워치리스트 항목을 찾을 수 없습니다: " + wlId);
        }
        entry.setWlId(wlId);
        watchlistMapper.updateEntry(entry);
        return watchlistMapper.findEntryById(wlId);
    }

    /**
     * Screen a customer against the watchlist using fuzzy name matching.
     * Scoring:
     *   - Exact match (case-insensitive): 100
     *   - Customer name contained in watchlist name (or vice versa): proportional overlap score
     *   - Partial character overlap via Levenshtein similarity: scaled score
     * Only results with score >= 30 are persisted.
     */
    @Transactional
    public List<WatchlistScreen> screen(String custNo, String userId) {
        Customer customer = customerMapper.findById(custNo);
        if (customer == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + custNo);
        }

        List<WatchlistEntry> entries = watchlistMapper.findAllActive();
        List<WatchlistScreen> results = new ArrayList<>();

        String custNm = customer.getCustNm().trim().toUpperCase();

        for (WatchlistEntry entry : entries) {
            double score = computeMatchScore(custNm, entry);

            if (score >= 30.0) {
                WatchlistScreen screen = new WatchlistScreen();
                screen.setCustNo(custNo);
                screen.setWlId(entry.getWlId());
                screen.setMatchScr(BigDecimal.valueOf(score).setScale(2, RoundingMode.HALF_UP));
                screen.setMatchStCd("PENDING");
                screen.setRegId(userId);
                watchlistMapper.insertScreenResult(screen);
                results.add(screen);
                log.info("Watchlist hit: cust={} wl={} score={}", custNo, entry.getWlNm(), score);
            }
        }

        log.info("Screening completed for {}: {} hits", custNo, results.size());
        return results;
    }

    /**
     * Compute a fuzzy match score (0-100) between the customer name and a watchlist entry.
     * Checks the main name and all aliases separated by ';'.
     */
    private double computeMatchScore(String custNm, WatchlistEntry entry) {
        double best = 0.0;

        best = Math.max(best, nameMatchScore(custNm, entry.getWlNm().trim().toUpperCase()));

        if (entry.getWlNmAlias() != null && !entry.getWlNmAlias().isBlank()) {
            for (String alias : entry.getWlNmAlias().split(";")) {
                String trimmed = alias.trim().toUpperCase();
                if (!trimmed.isEmpty()) {
                    best = Math.max(best, nameMatchScore(custNm, trimmed));
                }
            }
        }

        return best;
    }

    /**
     * Score a single name pair.
     * - Exact match → 100
     * - One string contains the other → proportional overlap (70-95 range)
     * - Levenshtein similarity → scaled to 0-65
     */
    private double nameMatchScore(String a, String b) {
        if (a.equals(b)) {
            return 100.0;
        }

        // Substring containment
        if (a.contains(b)) {
            // b is contained in a: score proportional to how much of a it covers
            double coverage = (double) b.length() / a.length();
            return 70.0 + coverage * 25.0;
        }
        if (b.contains(a)) {
            double coverage = (double) a.length() / b.length();
            return 70.0 + coverage * 25.0;
        }

        // Levenshtein similarity
        double levenshteinSim = levenshteinSimilarity(a, b);
        return levenshteinSim * 65.0;
    }

    /**
     * Levenshtein similarity: 1 - (editDistance / maxLen), returns 0.0 to 1.0.
     */
    private double levenshteinSimilarity(String a, String b) {
        int maxLen = Math.max(a.length(), b.length());
        if (maxLen == 0) {
            return 1.0;
        }
        int distance = levenshteinDistance(a, b);
        return 1.0 - (double) distance / maxLen;
    }

    private int levenshteinDistance(String a, String b) {
        int m = a.length();
        int n = b.length();
        int[][] dp = new int[m + 1][n + 1];

        for (int i = 0; i <= m; i++) {
            dp[i][0] = i;
        }
        for (int j = 0; j <= n; j++) {
            dp[0][j] = j;
        }
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (a.charAt(i - 1) == b.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i][j - 1]));
                }
            }
        }
        return dp[m][n];
    }

    @Transactional(readOnly = true)
    public PageResult<WatchlistScreen> getScreenResults(String custNo, String matchStCd,
                                                         int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("custNo", custNo);
        params.put("matchStCd", matchStCd);
        params.put("size", size);
        params.put("offset", offset);

        List<WatchlistScreen> content = watchlistMapper.findScreenByParams(params);
        long total = watchlistMapper.countScreenByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional
    public WatchlistScreen updateScreenResult(Long screenId, String matchStCd, String remark, String userId) {
        WatchlistScreen screen = watchlistMapper.findScreenById(screenId);
        if (screen == null) {
            throw new IllegalArgumentException("스크리닝 결과를 찾을 수 없습니다: " + screenId);
        }
        screen.setMatchStCd(matchStCd);
        screen.setRemark(remark);
        screen.setReviewId(userId);
        screen.setReviewDt(LocalDateTime.now());
        screen.setUpdId(userId);
        watchlistMapper.updateScreenResult(screen);
        return watchlistMapper.findScreenById(screenId);
    }
}
