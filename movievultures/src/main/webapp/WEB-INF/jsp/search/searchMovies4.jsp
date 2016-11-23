<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>

<!-- For search highlighting -->
<style>
mark {
	background: yellow;
}
.marked {
	background: yellow;
}
.hidden {
	display: none;
}
.gold {
	color: #FFD700;
}
</style>

<%-- Calculating none hidden results --%>
<div class="container">
	<c:set var="res" value="0" />
	<c:forEach items="${ movieResults }" var="movieResult">
		<c:if test="${ !movieResult.hidden }">
			<c:set var="res" value="${ res + 1 }" />
		</c:if>
	</c:forEach>
	
	<h2>MOVIE RESULTS: ${ res } result(s)</h2>
	<c:choose>
		<c:when test="${type != 'random movies'}">
			<h4>
				Where <span id="searchResultType">${type}</span> <span
					id="comparator">${comparator}</span> <span id="searchResultTerm">${searchTerm}</span>
			</h4>
		</c:when>
		<c:otherwise>
			<h4>
				Where movie search is <span id="searchResultType">${type}</span>
			</h4>
		</c:otherwise>
	</c:choose>
	
	<br />
	<div class="panel panel-default">
		<div class="panel-body">	
			<c:choose>
				<c:when test="${ not empty movieResults }">
					<ul id="results">
					<c:forEach items="${ movieResults }" var="movieResult" varStatus="varStatus">
						<c:if test="${ !movieResult.hidden }">
							<li class="${varStatus.count <= 20 ? '' : 'hidden '}search searchpage${fn:replace(((varStatus.count/20)-((varStatus.count/20)%1)+1),'.0','')}">
								<c:if test="${ not empty headlines }">
									<span>...${headlines[varStatus.count-1]}...</span><br/>
								</c:if>
								<b>Movie Title</b>: <a class="movieTitle" href="../movies/details2.html?id=${ movieResult.movieId }">${ movieResult.title }</a><br />
								<b>Year of Release</b>: <span class="movieYear"><fmt:formatDate value="${ movieResult.date }" pattern="yyyy" /></span><br />
								<b>Total Elo Rating</b>: <span class="movieElo"><fmt:formatNumber type="number" maxFractionDigits="2" value="${movieResult.eloRating}"/></span><br />
								
								<c:set var="sum" value="0" />
								<c:forEach items="${ movieResult.reviews }" var="r">
									<c:set var="sum" value="${ sum + r.rating }" />
								</c:forEach>
								<c:set var="rating" value="${sum/fn:length(movieResult.reviews)}" />
								<span class="movieRating" title="${rating}">
									<c:choose>
										<c:when test="${ not empty movieResult.reviews }">
											<b>User Rating</b>: 
											<c:forEach begin="1" end="${rating-rating%0.01}" varStatus="loop">
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
								<!-- c:url is used here to url-encode the genre/director/actor, so if their name is "null&illegalargument=foo" we don't get funny business. -->
								<b>Genre${fn:length(movieResult.genres) > 1 ? 's':''}</b>: <c:forEach items="${ movieResult.genres }" var="g" varStatus="stat"> <span class="movieGenre">
									<c:url value="searchMovies4.html" var="myURL">
									   <c:param name="searchTerm" value="${g}"/>
									   <c:param name="type" value="2"/>
									   <c:param name="comparator" value="3"/>
									</c:url>
									<a href="${myURL}">${g}</a>
								</span> ${stat.last ? '' : '|'}</c:forEach><br />
								<b>Director${fn:length(movieResult.directors) > 1 ? 's':''}</b>: <c:forEach items="${ movieResult.directors }" var="d" varStatus="stat"> <span class="movieDirector">
									<c:url value="searchMovies4.html" var="myURL">
									   <c:param name="searchTerm" value="${d}"/>
									   <c:param name="type" value="3"/>
									   <c:param name="comparator" value="3"/>
									</c:url>
									<a href="${myURL}">${d}</a>
								</span> ${stat.last ? '' : '|'}</c:forEach><br />
								<b>Artist${fn:length(movieResult.actors) > 1 ? 's':''}</b>: <c:forEach items="${ movieResult.actors }" var="a" varStatus="stat"> <span class="movieActor">
									<c:url value="searchMovies4.html" var="myURL">
									   <c:param name="searchTerm" value="${a}"/>
									   <c:param name="type" value="4"/>
									   <c:param name="comparator" value="3"/>
									</c:url>
									<a href="${myURL}">${a}</a>
								</span> ${stat.last ? '' : '|'}</c:forEach><br />
								<br />
								<b>===== Short Plot Summary =====</b><br />
									<span class="moviePlot">${movieResult.plot}</span>
								<br />
								<br />
								<hr>
								<br />
							</li>
						</c:if>
					</c:forEach>
					</ul>
					<a href="javascript:changePageBy(-1)" id="search_btn_prev">Prev</a>
					<a href="javascript:changePageBy(-4)" id="searchpageno-4" style="display: none;"></a>
					<a href="javascript:changePageBy(-3)" id="searchpageno-3" style="display: none;"></a>
					<a href="javascript:changePageBy(-2)" id="searchpageno-2" style="display: none;"></a>
					<a href="javascript:changePageBy(-1)" id="searchpageno-1" style="display: none;"></a>
					<a id="searchpageno"></a>
					<a href="javascript:changePageBy(1)" id="searchpageno1" style="display: none;"></a>
					<a href="javascript:changePageBy(2)" id="searchpageno2" style="display: none;"></a>
					<a href="javascript:changePageBy(3)" id="searchpageno3" style="display: none;"></a>
					<a href="javascript:changePageBy(4)" id="searchpageno4" style="display: none;"></a>
					<a href="javascript:changePageBy(1)" id="search_btn_next">Next</a>
				</c:when>
				<c:otherwise>
					No results were found.
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
	var current_page_reviews = 1;
	var records_per_page = 20;

	function changePageBy(num) {
		if (current_page_reviews + num >= 1
				&& current_page_reviews + num <= numPagesReviews()) {
			current_page_reviews += num;
			changePageReviews(current_page_reviews);
		}
	}

	function changePageReviews(page) {
		// Validate page
		if (page < 1)
			page = 1;
		if (page > numPagesReviews())
			page = numPagesReviews();

		$(".search").hide();
		$(".searchpage" + page).show();
		$("#searchpageno").html(page);
		for (var i = 1; i <= 4; i++) {
			if (page - i >= 1) {
				$("#searchpageno-" + i).show().html(page - i);

			} else {
				$("#searchpageno-" + i).hide();
			}
			console.log($("#searchpageno" + i));
			if (page + i <= numPagesReviews()) {
				$("#searchpageno" + i).show().html(page + i);
			} else {
				$("#searchpageno" + i).hide();
			}
		}

		if (page == 1) {
			$("#search_btn_prev").hide();
		} else {
			$("#search_btn_prev").show();
		}

		if (page == numPagesReviews()) {
			$("#search_btn_next").hide();
		} else {
			$("#search_btn_next").show();
		}
	}

	function numPagesReviews() {
		console.log(Math.ceil($("#results > li").length / records_per_page));
		return Math.ceil($("#results > li").length / records_per_page);
	}

	window.onload = function() {
		$(".hidden").removeClass("hidden");
		changePageReviews(1);
	};
</script>

<script src="/movievultures/res/js/jquery-3.1.1.min.js"></script>
<!-- For search highlighting -->
<script src="/movievultures/res/js/jquery.mark.js"></script>
<!-- For search highlighting -->
<script>
	//at the bottom so it can mutate existing text.
	$(document).ready(function() {
		console.log($("#searchResultTerm").text());
		switch ($("#searchResultType").text()) {
		case "title":
			$(".movieTitle").mark($("#searchResultTerm").text(), {
				diacritics : false
			});
			break;
		case "genre":
			$(".movieGenre").mark($("#searchResultTerm").text(), {
				diacritics : false
			});
			break;
		case "director":
			$(".movieDirector").mark($("#searchResultTerm").text(), {
				diacritics : false
			});
			break;
		case "actor":
			$(".movieActor").mark($("#searchResultTerm").text(), {
				diacritics : false
			});
			break;
		case "year of release":
			$(".movieYear").addClass("marked");
			break;
		case "user rating":
			$(".movieRating").addClass("marked");
			break;
		case "Elo rating":
			$(".movieElo").addClass("marked");
			break;
		default:
			$(".search").mark($("#searchResultTerm").text(), {
				diacritics : false
			});
			break;
		}
	});
</script>