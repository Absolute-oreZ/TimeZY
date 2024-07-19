<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/public/index.css" />
<script>
	function confirmDelete(locationId) {
		if (confirm("Are you sure you want to delete this location?")) {
			window.location.href = "/admin/location/delete/" + locationId;
		}
	}
</script>
</head>

<body class="bg-gray-100">
	<c:if test="${not empty alert}">
		<script>
			window.alert("${alert}");
		</script>
	</c:if>
	<section class="container mx-auto p-4">
		<div class="flex justify-between items-center mb-4">
			<h1 class="font-extrabold text-xl">Location List</h1>
			<a href="/admin/location/new"
				class="inline-block px-4 py-2 text-lg font-semibold text-green-600 bg-white border-2 border-green-600 rounded transition duration-300 hover:bg-green-600 hover:text-white">
				+ New Location </a>
		</div>

		<div class="mt-4">
			<table class="w-full bg-white border-collapse border border-gray-300">
				<thead>
					<tr class="bg-gray-200">
						<th class="px-4 py-2 text-left">No.</th>
						<th class="px-4 py-2 text-left">Location</th>
						<th class="px-4 py-2 text-left">Building</th>
						<th class="px-4 py-2 text-left">Floor</th>
						<th class="px-4 py-2 text-left">Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="location" items="${locations}" varStatus="loop">
						<tr class="border-b border-gray-300">
							<td class="px-4 py-2">${loop.index + 1}</td>
							<td class="px-4 py-2">${location.locationName}</td>
							<td class="px-4 py-2">${location.buildingName}</td>
							<td class="px-4 py-2">${location.floorNumber}</td>
							<td class="px-4 py-2">
								<a href="/admin/location/edit/${location.locationId}"
									class="edit-button text-blue-600">Edit</a> | 
								<a href="javascript:void(0);"
									onclick="confirmDelete('${location.locationId}')"
									class="delete-button text-red-600">Delete</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
</body>

</html>
