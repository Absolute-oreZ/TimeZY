<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Timezy</title>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/public/assets/images/favicon.ico">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Include Tailwind CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css"
	rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100">

	<div class="flex flex-col min-h-screen">

		<!-- Header (hidden on mobile) -->
		<header
			class="hidden lg:flex h-18 w-full -mb-[1px] bg-white border-b m-0 border-gray-300">
			<jsp:include page="components/navbar.jsp" />
		</header>

		<div class="flex w-full flex-1">

			<!-- Sidebar (hidden on mobile) -->
			<aside
				class="hidden lg:flex w-[13%] bg-gray-200 border-r border-gray-300">
				<jsp:include page="components/leftSideBar.jsp" />
			</aside>

			<!-- Main Content Area -->
			<main class="p-4 w-full">
				<jsp:include page="${contentPage}" />
			</main>

		</div>

		<!-- Bottom Bar (shown on mobile) -->
		<footer
			class="lg:hidden fixed inset-x-0 bottom-0 w-full bg-white border-t border-gray-300 h-16 flex items-center justify-center">
			<span class="text-gray-600">Bottom Bar Content</span>
		</footer>

	</div>

</body>

</html>