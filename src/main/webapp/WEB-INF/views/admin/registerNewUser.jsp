<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang3.RandomStringUtils"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TimeZY</title>
<script src="https://cdn.tailwindcss.com"></script>
<!-- Font Awesome for eye icon -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
</head>

<%
String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789~`!@#$%^&*()-_=+[{]}\\|;:\'\",<.>/?";
String pwd = RandomStringUtils.random(15, characters);
%>
<body class="w-full flex flex-1 items-center justify-center">
	<div class="flex flex-1">
		<div
			class="p-8 m-2 self-center rounded shadow-md h-full md:w-1/2 w-full items-center justify-center">
			<h1 class="text-2xl font-bold mb-6 text-center">Register New
				User</h1>
			<div id="registerError" class="text-red-500 mb-4">
				<%
				String registerError = (String) request.getAttribute("registerError");
				if (registerError != null) {
					out.print(registerError);
				}
				%>
			</div>
			<form action="/admin/user/new" method="post" class="space-y-4">
				<div>
					<label for="name" class="block text-sm font-medium text-gray-700">Name:</label>
					<input type="text" id="name" name="name"
						placeholder="Enter name for new user"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
					<input type="email" id="email" name="email"
						placeholder="Enter email for new user"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<input type="hidden" id="password" name="password" value="<%=pwd%>">
				</div>
				<div>
					<label for="role" class="block text-sm font-medium text-gray-700">Role:</label>
					<select id="role" name="role" required
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
						<option value="" selected disabled hidden>Choose here</option>
						<option value="${userRoles[1]}">${userRoles[1].toString()}</option>
						<option value="${userRoles[0]}">${userRoles[0].toString()}</option>
					</select>
				</div>
				<div>
					<label for="phone" class="block text-sm font-medium text-gray-700">Phone:</label>
					<input type="text" id="phone" name="phone"
						placeholder="Enter phone number"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div class="flex items-center justify-between">
					<button type="submit"
						class="w-full px-4 py-2 bg-indigo-500 text-white font-semibold rounded-md shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
						Register</button>
				</div>
				<div id="signupError" class="text-red-500"></div>
			</form>
		</div>

		<div
			class="md:flex hidden md:flex-col p-8 w-1/2 m-2 items-center justify-center">
			<img
				src="${pageContext.request.contextPath}/public/assets/images/logo.png"
				alt="logo" />
			<div
				class="text-slate-800 text-center py-4 px-6 font-montserrat font-bold text-3xl">
				<span class="text-7xl font-extrabold">"</span>Welcoming Excellence:
				Where Every New Hire Elevates Our Standards!
			</div>
		</div>
	</div>
</body>
</html>