package egovframework.example.sample.board.model;


public class PagingVO2 {
	
	// 현재페이지
	private int nowPage;
	
	// 이전페이지 존재 유무
	private boolean existPrePage;
	
	// 다음페이지 존재 유무
	private boolean existNextPage;
	
	//Limit 시작위치
	private int limitStart;
	
	// 총 게시글 수 
	private int total;
	
	// 총 페이지 수
	private int totalPage;
	
	// 시작페이지
	private int startPage;
	
	// 마지막페이지
	private int endPage;
	
	// 페이지당 보여줄 갯수
	private int perPage;
	
	
	// 보여줄 페이지 수
	private int perPagecnt = 10;
	
	public PagingVO2(int total, int nowPage, int perPage) {
		setNowPage(nowPage);
		setTotal(total);
		setPerPage(perPage);
		calOffset(getNowPage(),getPerPage());
		calTotalPage(getTotal(),getPerPage());
		calStartEndPage(getNowPage(),perPagecnt);
		calExistPreOrNext(getNowPage());
		
	}

	public void calOffset(int nowPage,int perPage) {
		setLimitStart((int)Math.ceil((double)(nowPage-1)*(double)(perPage)));
	}
	
	// 총 페이지 구하기
	public void calTotalPage(int total,int perPage) {
		setTotalPage((int)Math.ceil((double)total / (double)perPage));
	}
	
	// 시작페이지와 끝(마지막아님)페이지 구하기
	public void calStartEndPage(int nowPage, int perPagecnt) {
		setEndPage(((int)Math.ceil((double)nowPage/(double)perPagecnt))*perPagecnt);
		if(getTotalPage() < getEndPage()){
			setEndPage(getTotalPage());
		}
		setStartPage(getEndPage()-perPagecnt+1);
		if(getStartPage()<1) {
			setStartPage(1); 
		}
	}
	
	public void calExistPreOrNext(int nowPage) {
		if(nowPage == 1) {
			setExistPrePage(false);
			setExistNextPage(true);
		}
		else if(nowPage == getTotalPage()) {
			setExistNextPage(false);
			setExistPrePage(true);
		}
		else {
			setExistPrePage(true);
			setExistNextPage(true);
		}
	}
	
	public int getNowPage() {
		return nowPage;
	}
	
	public boolean getExistPrePage() {
		return existPrePage;
	}
	
	public boolean getExistNextPage() {
		return existNextPage;
	}
	
	public int getLimitStart() {
		return limitStart;
	}
	
	public int getTotal() {
		
		return total;
	}
	
	public int getTotalPage() {
		return totalPage;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	
	public int getEndPage() {
		return endPage;
	}
	
	public int getPerPage() {
		return perPage;
	}
	
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	
	public void setExistPrePage(boolean existPrePage) {
		this.existPrePage = existPrePage;
	}
	
	public void setExistNextPage(boolean existNextPage) {
		this.existNextPage = existNextPage;
	}
	
	public void setLimitStart(int limitStart) {
		this.limitStart = limitStart;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
