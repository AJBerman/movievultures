<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.gold {
	color: #FFD700;
}
</style>
		<%-- ===== MOVIE DETAILS DISPLAY ===== --%>

		<h1>${movie.title}</h1>

		<sec:authorize access="isAuthenticated()">
			<a href="edit?id=${movie.movieId}" class="btn btn-primary">Edit
				Movie</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		| <a href="delete?id=${movie.movieId}" class="btn btn-primary">Delete
				Movie</a>
		</sec:authorize>

		<c:if test="${not empty user.username}"> |
		<c:choose>
				<c:when test="${empty userreview}">
					<a href="<c:url value="/review/add?id=${movie.movieId}" />"
						class="btn btn-primary">Review this movie</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value="/review/edit?id=${movie.movieId}" />"
						class="btn btn-primary">Edit your review</a>
				</c:otherwise>
			</c:choose> |
		<a href="<c:url value="/elo/add?movie1=${movie.movieId}" />"
				class="btn btn-primary">Elo rate this movie</a> |
		<a href="<c:url value="/user/addFav?movieId=${movie.movieId}" />"
				class="btn btn-primary">Add to Favorites?</a> |
		<a href="<c:url value="/user/addWL?movieId=${movie.movieId}" />"
				class="btn btn-primary">Add to WatchList?</a>
		</c:if>
		<br /> <br />
		<div class="panel panel-default">
			<div class="panel-body">

				<p>
					<b>Year of Release</b>:
					<fmt:formatDate value="${ movie.date }" pattern="yyyy" />
				</p>

				<br /> <b>Plot</b><br />
				<p>${movie.plot}</p>

				<br />
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Genre${fn:length(movie.genres) > 1 ? 's':''}</b>
					</div>
					<div class="pabel-body">
						<c:choose>
							<c:when test="${ not empty movie.genres }">
								<c:forEach items="${movie.genres}" var="genre">
									<ul>
										<li>${genre}</li>
									</ul>
								</c:forEach>
							</c:when>
							<c:otherwise>
							Please help by adding Genres to this movie.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Cast</b>
					</div>
					<div class="panel-body">
						<c:forEach items="${movie.actors}" var="c">
							<ul>
								<li>${c}</li>
							</ul>
						</c:forEach>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Director${fn:length(movie.directors) > 1 ? 's':''}</b>
					</div>
					<div class="panel-body">
						<c:forEach items="${movie.directors}" var="director">
							<ul>
								<li>${director}</li>
							</ul>
						</c:forEach>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>RATINGS AND REVIEWS</b>
					</div>
					<div class="panel-body">
						<c:set var="sum" value="0" />
						<c:forEach items="${ movie.reviews }" var="r">
							<c:set var="sum" value="${ sum + r.rating }" />
						</c:forEach>
						<c:set var="rating" value="${sum/fn:length(movie.reviews)}" />
						<span title="${rating-rating%0.01}"><c:choose>
							<c:when test="${ not empty movie.reviews }">
								<b>User Rating</b>: 
								<c:forEach begin="1" end="${rating}" varStatus="loop">
   									<i class="fa fa-star gold" aria-hidden="true"></i>
								</c:forEach>
								<c:choose>
									<c:when test="${rating%1 >= 0.66}">
    									<i class="fa fa-star gold" aria-hidden="true"></i>
									</c:when>
									<c:when test="${rating%1 >= 0.33}">
    									<i class="fa fa-star-half-o gold" aria-hidden="true"></i>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<b>User Rating</b>: Unrated. Be the first to review this!
							</c:otherwise>
						</c:choose>
						</span><br />
						<c:choose>
							<c:when test="${ not empty movie.reviews }">
								<!-- Client-Side Pagination. This is "bad" in some regards, but it's much simpler to implement. This was tested up to 10,000 reviews and works "okay" at that point (2 mb page weight and 5-ish second load time). We don't expect to have anywhere near 10,000 reviews any time soon. -->
								<br />
								<b>User Reviews</b>
								<br />
								<ul id="reviews">
									<c:if test="${not empty userreview}">
										<li>${user.username}-${userreview.rating}|<a
											href="<c:url value="/review/edit?id=${movie.movieId}" />"> Changed
												your mind?</a> <br /> ${userreview.review}<br />
										</li>
									</c:if>
									<c:forEach items="${movie.reviews}" var="r"
										varStatus="varStatus">
										<li
											class="review reviewpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} ${r.user.username == user.username ? 'userReview' : ''}"
											style="${r.user.username == user.username ? '' : 'display: none;'}">
											${r.user.username} - ${r.rating} <c:if
												test="${r.user.username == user.username}">
				  	 | <a href="<c:url value="/review/edit?id=${movie.movieId}" />"> Changed
													your mind?</a>
											</c:if> <br /> ${r.review}<br />
										</li>
									</c:forEach>
								</ul>
								<a href="javascript:changePageBy(-1)" id="review_btn_prev">Prev</a>
								<a href="javascript:changePageBy(-4)" id="reviewpageno-4"
									style="display: none;"></a>
								<a href="javascript:changePageBy(-3)" id="reviewpageno-3"
									style="display: none;"></a>
								<a href="javascript:changePageBy(-2)" id="reviewpageno-2"
									style="display: none;"></a>
								<a href="javascript:changePageBy(-1)" id="reviewpageno-1"
									style="display: none;"></a>
								<a id="reviewpageno"></a>
								<a href="javascript:changePageBy(1)" id="reviewpageno1"
									style="display: none;"></a>
								<a href="javascript:changePageBy(2)" id="reviewpageno2"
									style="display: none;"></a>
								<a href="javascript:changePageBy(3)" id="reviewpageno3"
									style="display: none;"></a>
								<a href="javascript:changePageBy(4)" id="reviewpageno4"
									style="display: none;"></a>
								<a href="javascript:changePageBy(1)" id="review_btn_next">Next</a>
							</c:when>
							<c:otherwise>
								There are no Reviews available for this movie.
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Total Elo Rating Score</b>:
						<fmt:formatNumber value="${movie.eloRating}" type="number"
							maxFractionDigits="0" />
					</div>
					<div class="panel-body">
						<c:choose>
							<c:when test="${ not empty eloratings }">
								<table>
									<tr>
										<th><b>Elo Ratings</b></th>
									</tr>
									<c:forEach items="${eloratings}" var="r" varStatus="varStatus">
										<tr
											class="elo elopage${fn:replace(((varStatus.count/50)-((varStatus.count/50)%1)+1),'.0','')} ${r.user.username == user.username ? 'userElo' : ''}"
											style="display: none;">
											<td>${movie.title}</td>
											<c:choose>
												<c:when test="${r.winner.movieId == movie.movieId}">
													<td> > </td>
													<td><a href="<c:url value="details2?id=${r.loser.movieId}" />">${r.loser.title}</a></td>
												</c:when>
												<c:otherwise>
													<td> < </td>
													<td><a href="<c:url value="details2?id=${r.winner.movieId}" />">${r.winner.title}</a></td>
												</c:otherwise>
											</c:choose>
											<td>- <i>Rated By: ${r.user.username}</i></td>
										</tr>
									</c:forEach>
								</table>
								<a href="javascript:changeEloPageBy(-1)" id="elo_btn_prev">Prev</a>
								<a href="javascript:changeEloPageBy(-4)" id="elopageno-4"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(-3)" id="elopageno-3"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(-2)" id="elopageno-2"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(-1)" id="elopageno-1"
									style="display: none;"></a>
								<a id="elopageno"></a>
								<a href="javascript:changeEloPageBy(1)" id="elopageno1"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(2)" id="elopageno2"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(3)" id="elopageno3"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(4)" id="elopageno4"
									style="display: none;"></a>
								<a href="javascript:changeEloPageBy(1)" id="elo_btn_next">Next</a>
							</c:when>
							<c:otherwise>
								There are no Elo Ratings avaliable for this movie.
							</c:otherwise>
						</c:choose>
					</div>
				</div>


			</div>
		</div>
	</div>
	
<script>
	var current_page_reviews = 1;
	var records_per_page = 10;
	var current_page_elo = 1;
	var records_per_page_elo = 50;

	function changePageBy(num) {
		if (current_page_reviews + num >= 1
				&& current_page_reviews + num <= numPagesReviews()) {
			current_page_reviews += num;
			changePageReviews(current_page_reviews);
		}
	}
	function changeEloPageBy(num) {
		if (current_page_elo + num >= 1
				&& current_page_elo + num <= numPagesElo()) {
			current_page_elo += num;
			changePageElo(current_page_elo);
		}
	}

	function changePageReviews(page) {
		// Validate page
		if (page < 1)
			page = 1;
		if (page > numPagesReviews())
			page = numPagesReviews();

		$(".review").hide();
		$(".reviewpage" + page).filter(":not(.userReview)").show();
		$("#reviewpageno").html(page);
		for (var i = 1; i <= 4; i++) {
			if (page - i >= 1) {
				$("#reviewpageno-" + i).show().html(page - i);

			} else {
				$("#reviewpageno-" + i).hide();
			}
			console.log($("#reviewpageno" + i));
			if (page + i <= numPagesReviews()) {
				$("#reviewpageno" + i).show().html(page + i);
			} else {
				$("#reviewpageno" + i).hide();
			}
		}

		if (page == 1) {
			$("#review_btn_prev").hide();
		} else {
			$("#review_btn_prev").show();
		}

		if (page == numPagesReviews()) {
			$("#review_btn_next").hide();
		} else {
			$("#review_btn_next").show();
		}
	}

	function changePageElo(page) {
		// Validate page
		if (page < 1)
			page = 1;
		if (page > numPagesReviews())
			page = numPagesElo();

		$(".elo").filter(":not(.userElo)").hide();
		$(".elopage" + page).show();
		$("#elopageno").html(page);
		for (var i = 1; i <= 4; i++) {
			if (page - i >= 1) {
				$("#elopageno-" + i).show().html(page - i);

			} else {
				$("#elopageno-" + i).hide();
			}
			console.log($("#elopageno" + i));
			if (page + i <= numPagesElo()) {
				$("#elopageno" + i).show().html(page + i);
			} else {
				$("#elopageno" + i).hide();
			}
		}

		if (page == 1) {
			$("#elo_btn_prev").hide();
		} else {
			$("#elo_btn_prev").show();
		}

		if (page == numPagesElo()) {
			$("#elo_btn_next").hide();
		} else {
			$("#elo_btn_next").show();
		}
	}

	function numPagesReviews() {
		console.log(Math.ceil($("#reviews > li").length / records_per_page));
		return Math.ceil($("#reviews > li").length / records_per_page);
	}

	function numPagesElo() {
		console.log(Math.ceil($(".elo").length / records_per_page));
		return Math.ceil($(".elo").length / records_per_page);
	}

	window.onload = function() {
		changePageReviews(1);
		changePageElo(1);
	};
</script>