<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menu" value="main" scope="request" />

<!-- ============================================
     히어로 배너
     ============================================ -->
<section class="section-card position-relative p-0 overflow-hidden">
	<div class="hero-banner">
		<h2>
			<span class="highlight">おうち</span>レシピを教えてください
		</h2>
		<p>おうちシェフと一緒においしい一品をシェアしよう！</p>
	</div>
</section>

<!-- ============================================
     별점 높은 레시피
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-star-fill text-danger me-2"></i> <span class="accent">高評価</span>&nbsp;レシピ
		</h3>
		<a href="${pageContext.request.contextPath}/category/list" class="btn-more">
			もっと見る <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<div class="carousel-container">
		<button class="carousel-arrow prev" type="button" aria-label="前へ"><i class="bi bi-chevron-left"></i></button>
		<button class="carousel-arrow next" type="button" aria-label="次へ"><i class="bi bi-chevron-right"></i></button>
		<div class="carousel-viewport">
			<div class="carousel-track">
				<c:choose>
					<c:when test="${not empty topRatedRecipes}">
						<c:forEach var="r" items="${topRatedRecipes}" varStatus="status">
							<div class="slide-item">
								<a href="${pageContext.request.contextPath}/recipe/view?id=${r.recipeId}">
									<div class="recipe-card">
										<div class="recipe-card-img-wrap">
											<span class="rank-badge">TOP ${status.count}</span>
											<c:choose>
												<c:when test="${not empty r.thumbnail}">
													<img class="recipe-card-img" src="${pageContext.request.contextPath}${r.thumbnail}" alt="${r.title}">
												</c:when>
												<c:otherwise>
													<img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=No+Image" alt="${r.title}">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="recipe-card-body">
											<h6 class="recipe-card-title">${r.title}</h6>
											<div class="recipe-meta">
												<span class="rating"><i class="bi bi-star-fill"></i>
													<c:choose>
														<c:when test="${r.avgRating != null}"><fmt:formatNumber value="${r.avgRating}" pattern="0.0"/></c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</span>
												<span><i class="bi bi-eye"></i> ${r.viewCount}</span>
												<span><i class="bi bi-person"></i> ${r.nickname}</span>
											</div>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="slide-item" style="min-width:100%">
							<div class="text-center text-muted py-4">まだ評価済みレシピがありません。</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<!-- ============================================
     최신 레시피
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-clock-fill text-danger me-2"></i> <span class="accent">最新</span>&nbsp;レシピ
		</h3>
		<a href="${pageContext.request.contextPath}/category/list" class="btn-more">
			もっと見る <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<div class="carousel-container">
		<button class="carousel-arrow prev" type="button" aria-label="前へ"><i class="bi bi-chevron-left"></i></button>
		<button class="carousel-arrow next" type="button" aria-label="次へ"><i class="bi bi-chevron-right"></i></button>
		<div class="carousel-viewport">
			<div class="carousel-track">
				<c:choose>
					<c:when test="${not empty latestRecipes}">
						<c:forEach var="r" items="${latestRecipes}">
							<div class="slide-item">
								<a href="${pageContext.request.contextPath}/recipe/view?id=${r.recipeId}">
									<div class="recipe-card">
										<div class="recipe-card-img-wrap">
											<c:choose>
												<c:when test="${not empty r.thumbnail}">
													<img class="recipe-card-img" src="${pageContext.request.contextPath}${r.thumbnail}" alt="${r.title}">
												</c:when>
												<c:otherwise>
													<img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=No+Image" alt="${r.title}">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="recipe-card-body">
											<h6 class="recipe-card-title">${r.title}</h6>
											<div class="recipe-meta">
												<span class="rating"><i class="bi bi-star-fill"></i>
													<c:choose>
														<c:when test="${r.avgRating != null}"><fmt:formatNumber value="${r.avgRating}" pattern="0.0"/></c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</span>
												<span><i class="bi bi-eye"></i> ${r.viewCount}</span>
												<span><i class="bi bi-clock"></i> <fmt:formatDate value="${r.createdAt}" pattern="MM.dd"/></span>
											</div>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="slide-item" style="min-width:100%">
							<div class="text-center text-muted py-4">レシピがありません。</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<!-- ============================================
     인기 셰프 랭킹 (레시피 평점 평균순)
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-4">
		<h3 class="section-title">
			<i class="bi bi-trophy-fill text-danger me-2"></i> <span class="accent">人気</span>&nbsp;シェフランキング
		</h3>
		<a href="${pageContext.request.contextPath}/ranking/daily#chef" class="btn-more">
			もっと見る <i class="bi bi-chevron-right"></i>
		</a>
	</div>

	<div class="carousel-container">
		<button class="carousel-arrow prev" type="button" aria-label="前へ"><i class="bi bi-chevron-left"></i></button>
		<button class="carousel-arrow next" type="button" aria-label="次へ"><i class="bi bi-chevron-right"></i></button>
		<div class="carousel-viewport">
			<div class="carousel-track">
				<c:choose>
					<c:when test="${not empty chefRanking}">
						<c:forEach var="chef" items="${chefRanking}" varStatus="status">
							<div class="slide-item">
								<a href="${pageContext.request.contextPath}/chef/profile?userId=${chef.userId}">
									<div class="chef-card">
										<div class="chef-avatar-wrap">
											<span class="chef-rank-badge">${status.count}</span>
											<c:choose>
												<c:when test="${not empty chef.profileImg}">
													<img class="chef-avatar" src="${pageContext.request.contextPath}${chef.profileImg}" alt="${chef.nickname}">
												</c:when>
												<c:otherwise>
													<img class="chef-avatar" src="https://placehold.co/180x180/dee2e6/6c757d?text=Chef" alt="${chef.nickname}">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="chef-name">${chef.nickname}</div>
										<div class="chef-stat">
											レシピ <strong class="text-danger">${chef.recipeCount}</strong>件 · 評価
											<strong class="text-danger">
												<c:choose>
													<c:when test="${chef.avgRating != null}"><fmt:formatNumber value="${chef.avgRating}" pattern="0.0"/></c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
											</strong>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="slide-item" style="min-width:100%">
							<div class="text-center text-muted py-4">ランキングデータがありません。</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<!-- ============================================
     추천 테마
     ============================================ -->
<section class="section-card position-relative">
	<div class="d-flex justify-content-between align-items-center mb-1">
		<h3 class="section-title">
			<i class="bi bi-bookmark-fill text-danger me-2"></i> <span class="accent">おすすめ</span>&nbsp;テーマ
		</h3>
		<a href="${pageContext.request.contextPath}/theme/list" class="btn-more">
			もっと見る <i class="bi bi-chevron-right"></i>
		</a>
	</div>
	<p class="text-muted mb-4">シェフたちがおすすめするテーマ別レシピをご覧ください！</p>

	<div class="carousel-container">
		<button class="carousel-arrow prev" type="button" aria-label="前へ"><i class="bi bi-chevron-left"></i></button>
		<button class="carousel-arrow next" type="button" aria-label="次へ"><i class="bi bi-chevron-right"></i></button>
		<div class="carousel-viewport">
			<div class="carousel-track">
				<c:choose>
					<c:when test="${not empty themes}">
						<c:forEach var="theme" items="${themes}">
							<div class="slide-item">
								<a href="${pageContext.request.contextPath}/theme/view?themeId=${theme.themeId}">
									<div class="recipe-card border">
										<div class="recipe-card-img-wrap">
											<c:choose>
												<c:when test="${not empty theme.thumbnail}">
													<img class="recipe-card-img" src="${pageContext.request.contextPath}${theme.thumbnail}" alt="${theme.title}">
												</c:when>
												<c:otherwise>
													<img class="recipe-card-img" src="https://placehold.co/400x400/dee2e6/6c757d?text=No+Image" alt="${theme.title}">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="recipe-card-body text-center">
											<h6 class="recipe-card-title">${theme.title}</h6>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="slide-item" style="min-width:100%">
							<div class="text-center text-muted py-4">テーマがありません。</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

