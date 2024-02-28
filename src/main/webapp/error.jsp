<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>We have a problem...</title>
	</head>
	
	<body>
	
		<h1>Error message... Please, call support team to send problems
			with app</h1>

		<% out.println(request.getAttribute("msg")); %>

	</body>
	
</html>