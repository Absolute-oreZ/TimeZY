<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<link rel="icon" type="image/png" href="images/logo.png" />
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<!-- Font Awesome for eye icon -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<title>Timezy - Login</title>
</head>

<body>
	<div class="flex flex-1">
		<div class="flex flex-1 justify-center items-center flex-col py-10">
			<h2 class="text-2xl font-bold mb-4">Login</h2>
			<!-- Display error message if present -->
			<div id="loginError" class="text-red-500 mb-4">
				<%
				String loginError = (String) request.getAttribute("loginError");
				if (loginError != null) {
					out.print(loginError);
				}
				%>
			</div>
			<form id="loginForm" action="/login" method="POST"
				onsubmit="return validateLogin(event)" class="space-y-4">
				<div>
					<label for="email" class="block text-sm font-medium text-gray-700">Email</label>
					<input type="email" placeholder="Enter your email" id="email"
						name="email"
						class="mt-1 p-2 block w-full border-2 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
				</div>
				<div>
					<label for="password"
						class="block text-sm font-medium text-gray-700">Password:</label>
					<div class="relative">
						<input type="password" id="password" name="password"
							placeholder="Enter new password"
							class="mt-1 p-2 block w-full border-2 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
						<span class="absolute inset-y-0 right-0 pr-3 flex items-center">
							<button type="button" id="togglePassword"
								class="text-gray-400 hover:text-gray-600">
								<i class="far fa-eye-slash"></i>
							</button>
						</span>
					</div>
				</div>
				<button type="submit"
					class="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600">Login</button>
			</form>
		</div>
	</div>
	<script>
		function validateLogin(event) {
			event.preventDefault(); // Prevent default form submission

			var email = document.getElementById("email").value.trim(); // Trim whitespace
			var password = document.getElementById("password").value.trim();
			var errorElement = document.getElementById("loginError");

			// Clear previous error message
			errorElement.innerText = "";

			// Basic checks for empty fields
			if (email === "" || password === "") {
				errorElement.innerText = "All fields are required.";
				return false;
			}

			// Validate email format using regex
			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailRegex.test(email)) {
				errorElement.innerText = "Invalid email format.";
				return false;
			}
			document.getElementById("loginForm").submit();
		}
	</script>

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