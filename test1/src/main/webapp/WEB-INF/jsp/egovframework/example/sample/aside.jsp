<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js' />"></script>

<script>
$(document).ready(function(){
	/* $("aside > ul > li").on("click", function(){
		$("aside > ul > li").removeClass("actv");
		$(this).addClass("actv");
	}); */
	
	actvMenuCheck();
	
	// 사이드 메뉴 클릭 시 세션스토리지에 클릭한 메뉴 아이디 저장
	$("aside > ul > li").on("click", function(){
		var id = $(this).attr("data-id")
		localStorage.setItem("actvMenu", id);
	});
});

// 세션스토리지에서 선택된 메뉴 값 가져와 메뉴 활성화
const actvMenuCheck = function(){
	var actvMenu =  localStorage.getItem("actvMenu");
	
	if(actvMenu != ""){
		$("aside > ul > li[data-id='"+actvMenu+"']").addClass("actv");
	}
} 
	
</script>

<style>
	aside {
		position:fixed;
		top:0;
		left:0;
		width:120px;
		height:100%;
		border:1px solid #3A4F41;
		padding-top:60px;
	}
	
	aside > ul {
		width:100%;
		height:100%;
	}
	
	aside > ul > li {
		width:100%;
		height: calc((100% - 60px) / 7);
		border-bottom:1px solid #3A4F41;
		box-sizing:border-box;
		display:flex;
		justify-content:center;
		align-items:center;
		color:#3D405B;
		cursor:pointer;
	}
	
	aside > ul > li.actv {
		background:#3A4F41;
		color:white;
	}
	
	aside > ul > li:hover {
		background:#3A4F41;
		color:white;
	}
</style>

<aside>
	<ul>
		<li>유지보수현황</li>
		<li onclick="location.href='/main2'" data-id="main">나의업무보드</li>
		<li onclick="location.href='/customer/customerBase'" data-id="customer">고객관리</li>
		<li>일정관리</li>
		<li>장애관리</li>
		<li>정보관리</li>
		<li>엔지니어관리</li>
	</ul>
</aside>