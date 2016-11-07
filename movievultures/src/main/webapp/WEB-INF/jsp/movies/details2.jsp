<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Details</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
var current_page_reviews = 1;
var records_per_page = 10;

function changePageBy(num) {
	if(current_page_reviews+num >= 1 && current_page_reviews+num <= numPagesReviews()) {
		current_page_reviews += num;
        changePageReviews(current_page_reviews);
	}
}

function changePageReviews(page)
{
    // Validate page
    if (page < 1) page = 1;
    if (page > numPagesReviews()) page = numPagesReviews();

    $(".review").hide();
	$(".reviewpage"+page).filter(":not(.userReview)").show();
    $("#reviewpageno").html(page);
    for(var i = 1; i <= 4; i++) {
    	if(page-i >= 1) {
    		$("#reviewpageno-"+i).show().html(page-i);
    		
    	} else {
    		$("#reviewpageno-"+i).hide();
    	}
    	console.log($("#reviewpageno"+i));
    	if(page+i <= numPagesReviews()) {
    		$("#reviewpageno"+i).show().html(page+i);
    	} else {
    		$("#reviewpageno"+i).hide();
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

function numPagesReviews()
{
	console.log(Math.ceil($("#reviews > li").length / records_per_page));
    return Math.ceil($("#reviews > li").length / records_per_page);
}

window.onload = function() {
	changePageReviews(1);
};</script>
</head>

<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="../user/register.html">Register</a> |
			<a href= "<c:url value='/login'/>"  >Login</a>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">Management</a>
		</sec:authorize>
	</p>
	
	<jsp:include page="../search/searchMovies2.jsp" />
	<p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>
	

	<%-- ===== MOVIE DETAILS DISPLAY ===== --%>
	<h1>${movie.title}</h1>
		
	<sec:authorize access = "isAuthenticated()">
		<a href="edit.html?id=${movie.movieId}" class="btn btn-primary">Edit Movie</a>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		| <a href="delete.html?id=${movie.movieId}" class="btn btn-primary">Delete Movie</a>
	</sec:authorize>

	<c:if test="${not empty user.username}"> |
		<c:choose>
			<c:when test="${empty userreview}">
				<a href="../review/add.html?id=${movie.movieId}">Review this movie</a>
			</c:when>
			<c:otherwise>
				<a href="../review/edit.html?id=${movie.movieId}">Edit your review</a>
			</c:otherwise>
		</c:choose> |
		<a href="../elo/add.html?movie1=${movie.movieId}">Elo rate this movie</a> |
		<a href="../user/addFav.html?movieId=${movie.movieId}">Add to Favorites?</a> |
		<a href="../user/addWL.html?movieId=${movie.movieId}">Add to WatchList?</a> 
	</c:if>
				
	<p><b>Year of Release</b>: <fmt:formatDate value="${ movie.date }" pattern="yyyy" /></p>
				
	<br /><b>Plot</b><br />
	<p>${movie.plot}</p>
		
	<br /><b>Genre</b><br />
	<c:choose>
		<c:when test="${ not empty movie.genres }">
			<c:forEach items="${movie.genres}" var="genre">
				<ul><li>${genre}</li></ul>
			</c:forEach>
		</c:when>
		<c:otherwise>
			Please help by adding Genres to this movie.
		</c:otherwise>
	</c:choose>
	
	<br /><b>Cast</b><br />
		<c:forEach items="${movie.actors}" var="c">
			<ul><li>${c}</li></ul>
		</c:forEach>
	<br /> 
		
	<br /><b>Director(s)</b><br />
		<c:forEach items="${movie.directors}" var="director">
			<ul><li>${director}</li></ul>
		</c:forEach>
	<br />
	
	<p><b>================================</b><br />
	   <b>===== RATINGS AND REVIEWS =====</b><br />
	   <b>================================</b></p>
	
	<c:set var="sum" value="0" />
	<c:forEach items="${ movie.reviews }" var="r">
		<c:set var="sum" value="${ sum + r.rating }" />
	</c:forEach>
	<b>Total User Rating</b>: <fmt:formatNumber type="number" maxFractionDigits="2" value="${sum/fn:length(movie.reviews)}"/><br />

	<c:choose>
		<c:when test="${ not empty movie.reviews }">
			<!-- Client-Side Pagination. This is "bad" in some regards, but it's much simpler to implement. This was tested up to 10,000 reviews and works "okay" at that point (2 mb page weight and 5-ish second load time). We don't expect to have anywhere near 10,000 reviews any time soon. -->
			<br /><b>User Reviews</b><br />
			<ul id="reviews">
			<c:if test="${not empty userreview}">
				  <li>
				  ${user.username} - ${userreview.rating} | <a href="../review/edit.html?id=${movie.movieId}"> Changed your mind?</a>
				  <br />
				  ${userreview.review}<br />
				  </li>
			</c:if>
			<c:forEach items="${movie.reviews}" var="r" varStatus="varStatus">
				  <li class="review reviewpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} ${r.user.username == user.username ? 'userReview' : ''}" style="display: none;">
				  ${r.user.username} - ${r.rating}
				  <c:if test="${r.user.username == user.username}">
				  	 | <a href="../review/edit.html?id=${movie.movieId}"> Changed your mind?</a>
				  </c:if>
				  <br />
				  ${r.review}<br />
				  </li>
			</c:forEach>
			</ul>
			<a href="javascript:changePageBy(-1)" id="review_btn_prev">Prev</a>
			<a href="javascript:changePageBy(-4)" id="reviewpageno-4" style="display: none;"></a>
			<a href="javascript:changePageBy(-3)" id="reviewpageno-3" style="display: none;"></a>
			<a href="javascript:changePageBy(-2)" id="reviewpageno-2" style="display: none;"></a>
			<a href="javascript:changePageBy(-1)" id="reviewpageno-1" style="display: none;"></a>
			<a id="reviewpageno"></a>
			<a href="javascript:changePageBy(1)" id="reviewpageno1" style="display: none;"></a>
			<a href="javascript:changePageBy(2)" id="reviewpageno2" style="display: none;"></a>
			<a href="javascript:changePageBy(3)" id="reviewpageno3" style="display: none;"></a>
			<a href="javascript:changePageBy(4)" id="reviewpageno4" style="display: none;"></a>
			<a href="javascript:changePageBy(1)" id="review_btn_next">Next</a>
		</c:when>
		<c:otherwise>
			There are no Reviews available for this movie.
		</c:otherwise>
	</c:choose>
	
	<p><b>Total Elo Rating Score</b>: <fmt:formatNumber value="${movie.eloRating}" type="number" maxFractionDigits="0"/></p>

	<c:choose>
		<c:when test="${ not empty eloratings }">
			<tr><th><b>Elo Ratings</b></th></tr>
			<c:forEach items="${eloratings}" var="r">
					<tr><td>${movie.title}</td>
					<c:choose>
						<c:when test="${r.winner.movieId == movie.movieId}">
						<td> > </td><td><a href="${r.loser.movieId}">${r.loser.title}</a></td>
					</c:when>    
					<c:otherwise>
						<td> < </td><td><a href="${r.winner.movieId}">${r.winner.title}</a></td>
					</c:otherwise>
					</c:choose>
					<td> - <i>Rated By: ${r.user.username}</i></td></tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			There are no Elo Ratings avaliable for this movie.
		</c:otherwise>
	</c:choose>

</body>
</html>