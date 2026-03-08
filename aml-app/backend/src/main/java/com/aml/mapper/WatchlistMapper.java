package com.aml.mapper;

import com.aml.domain.WatchlistEntry;
import com.aml.domain.WatchlistScreen;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface WatchlistMapper {

    WatchlistEntry findEntryById(@Param("wlId") Long wlId);

    List<WatchlistEntry> findEntryByParams(Map<String, Object> params);

    long countEntryByParams(Map<String, Object> params);

    List<WatchlistEntry> findAllActive();

    int insertEntry(WatchlistEntry entry);

    int updateEntry(WatchlistEntry entry);

    int insertScreenResult(WatchlistScreen screen);

    int updateScreenResult(WatchlistScreen screen);

    List<WatchlistScreen> findScreenByParams(Map<String, Object> params);

    long countScreenByParams(Map<String, Object> params);

    WatchlistScreen findScreenById(@Param("screenId") Long screenId);
}
