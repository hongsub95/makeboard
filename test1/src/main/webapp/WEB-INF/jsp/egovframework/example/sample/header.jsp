<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
</script>

<style>
	header {
		position:fixed;
		top:0;
		left:0;
		width:100%;
		height:60px;
		border-bottom:2px solid #3A4F41;
		background:white;
		z-index:999;
		display:flex;
		justify-content:space-between;
		box-sizing:border-box;
	}
	
	header > .hLeftArea {
		display:flex;
		align-items:center;
		margin: 0 30px;
		height:100%;
	}
	
	header > .hLeftArea > .logo {
		width:200px;
		height:40px;
		background:url("/static/img/softsignal_logo.png") no-repeat;
		background-size:200px;
	}
	
	header > .hRighttArea {
		display:flex;
	}
</style>

<header>
	<div class="hLeftArea">
		<div class="logo"></div>
	</div>
	<div class="hRighttArea">
		
	</div>
</header>