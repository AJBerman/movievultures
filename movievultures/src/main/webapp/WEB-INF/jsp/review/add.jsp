<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
  <td>${movie.date}</td>
</tr>
<tr>
  <td>Review</td>
  <td><form:input type="text" path="review" /></td>
</tr>
<tr>
  <td>Rating</td>
  <td><form:input type="number" path="rating" min="0.5" max="5.0" step="0.5" /></td>
</tr>

</table>
</form:form>
</body>
</html>
