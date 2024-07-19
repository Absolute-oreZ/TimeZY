<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<body class="bg-gray-100">
	<div class="container mx-auto px-4 py-8">
		<h1 class="text-3xl font-bold mb-8">Manager Dashboard</h1>

		<!-- Statistics Cards -->
		<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
			<!-- Total Users Card -->
			<div
				class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition duration-300">
				<h2
					class="text-xl font-semibold mb-2 flex items-center justify-between">
					<span>Total Users</span> <i class="fas fa-users text-blue-600"></i>
				</h2>
				<p class="text-3xl font-bold text-blue-600">${totalUsers}</p>
			</div>

			<!-- Active Tasks Card -->
			<div
				class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition duration-300">
				<h2
					class="text-xl font-semibold mb-2 flex items-center justify-between">
					<span>Active Tasks</span> <i class="fas fa-tasks text-green-600"></i>
				</h2>
				<p class="text-3xl font-bold text-green-600">${activeTasks}</p>
			</div>

			<!-- Attendance Rate Card -->
			<div
				class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition duration-300">
				<h2
					class="text-xl font-semibold mb-2 flex items-center justify-between">
					<span>Attendance Rate</span> <i
						class="fas fa-chart-line text-purple-600"></i>
				</h2>
				<p class="text-3xl font-bold text-purple-600"><fmt:formatNumber value="${attendanceRate}" type="percent" /></p>
			</div>
		</div>

		<!-- Tasks Progression -->
		<div class="bg-white rounded-lg shadow-md p-6 mb-8">
			<h2 class="text-2xl font-semibold mb-4">Tasks Progression</h2>
			<div class="flex flex-wrap justify-between">
				<!-- Created -->
				<div class="w-full sm:w-1/2 md:w-1/4 mb-4">
					<span>Created</span> <i class="fas fa-plus-circle text-gray-400"></i>
					<h3
						class="text-lg font-medium mb-2 flex items-center justify-between">
					</h3>
					<div class="flex items-center">
						<div class="w-full bg-gray-200 rounded-full h-2.5 mr-2">
							<div
								class="bg-gradient-to-r from-blue-600 to-blue-400 h-2.5 rounded-full"
								style="width: ${taskCreatedPercentage}%"></div>
						</div>
						<span class="text-sm font-medium"><fmt:formatNumber value="${taskCreatedPercentage / 100}" type="percent" />
						</span>
					</div>
				</div>

				<!-- In Progress -->
				<div class="w-full sm:w-1/2 md:w-1/4 mb-4">
						<span>In Progress</span> <i class="fas fa-spinner text-gray-400"></i>
					<h3
						class="text-lg font-medium mb-2 flex items-center justify-between">
					</h3>
					<div class="flex items-center">
						<div class="w-full bg-gray-200 rounded-full h-2.5 mr-2">
							<div
								class="bg-gradient-to-r from-yellow-400 to-yellow-300 h-2.5 rounded-full"
								style="width: ${taskInProgressPercentage}%"></div>
						</div>
						<span class="text-sm font-medium"><fmt:formatNumber value="${taskInProgressPercentage / 100}" type="percent" />
						</span>
					</div>
				</div>

				<!-- Completed -->
				<div class="w-full sm:w-1/2 md:w-1/4 mb-4">
					<span>Completed</span> <i
						class="fas fa-check-circle text-gray-400"></i>
					<h3
						class="text-lg font-medium mb-2 flex items-center justify-between">
					</h3>
					<div class="flex items-center">
						<div class="w-full bg-gray-200 rounded-full h-2.5 mr-2">
							<div
								class="bg-gradient-to-r from-green-600 to-green-400 h-2.5 rounded-full"
								style="width: ${taskCompletedPercentage}%"></div>
						</div>
						<span class="text-sm font-medium"><fmt:formatNumber value="${taskCompletedPercentage / 100}" type="percent" />
						</span>
					</div>
				</div>

				<!-- Overdue -->
				<div class="w-full sm:w-1/2 md:w-1/4 mb-4">
					<span>Overdue</span> <i
						class="fas fa-exclamation-circle text-gray-400"></i>
					<h3
						class="text-lg font-medium mb-2 flex items-center justify-between">
					</h3>
					<div class="flex items-center">
						<div class="w-full bg-gray-200 rounded-full h-2.5 mr-2">
							<div
								class="bg-gradient-to-r from-red-600 to-red-400 h-2.5 rounded-full"
								style="width: ${taskOverduePercentage}%"></div>
						</div>
						<span class="text-sm font-medium"><fmt:formatNumber value="${taskOverduePercentage / 100}" type="percent" />
						</span>
					</div>
				</div>
			</div>
		</div>

		<!-- Attendance Table -->
		<div class="bg-white rounded-lg shadow-md p-6">
			<h2 class="text-2xl font-semibold mb-4">Recent Attendance</h2>
			<div class="overflow-x-auto">
				<table class="w-full text-left border-collapse">
					<thead>
						<tr>
							<th
								class="py-4 px-6 bg-gray-200 font-bold uppercase text-sm text-gray-700 border-b border-gray-300">
								Name</th>
							<th
								class="py-4 px-6 bg-gray-200 font-bold uppercase text-sm text-gray-700 border-b border-gray-300">
								Date</th>
							<th
								class="py-4 px-6 bg-gray-200 font-bold uppercase text-sm text-gray-700 border-b border-gray-300">
								Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${recentAttendance}" var="attendance">
							<tr class="hover:bg-gray-100">
								<td class="py-4 px-6 border-b border-gray-300">${attendance.cleaner.name}</td>
								<td class="py-4 px-6 border-b border-gray-300">${attendance.attendanceDate}</td>
								<td class="py-4 px-6 border-b border-gray-300"><span
									class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${attendance.status == 'PRESENT' ? 'bg-green-100 text-green-800' : attendance.status == 'LATE' ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
										${attendance.status} </span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Font Awesome -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>

</html>
