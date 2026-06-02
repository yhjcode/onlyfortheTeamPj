package com.bggchef.util;

/**
 * 페이지네이션 계산 유틸
 * - currentPage: 현재 페이지 (1부터)
 * - totalCount : 전체 게시물 수
 * - pageSize   : 한 페이지에 보일 게시물 수 (기본 10)
 * - blockSize  : 한 번에 보일 페이지 번호 수 (기본 5)
 */
public class PagingUtil {
    private int currentPage;
    private int pageSize  = 10;
    private int blockSize = 5;
    private int totalCount;
    private int totalPage;
    private int startPage;
    private int endPage;

    public PagingUtil(int currentPage, int totalCount) {
        this.currentPage = currentPage;
        this.totalCount  = totalCount;
        calculate();
    }

    private void calculate() {
        totalPage = (int) Math.ceil((double) totalCount / pageSize);
        startPage = ((currentPage - 1) / blockSize) * blockSize + 1;
        endPage   = Math.min(startPage + blockSize - 1, totalPage);
    }

    public int getStartRow()     { return (currentPage - 1) * pageSize + 1; }
    public int getEndRow()       { return currentPage * pageSize; }
    public int getCurrentPage()  { return currentPage; }
    public int getPageSize()     { return pageSize; }
    public int getTotalPage()    { return totalPage; }
    public int getStartPage()    { return startPage; }
    public int getEndPage()      { return endPage; }
    public int getTotalCount()   { return totalCount; }
}
