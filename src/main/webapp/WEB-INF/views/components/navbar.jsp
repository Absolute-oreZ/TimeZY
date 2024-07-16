<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="UTF-8">
		<title>timeZY</title>
		<script src="https://cdn.tailwindcss.com"></script>
		<style>
			/* Custom styles to handle dropdown positioning */
			.dropdown-container {
				position: relative;
			}

			.dropdown-menu {
				display: none;
				position: absolute;
				right: 0;
				top: 100%;
				z-index: 10;
			}

			.dropdown-menu.active {
				display: block;
			}
		</style>
		<script>
			document.addEventListener('DOMContentLoaded', function () {
				const userMenuButton = document.getElementById('user-menu-button');
				const userDropdown = document.getElementById('user-dropdown');

				if (userMenuButton && userDropdown) {
					userMenuButton.addEventListener('click', function () {
						userDropdown.classList.toggle('active');
					});

					// Close dropdown when clicking outside
					document.addEventListener('click', function (event) {
						if (!userMenuButton.contains(event.target)) {
							userDropdown.classList.remove('active');
						}
					});
				}
			});
		</script>
	</head>

	<body>
		<nav class="bg-white border-gray-200 w-full dark:bg-gray-900">
			<div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
				<a href="/" class="flex items-center space-x-3 rtl:space-x-reverse">
					<img src="${pageContext.request.contextPath}/public/assets/images/logo.png" class="h-8"
						alt="timeZY Logo" />
					<span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">timeZY</span>
				</a>
				<div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
					<div class="dropdown-container relative">
						<button type="button"
							class="flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
							id="user-menu-button" aria-haspopup="true" aria-expanded="false"
							aria-controls="user-dropdown">
							<span class="sr-only">Open user menu</span>
							<img class="w-8 h-8 rounded-full"
								src="${pageContext.request.contextPath}/public/assets/images/defaultProfile.png"
								alt="user photo">
						</button>
						<!-- Dropdown menu -->
						<div class="dropdown-menu bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:bg-gradient-to-b dark:from-gray-400 dark:divide-gray-600"
							id="user-dropdown">
							<div class="px-4 py-3">
								<span class="block text-sm text-gray-900 dark:text-white">${currentUser.name}</span>
								<span
									class="block text-sm text-gray-500 truncate dark:text-gray-400">${currentUser.email}</span>
							</div>
							<ul>
								<li>
									<a href="/"
										class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white"
										role="menuitem">Dashboard</a>
								</li>
								<li>
									<a href="/profile/${currentUser.userId}"
										class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white"
										role="menuitem">Profile</a>
								</li>
								<li>
									<a href="/logout"
										class="block hover:text-rose-500 px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white"
										role="menuitem">Sign out</a>
								</li>
							</ul>
						</div>
					</div>
					<button data-collapse-toggle="navbar-user" type="button"
						class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
						aria-controls="navbar-user" aria-expanded="false" aria-label="Open main menu">
						<svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
							viewBox="0 0 17 14">
							<path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
								d="M1 1h15M1 7h15M1 13h15" />
						</svg>
					</button>
				</div>
			</div>
		</nav>
	</body>

	</html>