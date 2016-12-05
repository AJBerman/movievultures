<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>Details</title>
<style>
.gold {
	color: #FFD700;
}
</style>
		<%-- ===== MOVIE DETAILS DISPLAY ===== --%>
		<h1><span id="movie-title">${movie.title}</span></h1>
		<sec:authorize access="isAuthenticated()">
			<a href="#" onclick="$('#movie-form').dialog('open')" class="btn btn-primary">Edit
				Movie</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		| <a href="delete?id=${movie.movieId}" class="btn btn-primary">Delete
				Movie</a>
		</sec:authorize>

		<c:if test="${not empty user.username}"> |
			<c:choose>
				<c:when test="${empty userreview}">
					<%--
						<a href="<c:url value="/review/add?id=${movie.movieId}" />"
							class="reviewM btn btn-primary">Review this movie</a>
					--%>
					<a data-user-id="${user.userId}" href="javascript:void(0)"
							class="reviewM btn btn-primary">Review this movie</a>
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
		
		<!-- MOVIE INFORMATION -->
		<div class="panel panel-default">
			<div class="panel-body">
				
				<p>
					<b>Year of Release</b>:
					<span id="movie-date"><fmt:formatDate value="${ movie.date }" pattern="yyyy" /></span>
				</p>

				<br /> <b>Plot</b><br />
				<p>${movie.plot}</p>

				<br />
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Genre${fn:length(movie.genres) > 1 ? 's':''}</b>
					</div>
					<div class="panel-body">
						<c:choose>
							<c:when test="${ not empty movie.genres }">
								<span id="movie-genres">
								<c:forEach items="${movie.genres}" var="genre">
									<ul>
										<li>${genre}</li>
									</ul>
								</c:forEach>
								</span>
							</c:when>
							<c:otherwise>
								<span id="movie-genres">
								Please help by adding Genres to this movie.
								</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Cast</b>
					</div>
					<div class="panel-body">
						<span id="movie-actors">
						<c:forEach items="${movie.actors}" var="c">
							<ul>
								<li>${c}</li>
							</ul>
						</c:forEach>
						</span>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<b>Director${fn:length(movie.directors) > 1 ? 's':''}</b>
					</div>
					<div class="panel-body">
						<span id="movie-directors">
						<c:forEach items="${movie.directors}" var="director">
							<ul>
								<li>${director}</li>
							</ul>
						</c:forEach>
						</span>
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
										<li class="userReview">
											<span id="showUserReview">
											${userreview.user.username} - <span id="userRating"> ${userreview.rating} </span> | <a onclick="editUserReview()"> Changed your mind?</a>
											<br /><span id="userReviewText">${userreview.review}</span><br />
											</span>
											<span id="editUserReview" style="display:none;">
											<form>
											<input type="hidden" value="${userreview.reviewId}" name="reviewId" />
											<fieldset class="rating">
												<input type="radio" id="star5" name="rating" value="5" ${userreview.rating == 5 ? "checked='checked'" : ""} />
												<label class="full" for="star5" title="Awesome - 5 stars"></label>
												<input type="radio" id="star4half" name="rating" value="4.5" ${userreview.rating == 4.5 ? "checked='checked'" : ""} />
												<label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
												<input type="radio" id="star4" name="rating" value="4" ${userreview.rating == 4 ? "checked='checked'" : ""} />
												<label class="full" for="star4" title="Pretty good - 4 stars"></label>
												<input type="radio" id="star3half" name="rating" value="3.5" ${userreview.rating == 3.5 ? "checked='checked'" : ""} />
												<label class="half" for="star3half" title="Meh - 3.5 stars"></label>
												<input type="radio" id="star3" name="rating" value="3" ${userreview.rating == 3 ? "checked='checked'" : ""} />
												<label class="full" for="star3" title="Meh - 3 stars"></label>
												<input type="radio" id="star2half" name="rating" value="2.5" ${userreview.rating == 2.5 ? "checked='checked'" : ""} />
												<label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
												<input type="radio" id="star2" name="rating" value="2" ${userreview.rating == 2 ? "checked='checked'" : ""} />
												<label class="full" for="star2" title="Kinda bad - 2 stars"></label>
												<input type="radio" id="star1half" name="rating" value="1.5" ${userreview.rating == 1.5 ? "checked='checked'" : ""} />
												<label class="half" for="star1half" title="Meh - 1.5 stars"></label>
												<input type="radio" id="star1" name="rating" value="1" ${userreview.rating == 1 ? "checked='checked'" : ""} />
												<label class="full" for="star1" title="Sucks big time - 1 star"></label>
												<input type="radio" id="starhalf" name="rating" value="0.5" ${userreview.rating == 0.5 ? "checked='checked'" : ""} />
												<label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
											</fieldset>
											<br /><br /><textarea name="review">${userreview.review}</textarea><br />
											<a onclick="submitEditedReview()">Done</a> | <a onclick="cancelEditReview()">Cancel</a>
											<br />
											</form>
											</span>
										</li>
									</c:if>
									<c:forEach items="${movie.reviews}" var="r"
										varStatus="varStatus">
										<c:if test="${r.user.username != user.username}">
											<li
												class="review reviewpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')}"
												style="display: none;">
												${r.user.username} - ${r.rating}<br />${r.review}<br />
											</li>
										</c:if>
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

	<div id="movie-form">
		<form>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="movieId" value="${movie.movieId}" />
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Title of the Movie</div>
				<div class="col-xs-10">
					<input class="form-control" type="text" name="title" value="${movie.title}"
						placeholder="Enter title of the movie" /><br />
						<font color="red"><span id="movie-title-errors"></span></font>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Plot</div>
				<div class="col-xs-10">
					<textarea style="width: 50%; height: 300px;" class="form-control"
						placeholder="Enter plot of the movie" name="editmovie_plot"
						>${movie.plot}</textarea>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<input name="date" type="date" value="<fmt:formatDate value="${ movie.date }" pattern="yyyy" />"/><br />
					<font color="red"><span id="movie-date-errors"></span></font>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre(s)</div>
				<div class="col-xs-10">
					<span id="genres">
					<c:forEach items="${movie.genres}" var="genre" varStatus="stat">
						<span id="genre${stat.count}">
						<br />
						<input type="text" placeholder="Horror, Comedy,....." name="editmovie_genres" value="${genre}"/>
						<a onclick="$('#genre${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach> 
					</span>
					<a onclick="addGenre()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast</div>
				<div class="col-xs-10">
					<span id="actors">
					<c:forEach items="${movie.actors}" var="actor" varStatus="stat">
						<span id="actor${stat.count}">
						<br />
						<input type="text" placeholder="Fay Wray, Ronald Reagan,....." name="editmovie_actors" value="${actor}"/>
						<a onclick="$('#actor${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach>
					</span>
					<a onclick="addActor()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s)</div>
				<div class="col-xs-10">
					<span id="directors">
					<c:forEach items="${movie.directors}" var="director" varStatus="stat">
						<span id="director${stat.count}">
						<br />
						<input type="text" placeholder="Wes Anderson, Woody Allen,....." name="editmovie_directors" value="${director}"/>
						<a onclick="$('#director${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach>
					</span>
					<a onclick="addDirector()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
		</form>
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
<script>
function addGenre() {
	var id = Date.now()
	$('#genres').append( '<span id="genre' + id + '"><br /><input type="text" placeholder="Horror, Comedy,....." name="editmovie_genres""/> <a onclick="$(\'#genre' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addActor() {
	var id = Date.now()
	$('#actors').append( '<span id="actor' + id + '"><br /><input type="text" placeholder="Fay Wray, Ronald Reagan,....." name="editmovie_actors""/> <a onclick="$(\'#actor' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addDirector() {
	var id = Date.now()
	$('#directors').append( '<span id="director' + id + '"><br /><input type="text" placeholder="Wes Anderson, Woody Allen,....." name="editmovie_directors"/> <a onclick="$(\'#director' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function editMovie() {
    $.ajax({
        url: "edit",
        method: "POST",
        processData: false,
        data: $("#movie-form > form").serialize(),
        success: function() {
        	console.log("post success!");
        	$("#movie-title").text($("input[name='title']").val());
        	$("#movie-date").text($("input[name='date']").val());
        	$("#movie-plot").text($("input[name='editmovie_plot']").val());
        	$("#movie-genres").html("");
        	$("[name='editmovie_genres']").each(function(k,v) {
        		console.log($(v));
        		if($(v).val() != "") {
            		$("#movie-genres").append("<ul><li>"+$(v).val()+"</li></ul>");
        		}
        	})
        	$("#movie-actors").html("");
        	$("[name='editmovie_actors']").each(function(k,v) {
        		console.log($(v));
        		if($(v).val() != "") {
            		$("#movie-actors").append("<ul><li>"+$(v).val()+"</li></ul>");
        		}
        	})
        	$("#movie-directors").html("");
        	$("[name='editmovie_directors']").each(function(k,v) {
        		console.log($(v));
        		if($(v).val() != "") {
            		$("#movie-directors").append("<ul><li>"+$(v).val()+"</li></ul>");
        		}
        	})
        },
        error: function() {
        	console.log("post error!");
        }
    });
}
function editUserReview() {
	$("#showUserReview").detach().insertAfter($("#editUserReview")).hide(); //yes, seriously. I can't figure out how to fully hide it, it's adding whitespace even when hidden.
	$("#editUserReview").show();
}
function submitEditedReview() {
    $.ajax({
        url: "../review/editajax",
        method: "POST",
        processData: false,
        data: $("#editUserReview > form").serialize(),
        success: function() {
        	$("#showUserReview").detach().insertAfter($("#editUserReview")).fadeIn("slow"); //yes, seriously. I can't figure out how to fully hide it, it's adding whitespace even when hidden.
        	console.log($("fieldset > input:checked"));
        	$("#userRating").text($("fieldset > input:checked").val());
        	$("#userReviewText").text($("textarea[name='review']").val());
        	$("#editUserReview").hide();
        },
        error: function() {
        	alert("Failed to update review. Try again?");
        }
    });
}
function cancelEditReview() {
	$("#showUserReview").detach().insertBefore($("#editUserReview")).fadeIn("slow"); 
	$("#editUserReview").hide();
}
$("#movie-form").dialog({
	autoOpen: false,
    buttons: {
        "Save": function(){
        	editMovie();
            $(this).dialog( "close" );
        }
    },
    minWidth: 640,
    width: 800
});
</script>
</body>
</html>

