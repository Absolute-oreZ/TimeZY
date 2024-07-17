
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.tailwindcss.com"></script>
<!-- Font Awesome for eye icon -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
</head>

<body>
	<div class="bg-white p-8 rounded shadow-md w-full">
		<h1 class="text-2xl font-bold mb-6 text-center">Edit User</h1>
		<div id="registerError" class="text-red-500 mb-4">
			<%
			String editingError = (String) request.getAttribute("editingError");
			if (editingError != null) {
				out.print(editingError);
			}
			%>
		</div>
		<form action="/admin/user/edit/${user.userId}" method="post"
			class="space-y-4">
			<div>
				<label for="name" class="block text-sm font-medium text-gray-700">Name:</label>
				<input type="text" id="name" name="name" value="${user.name}"
					class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
			</div>
			<div>
				<label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
				<input type="email" id="email" name="email" value="${user.email}"
					readonly
					class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				<p class="mt-2 text-sm text-gray-500">Email cannot be changed.</p>
			</div>
			<div>
				<label for="password"
					class="block text-sm font-medium text-gray-700">Password:</label>
				<div class="relative">
					<input type="password" id="password" name="password"
						placeholder="Enter new password" value="${user.password}"
						class="mt-1 p-2 block w-full border-2 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
					<span class="absolute inset-y-0 right-0 pr-3 flex items-center">
						<button type="button" id="togglePassword"
							class="text-gray-400 hover:text-gray-600">
							<i class="far fa-eye-slash"></i>
						</button>
					</span>
				</div>
			</div>
			<div>
				<label for="role" class="block text-sm font-medium text-gray-700">Role:</label>
				<select id="role" name="role" disabled
					class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
					<option value="${user.role}">${user.role}</option>
					<option value="${userRoles[1]}">${userRoles[1].toString()}</option>
					<option value="${userRoles[0]}">${userRoles[0].toString()}</option>
				</select>
				<p class="mt-2 text-sm text-gray-500">Role cannot be changed.</p>
				<input type="hidden" id="role" name="role" value="${user.role}">
			</div>
			<div>
				<label for="phone" class="block text-sm font-medium text-gray-700">Phone:</label>
				<input type="text" id="phone" name="phone" value="${user.phone}"
					class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
			</div>
			<div class="flex items-center justify-between">
				<button type="submit"
					class="w-full px-4 py-2 bg-indigo-500 text-white font-semibold rounded-md shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
					Update</button>
			</div>
		</form>
	</div>

	<script>
		function showPass() {
			var passwordField = document.getElementById("password");
			var toggleBtn = document.getElementById("togglePassword");

			if (passwordField.type === "password") {
				passwordField.type = "text";
				toggleBtn.innerHTML = '<i class="far fa-eye"></i>';
			} else {
				passwordField.type = "password";
				toggleBtn.innerHTML = '<i class="far fa-eye-slash"></i>';
			}
		}

		// Attach click event listener to the togglePassword button
		document.getElementById("togglePassword").addEventListener("click",
				showPass);
	</script>
</body>

</html>