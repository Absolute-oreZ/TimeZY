<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/public/index.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
</head>

<body class="w-full flex flex-1">
	<div class="flex flex-1">
		<div
			class="p-8 m-2 self-center h-full w-full rounded shadow-md md:w-1/2 items-center justify-center">
			<h1 class="text-2xl font-bold mb-6 text-center">Register New
				Location</h1>
			<div id="registerError" class="text-red-500 mb-4">
				<%
				String registerError = (String) request.getAttribute("registerError");
				if (registerError != null) {
					out.print(registerError);
				}
				%>
			</div>
			<form action="/admin/location/new" method="post" class="space-y-4">
				<div>
					<label for="locationName"
						class="block text-sm font-medium text-gray-700">Location
						Name:</label> <input type="text" id="locationName" name="locationName"
						placeholder="Enter name for new location" required
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<label for="buildingName"
						class="block text-sm font-medium text-gray-700">Building:</label>
					<input type="text" id="buildingName" name="buildingName"
						placeholder="Enter the building for new location"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<label for="floorNumber"
						class="block text-sm font-medium text-gray-700">Floor
						Number:</label> <input type="text" id="floorNumber" name="floorNumber"
						placeholder="Enter the floor number for new location"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div class="flex items-center justify-between">
					<button type="submit"
						class="w-full px-4 py-2 bg-indigo-500 text-white font-semibold rounded-md shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
						Register</button>
				</div>
			</form>
		</div>
		<div
			class="md:flex-col p-8 w-1/2 m-2 items-center justify-center hidden md:flex">
			<img
				src="${pageContext.request.contextPath}/public/assets/images/buildings.png"
				alt="logo" />
			<div
				class="text-slate-800 text-center py-4 px-6 font-montserrat font-bold text-3xl">
				<span class="text-7xl font-extrabold">"</span>From Places to Dreams,
				Every Step Counts.
			</div>
		</div>
	</div>
</body>
</html>