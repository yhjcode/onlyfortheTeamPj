<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="menu" value="main" scope="request" />

<!-- ============================================
     히어로 배너
     ============================================ -->
<section class="section-card position-relative p-0 overflow-hidden">
	<div class="hero-banner">
		<h2>
			<span class="highlight">우리집만의</span> 레시피를 알려주세요
		</h2>
		<p>방구석셰프들과 함께 맛있는 한 끼를 공유하세요!</p>
	</div>
</section>

<!-- ============================================
     별점 높은 레시피 (REQ_REC_001 - 별점순)
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-star-fill text-danger me-2"></i> <span class="accent">별점
				높은</span>&nbsp;레시피
		</h3>
		<a href="${pageContext.request.contextPath}/recipe/list?sort=rating"
			class="btn-more"> 더보기 <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<button class="carousel-arrow prev" type="button" aria-label="이전">
		<i class="bi bi-chevron-left"></i>
	</button>
	<button class="carousel-arrow next" type="button" aria-label="다음">
		<i class="bi bi-chevron-right"></i>
	</button>

	<div class="row g-3">
		<%-- TODO: c:forEach var="r" items="${topRatedRecipes}" --%>
		<c:forEach begin="1" end="4" var="i">
			<div class="col-md-3 col-6">
				<a href="${pageContext.request.contextPath}/recipe/view?id=${i}">
					<div class="recipe-card">
						<div class="recipe-card-img-wrap">
							<span class="rank-badge">TOP ${i}</span> <img
								class="recipe-card-img"
								src="https://picsum.photos/seed/rating${i}/400/400"
								alt="레시피 ${i}">
						</div>
						<div class="recipe-card-body">
							<h6 class="recipe-card-title">맛있는 김치찌개 만드는 ${i}번째 방법</h6>
							<div class="recipe-meta">
								<span class="rating"><i class="bi bi-star-fill"></i>
									4.${9-i}</span> <span><i class="bi bi-eye"></i> 1.${i}K</span> <span><i
									class="bi bi-heart"></i> ${i*100}</span>
							</div>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</section>

<!-- ============================================
     최신 레시피 (REQ_REC_001 - 최신순)
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-clock-fill text-danger me-2"></i> <span
				class="accent">방금 올라온</span>&nbsp;최신 레시피
		</h3>
		<a href="${pageContext.request.contextPath}/recipe/list?sort=latest"
			class="btn-more"> 더보기 <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<button class="carousel-arrow prev" type="button" aria-label="이전">
		<i class="bi bi-chevron-left"></i>
	</button>
	<button class="carousel-arrow next" type="button" aria-label="다음">
		<i class="bi bi-chevron-right"></i>
	</button>

	<div class="row g-3">
		<%-- TODO: c:forEach var="r" items="${latestRecipes}" --%>
		<c:forEach begin="1" end="4" var="i">
			<div class="col-md-3 col-6">
				<a href="${pageContext.request.contextPath}/recipe/view?id=${i+10}">
					<div class="recipe-card">
						<div class="recipe-card-img-wrap">
							<span class="like-badge"><i class="bi bi-heart"></i>
								${i*5}</span> <img class="recipe-card-img"
								src="https://picsum.photos/seed/latest${i}/400/400" alt="레시피">
						</div>
						<div class="recipe-card-body">
							<h6 class="recipe-card-title">초간단 ${i}분 야식 레시피 모음</h6>
							<div class="recipe-meta">
								<span class="rating"><i class="bi bi-star-fill"></i> -</span> <span><i
									class="bi bi-eye"></i> ${i*12}</span> <span><i
									class="bi bi-clock"></i> ${i}분 전</span>
							</div>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</section>

<!-- ============================================
     인기 셰프 랭킹 (REQ_REC_001 - 셰프랭킹)
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-trophy-fill text-danger me-2"></i> <span
				class="accent">인기</span>&nbsp;셰프 랭킹
		</h3>
		<a href="${pageContext.request.contextPath}/ranking/daily"
			class="btn-more"> 더보기 <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<button class="carousel-arrow prev" type="button" aria-label="이전">
		<i class="bi bi-chevron-left"></i>
	</button>
	<button class="carousel-arrow next" type="button" aria-label="다음">
		<i class="bi bi-chevron-right"></i>
	</button>

	<div class="row g-3">
		<%-- TODO: c:forEach var="chef" items="${chefRanking}" --%>
		<c:forEach begin="1" end="4" var="i">
			<div class="col-md-3 col-6">
				<a
					href="${pageContext.request.contextPath}/chef/profile?id=user${i}">
					<div class="chef-card">
						<div class="chef-avatar-wrap">
							<span class="chef-rank-badge">${i}</span> <img
								class="chef-avatar"
								src="https://picsum.photos/seed/chef${i}/180/180" alt="셰프">
						</div>
						<div class="chef-name">방구석셰프${i}</div>
						<div class="chef-stat">
							레시피 <strong class="text-danger">${i*7}</strong>개 · 팔로워 <strong
								class="text-danger">${i*100}</strong>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</section>

<!-- ============================================
     추천 테마
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-1">
		<h3 class="section-title">
			<i class="bi bi-bookmark-fill text-danger me-2"></i> <span class="accent">추천</span>&nbsp;테마
		</h3>
		<a href="${pageContext.request.contextPath}/theme/list"
			class="btn-more"> 더보기 <i class="bi bi-chevron-right"></i>
		</a>
	</div>
	<p class="text-muted mb-4">전문 셰프들이 추천하는 다양한 테마별 레시피를 만나보세요!</p>

	<div class="row g-3">
		<c:set var="themes" value='<%= new String[]{"🍚 한식", "🍝 양식", "🥢 중식", "🍣 일식", "🍰 디저트", "🥤 음료"} %>' />
		<c:forEach var="theme" items="${themes}" varStatus="status">
			<div class="col-md-2 col-4">
				<a href="${pageContext.request.contextPath}/theme/list?type=${status.count}">
					<div class="recipe-card border">
						<div class="recipe-card-img-wrap">
							<img class="recipe-card-img"
								src="https://picsum.photos/seed/theme${status.count}/400/400" alt="${theme}">
						</div>
						<div class="recipe-card-body text-center">
							<h6 class="recipe-card-title">${theme}</h6>
						</div>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>
</section>

<!-- ============================================
     카테고리 칩 (빠른 이동)
     ============================================ -->
<section class="section-card text-center">
	<h3 class="section-title justify-content-center mb-4">
		<i class="bi bi-tags-fill text-danger me-2"></i> 카테고리별로 둘러보기
	</h3>
	<div>
		<a href="${pageContext.request.contextPath}/category/list?type=1"
			class="category-chip">🍚 한식</a> <a
			href="${pageContext.request.contextPath}/category/list?type=2"
			class="category-chip">🍝 양식</a> <a
			href="${pageContext.request.contextPath}/category/list?type=3"
			class="category-chip">🥢 중식</a> <a
			href="${pageContext.request.contextPath}/category/list?type=4"
			class="category-chip">🍣 일식</a> <a
			href="${pageContext.request.contextPath}/category/list?type=5"
			class="category-chip">🍰 디저트</a> <a
			href="${pageContext.request.contextPath}/category/list?type=6"
			class="category-chip">🥤 음료</a> <a
			href="${pageContext.request.contextPath}/category/list?type=7"
			class="category-chip">🍢 분식</a> <a
			href="${pageContext.request.contextPath}/category/list"
			class="category-chip">전체보기</a>
	</div>
</section>

