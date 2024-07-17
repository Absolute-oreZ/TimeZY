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

<body class="w-full flex flex-1">
	<div class="flex flex-1">
		<div
			class="md:flex md:flex-col p-8 w-1/2 items-center justify-center hidden md:block">
			<img
				src="${pageContext.request.contextPath}/public/assets/images/buildings.png"
				alt="logo" />
			<div
				class="text-slate-800 text-center py-4 px-6 font-montserrat font-bold text-3xl">
				<span class="text-7xl font-extrabold">"</span>From Dreams to Places,
				Each Step Counts.
			</div>
		</div>
		<div
			class="p-8 self-center w-full rounded shadow-md md:w-1/2 items-center justify-center">
			<h1 class="text-2xl font-bold mb-6 text-center">Edit Location</h1>
			<form action="/admin/location/edit/${location.locationId}"
				method="post" class="space-y-4">
				<div>
					<label for="locationName"
						class="block text-sm font-medium text-gray-700">Location
						Name:</label> <input type="text" id="locationName" name="locationName"
						placeholder="Enter name for new location"
						value="${location.locationName}" required
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<label for="buildingName"
						class="block text-sm font-medium text-gray-700">Building:</label>
					<input type="text" id="buildingName" name="buildingName"
						value="${location.buildingName}"
						placeholder="Enter the building for new location"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div>
					<label for="floorNumber"
						class="block text-sm font-medium text-gray-700">Floor
						Number:</label> <input type="text" id="floorNumber" name="floorNumber"
						value="${location.floorNumber}"
						placeholder="Enter the floor number for new location"
						class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
				</div>
				<div class="flex items-center justify-between">
					<button type="submit"
						class="w-full px-4 py-2 bg-indigo-500 text-white font-semibold rounded-md shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
						Update</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>