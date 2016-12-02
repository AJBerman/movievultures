<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<div class="container">
	<h2>Welcome ${user.username}</h2>
	
	<h3>Profile:</h3> <a href="profile.html?userId=${user.userId}">Edit Profile</a>
	
	<table class="table table-bordered table-striped table-hover">
		<tr><th>Member #: </th><td>${user.userId }</td></tr>
		<tr><th>Username:</th> <td>${user.username}</td></tr>
		<tr><th>e-mail: </th><td>${user.email}</td></tr>
	</table>
	
	<div id=toggles>
	<h3>Recommendations:</h3>
		<div>
		<c:if test="${empty user.recommendations}">
			<p>None at the moment.</p>
		</c:if>
		<c:if test="${not empty user.recommendations}">
			<ul>
			<c:forEach items="${user.recommendations}" var="movie" varStatus="status">
				<li><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title}</a></li>
			</c:forEach>
			</ul>
		</c:if>
		</div>	
	<h3>Favorites:</h3>
	<div>
		<c:if test="${empty user.favorites}">
			<p>None at the moment.</p>
		</c:if>
		<c:if test="${not empty user.favorites}">
			<table id="fav" class="table table-bordered table-striped table-hover">
				<tr><th>Title</th><th>action</th></tr>
				<c:forEach items="${user.favorites}" var="movie" varStatus="status" >
					<tr class="fav favpage${fn:replace(((status.count/5)-((status.count/5)%1)+1),'.0','')}">
						<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
						<td>
							<a href="removeFav.html?index=${status.index}&userId=${user.userId}">
								<img src="../images/delete.png"></img> Delete
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
				<a href="javascript:void(0);" onclick="changeFavBy(-1, 'fav');" id="fav_btn_prev">Prev</a>
				<a href="javascript:void(0);" onclick="changeFavBy(-4, 'fav');" id="favpageno-4" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(-3, 'fav');" id="favpageno-3" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(-2, 'fav');" id="favpageno-2" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(-1, 'fav');" id="favpageno-1" style="display: none;"></a> 
				<a id="favpageno"></a>
				<a href="javascript:void(0);" onclick="changeFavBy(1, 'fav');" id="favpageno1" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(2, 'fav');" id="favpageno2" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(3, 'fav');" id="favpageno3" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(4, 'fav');" id="favpageno4" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeFavBy(1, 'fav');" id="fav_btn_next">Next</a> 
				<br /><br />
		</c:if>
	</div>	
	<h3>Watch Later:</h3>
	<div>
		<c:if test="${empty user.watchLater}">
			<p>None at the moment.</p>
		</c:if>
		<c:if test="${not empty user.watchLater}">
			<table id="watch" class="table table-bordered table-striped table-hover">
				<tr><th>Title</th><th>action</th></tr>
				<c:forEach items="${user.watchLater}" var="movie" varStatus="status" >
					<tr class="watch watchpage${fn:replace(((status.count/5)-((status.count/5)%1)+1),'.0','')}">
						<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
						<td>
							<a href="removeWL.html?index=${status.index}&userId=${user.userId}">
								<img src="../images/delete.png"></img> Delete
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<a href="javascript:void(0);" onclick="changeWatchBy(-1, 'watch');" id="watch_btn_prev">Prev</a>
			<a href="javascript:void(0);" onclick="changeWatchBy(-4, 'watch');" id="watchpageno-4" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(-3, 'watch');" id="watchpageno-3" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(-2, 'watch');" id="watchpageno-2" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(-1, 'watch');" id="watchpageno-1" style="display: none;"></a> 
			<a id="watchpageno"></a>
			<a href="javascript:void(0);" onclick="changeWatchBy(1, 'watch');" id="watchpageno1" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(2, 'watch');" id="watchpageno2" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(3, 'watch');" id="watchpageno3" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(4, 'watch');" id="watchpageno4" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeWatchBy(1, 'watch');" id="watch_btn_next">Next</a> 
			<br /><br />
		</c:if>
		</div>
		<h3>Reviewed Movies:</h3>
		<div>
			<c:if test="${empty user.reviewedMovies}">
				<p>You haven't reviewed any movies yet!</p>
			</c:if>
			<c:if test= "${not empty user.reviewedMovies}">
			<table id="rev" class="table table-bordered table-striped table-hover">
				<tr><th>Movie Title</th> <th>Rating</th><th>Operations</th></tr>
				<c:forEach items="${user.reviewedMovies}" var="review" varStatus="varStatus">
					<tr class="rev revpage${fn:replace(((varStatus.count/5)-((varStatus.count/5)%1)+1),'.0','')}" >
						<td><a href="../movies/details2.html?id=${ review.movie.movieId }">${review.movie.title}</a></td>
						<td>${review.rating }  
						<img height="15" width="15" src="http://st.depositphotos.com/1216158/4699/v/170/depositphotos_46997115-stock-illustration-yellow-stars-vector-illustration-single.jpg"></td>
						<td>
							<a href="../review/edit.html?id=${review.movie.movieId}">Edit</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<a href="javascript:void(0);" onclick="changeRevBy(-1, 'rev');" id="rev_btn_prev">Prev</a>
			<a href="javascript:void(0);" onclick="changeRevBy(-4, 'rev');" id="revpageno-4" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(-3, 'rev');" id="revpageno-3" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(-2, 'rev');" id="revpageno-2" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(-1, 'rev');" id="revpageno-1" style="display: none;"></a> 
			<a id="revpageno"></a>
			<a href="javascript:void(0);" onclick="changeRevBy(1, 'rev');" id="revpageno1" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(2, 'rev');" id="revpageno2" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(3, 'rev');" id="revpageno3" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(4, 'rev');" id="revpageno4" style="display: none;"></a> 
			<a href="javascript:void(0);" onclick="changeRevBy(1, 'rev');" id="rev_btn_next">Next</a> 
			<br /><br />
			</c:if>
			
		</div>		
		<h3>Elo-Runoffs:</h3>
		<div>
			<c:if test="${empty elos}">
				<p> You haven't ranked any movies yet! </p>
			</c:if>
			<c:if test="${not empty elos }">
				<table id="elo" class="table table-bordered table-striped table-hover">
				<tr><th>Winning Film</th><th>Elo Rating</th><th>Losing Film</th><th>Elo Rating</th></tr>
				<c:forEach items="${elos}" var="elo" varStatus="varStatus">
				<tr class="elo elopage${fn:replace(((varStatus.count/5)-((varStatus.count/5)%1)+1),'.0','')}">
					<td><a href="../movies/details2.html?id=${ elo.winner.movieId }">${elo.winner.title}</a></td>
					<td>${elo.winner.eloRating}</td>
					<td><a href="../movies/details2.html?id=${ elo.loser.movieId }">${elo.loser.title}</a></td>
					<td>${elo.loser.eloRating}</td>
				</tr>
				</c:forEach>
				</table>
				<a href="javascript:void(0);" onclick="changeEloBy(-1, 'elo');" id="elo_btn_prev">Prev</a>
				<a href="javascript:void(0);" onclick="changeEloBy(-4, 'elo');" id="elopageno-4" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(-3, 'elo');" id="elopageno-3" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(-2, 'elo');" id="elopageno-2" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeRevBy(-1, 'elo');" id="elopageno-1" style="display: none;"></a> 
				<a id="elopageno"></a>
				<a href="javascript:void(0);" onclick="changeEloBy(1, 'elo');" id="elopageno1" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(2, 'elo');" id="elopageno2" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(3, 'elo');" id="elopageno3" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(4, 'elo');" id="elopageno4" style="display: none;"></a> 
				<a href="javascript:void(0);" onclick="changeEloBy(1, 'elo');" id="elo_btn_next">Next</a>
				<br /> <br />
			</c:if>
		</div>
		</div>
</div>
