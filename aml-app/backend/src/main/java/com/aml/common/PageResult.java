package com.aml.common;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class PageResult<T> {

    private List<T> content;
    private int page;
    private int size;
    private long total;
    private int totalPages;

    public PageResult(List<T> content, int page, int size, long total) {
        this.content = content;
        this.page = page;
        this.size = size;
        this.total = total;
        this.totalPages = (int) Math.ceil((double) total / size);
    }
}
