<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Timezy</title>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/public/assets/images/favicon.ico">
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body>

	<div class="flex w-full h-screen items-center justify-center">
		<div class="w-1/2 items-center justify-center">
			<img
				src="${pageContext.request.contextPath}/public/assets/images/logo.png"
				class="h-full w-full object-contain bg-no-repeat px-10">
		</div>

		<div class="flex flex-1 justify-center items-center flex-col py-10">
			<jsp:include page="${contentPage}" />
		</div>
	</div>
</body>

</html>