<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
		<%-- ===== LOGIN AUTHENTICATION ===== --%>
		<br />
		<sec:authorize access="isAuthenticated()">
			<a href="elo/add">Elo Rate two random movies</a> |
			<a href="movies/add">Add a new movie</a>
		</sec:authorize>

		<%-- ===== NOT LOGGED IN ===== --%>
		<sec:authorize access="!isFullyAuthenticated()">
			<h2>Films</h2>
			<c:choose>
				<c:when test="${ not empty movies }">
					<table class="table table-bordered">
						<c:forEach items="${movies}" var="movie" varStatus="status">
							<tr>
								<td><b>Title:</b> <a
									href="movies/details2?id=${movie.movieId}">${movie.title}</a>
									<br /> <b>Director${fn:length(movie.directors) > 1 ? 's':''}:</b> 
								<c:forEach
										items="${movie.directors}" var="dir" varStatus="status">
									${dir}${!status.last ? ',' : ''}  
								</c:forEach><br /> <b>Cast:</b> <c:forEach items="${movie.actors}"
										var="actor" varStatus="status">

									${actor}${!status.last ? ',' : ''}
								</c:forEach><br /> 
								<b>Genre${fn:length(movie.genres) > 1 ? 's':''}:</b> <c:choose>

										<c:when test="${ not empty movie.genres }">
											<c:forEach items="${movie.genres}" var="genre"
												varStatus="status">
										${genre}${!status.last ? ' | ' : ''}
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
							</c:choose>
							<br /><br />
								
							<b>Plot:</b> 
							<p>${fn:substring(movie.plot, 0, 300)} ...</p>
							</td>
						</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:otherwise>
				There are no movies to display.
			</c:otherwise>
		</c:choose>
	</sec:authorize>
	
	<%-- ===== Display Recommendations, WatchLater, and Favorites===== --%>
	
	<sec:authorize access="isAuthenticated()">
	
		<h2>Recommendations</h2>
		<c:choose>
			<c:when test="${not empty recomms}">
				<table id="recomms" border=1>
					<tr>
						<c:forEach items="${recomms}" var="movie" varStatus="status" >
							<td>
							<br />
							<b>Title: </b><a href="movies/details2?id=${movie.movieId}">${movie.title}</a><br />
							<b>Director${fn:length(movie.directors) > 1 ? 's':''}:</b>
								<c:forEach items="${movie.directors}" var="dir" varStatus="status">
									${dir}${!status.last ? ',' : ''} 
								</c:forEach><br />
							<b>Cast: </b>
								<c:forEach items="${movie.actors}" var="actor" varStatus="status">
									${actor}${!status.last ? ',' : ''} 
								</c:forEach><br />
							<b>Genre${fn:length(movie.genres) > 1 ? 's':''}:</b>
								<c:choose>
								<c:when test="${ not empty movie.genres }">
									<c:forEach items="${movie.genres}" var="genre" varStatus="status">
										${genre} ${!status.last ? ' | ' : '' }
									</c:forEach>
								</c:when>
								<c:otherwise>
									Not available.
								</c:otherwise>
							</c:choose><br />
							<b>Year of Release: </b><fmt:formatDate value="${movie.date }" pattern="yyyy" /> <br />
							<b>Plot: </b> ${fn:substring(movie.plot, 0, 250)} ...
							</td>
						</c:forEach>
					</tr>
				</table>
				<input type="button" id="prevRec" value="Previous 3" />
				<input type="button" id="nextRec" value="Next 3" />
			</c:when>
			<c:when test="${empty recomms}" >
				We have no recommendations for you at this time. <br />
			</c:when>
		</c:choose>
	
		<h2>Favorites</h2>
		<c:choose>
			<c:when test="${ not empty movies }">
				<table id="favs" border=1 >
					<tr>
						<c:forEach items="${movies}" var="movie" varStatus="status">
							<td>
							<br />
							<b>Title:</b> <a href="movies/details2?id=${movie.movieId}">${movie.title}</a> <br />
							<b>Director${fn:length(movie.directors) > 1 ? 's':''}:</b>
								<c:forEach items="${movie.directors}" var="dir" varStatus="status">
									${dir} ${!status.last ? ',' : ''} 
								</c:forEach><br />
							<b>Cast:</b>
								<c:forEach items="${movie.actors}" var="actor" varStatus="status">
									${actor}, 
								</c:forEach><br />
								
							<b>Genre${fn:length(movie.genres) > 1 ? 's':''}:</b>
							<c:choose>
								<c:when test="${ not empty movie.genres }">
									<c:forEach items="${movie.genres}" var="genre" varStatus="status">
										${genre}${!status.last ? ' | ' : ''}
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
							</c:choose>
							<br />
							<b>Year of Release: </b> <fmt:formatDate value="${movie.date }" pattern="yyyy" /><br />
							<b>Plot: </b>${fn:substring(movie.plot, 0, 250)} ...
							</td>
						</c:forEach>
					</tr>
				</table>
				<input type="button" id="prevFavs" value="Previous 3" />
				<input type="button" id="nextFavs" value="Next 3" />
			</c:when>
			<c:otherwise>
				There are no movies to display.
			</c:otherwise>
		</c:choose>
		<br />
		
		<h2>Watch Later</h2>
		
		<c:choose>
			<c:when test="${ not empty movies2 }">
				<table id="wl" border=1>
					<tr>
						<c:forEach items="${movies2}" var="movie2" varStatus="status">
							<td>
							<br />
							<b>Title:</b> <a href="movies/details2?id=${movie2.movieId}">${movie2.title}</a> <br />
							<b>Director${fn:length(movie2.directors) > 1 ? 's':''}:</b>
								<c:forEach items="${movie2.directors}" var="dir2" varStatus="status">
									${dir2}${!status.last ? ', ' : ''} 
								</c:forEach><br /> <b>Cast:</b> <c:forEach items="${movie2.actors}"
										var="actor2" varStatus="status">
									${actor2}${!status.last ? ', ' : ''}
								</c:forEach><br />
								
							<b>Genre${fn:length(movie2.genres) > 1 ? 's':''}:</b>
							<c:choose>
								<c:when test="${ not empty movie2.genres }">
									<c:forEach items="${movie2.genres}" var="genre" varStatus="status">
										${genre}${!status.last ? ' | ' : ''}
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
							</c:choose>
							<br />
							<b>Year of Release: </b><fmt:formatDate value="${movie2.date }" pattern="yyyy" /><br />
							<b>Plot: </b>${fn:substring(movie2.plot, 0, 250)} ...
							</td>
						</c:forEach>
					</tr>
				</table>
				<input type="button" id="prevWL" value="Previous 3" />
				<input type="button" id="nextWL" value="Next 3" />
			</c:when>
			<c:otherwise>
				There are no movies to display.
			</c:otherwise>
			</c:choose>
		</sec:authorize>
	</div>
