<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rating ${movie.title}</title>
</head>
<body>
<h2><a href="../index.html">Home</a></h2>
<h3>${movie.title}</h3>
<form:form modelAttribute="review">
<table border="1">
<tr>
  <td>Movie Title</td>
  <td>${movie.title}</td>
</tr>
<tr>
  <td>Released</td>
  <td><fmt:formatDate value="${movie.date}" pattern="yyyy" /></td>
</tr>
</table>
  Rating
  <form:select type="select" path="rating">
    <option value="0.0">0.0</option>
    <option value="0.5">0.5</option>
    <option value="1.0">1.0</option>
    <option value="1.5">1.5</option>
    <option value="2.0">2.0</option>
    <option value="2.5">2.5</option>
    <option value="3.0">3.0</option>
    <option value="3.5">3.5</option>
    <option value="4.0">4.0</option>
    <option value="4.5">4.5</option>
    <option value="5.0">5.0</option>
  </form:select>
  <br />
  Review
  <br />
  <form:textarea type="text" path="review" rows="6" />
  <input type="submit" value="Submit">
</form:form>
</body>
</html>
