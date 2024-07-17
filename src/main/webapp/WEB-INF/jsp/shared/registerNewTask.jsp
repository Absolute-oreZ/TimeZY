<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ page import="dev.young.timeZY.model.User" %>
			<%@ page import="dev.young.timeZY.model.Location" %>
				<!DOCTYPE html>
				<html lang="en">

				<body class="bg-gray-100 w-full flex flex-1">
					<div class="flex flex-1">
						<div class="p-8 self-center w-full rounded shadow-md md:w-1/2 items-center justify-center">
							<h1 class="text-2xl font-bold mb-6 text-center">Register New
								Task</h1>
							<div id="registerError" class="text-red-500 mb-4">
								<% String registerError=(String) request.getAttribute("registerError"); if
									(registerError !=null) { out.print(registerError); } %>
							</div>
							<form action="/${currentUser.role.toString().toLowerCase()}/task/new" method="post" class="space-y-4">
								<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
									<!-- Task Name -->
									<div>
										<label for="taskName"
											class="block text-sm font-medium text-gray-700">Task:</label> <input
											type="text" id="taskName" name="taskName" required
											placeholder="Enter name for new task"
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
									</div>

									<!-- Responsible CLeaner -->
									<div>
										<label for="cleaner" class="block text-sm font-medium text-gray-700">Responsible
											Cleaner:</label> <select id="cleaner" name="cleaner" required
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
											<c:choose>
												<c:when test="${empty selectedCleaner}">
													<option value="" selected disabled hidden>Choose here</option>
												</c:when>
												<c:otherwise>
													<option value="${selectedCleaner.userId}" selected hidden>${selectedCleaner.name}</option>
												</c:otherwise>
											</c:choose>
											<c:forEach var="cleaner" items="${cleaners}">
												<option value="${cleaner.userId}">${cleaner.name}</option>
											</c:forEach>
										</select>
									</div>

									<!-- Task Category -->
									<div>
										<label for="taskCategory"
											class="block text-sm font-medium text-gray-700">Category:</label>
										<select id="taskCategory" name="taskCategory" required
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
											<option value="" selected disabled hidden>Choose here</option>
											<option value="${taskCategory[0]}">${taskCategory[0].toString()}</option>
											<option value="${taskCategory[1]}">${taskCategory[1].toString()}</option>
											<option value="${taskCategory[2]}">${taskCategory[2].toString()}</option>
											<option value="${taskCategory[3]}">${taskCategory[3].toString()}</option>
											<option value="${taskCategory[4]}">${taskCategory[4].toString()}</option>
											<option value="${taskCategory[5]}">${taskCategory[5].toString()}</option>
										</select>
									</div>

									<!-- Task Priority -->
									<div>
										<label for="taskPriority"
											class="block text-sm font-medium text-gray-700">Priority:</label>
										<select id="taskPriority" name="taskPriority" required
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
											<option value="" selected disabled hidden>Choose here</option>
											<option value="${taskPriority[0]}">${taskPriority[0].toString()}</option>
											<option value="${taskPriority[1]}">${taskPriority[1].toString()}</option>
											<option value="${taskPriority[2]}">${taskPriority[2].toString()}</option>
										</select>
									</div>

									<!-- Task Description -->
									<div class="col-span-2">
										<label for="taskDescription"
											class="block text-sm font-medium text-gray-700">Description:</label>
										<textarea id="taskDescription" name="taskDescription"
											placeholder="Enter description for new task"
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"></textarea>
									</div>

									<!-- Location Details -->
									<div class="col-span-2">
										<label for="location"
											class="block text-sm font-medium text-gray-700">Location:</label> <select
											id="location" name="location" required
											class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
											<option value="" selected disabled hidden>Choose here</option>
											<c:forEach var="location" items="${locations}">
												<option value="${location.locationId}">${location.locationName},
													${location.buildingName}, ${location.floorNumber}</option>
											</c:forEach>
										</select>
									</div>

									<!-- Task Deadline -->
									<div class="col-span-2">
										<label for="taskDeadline" class="block text-sm font-medium text-gray-700">Task
											Deadline</label> <input type="datetime-local" id="taskDeadline"
											name="taskDeadline"
											class="mt-1 p-2 block w-full border-2 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
											required>
									</div>
								</div>

								<!-- Submit Button -->
								<div class="flex items-center justify-center mt-4">
									<button type="submit"
										class="w-full px-4 py-2 bg-indigo-500 text-white font-semibold rounded-md shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
										Assign Task</button>
								</div>
							</form>
						</div>
						<div class="md:flex-col p-8 w-1/2 m-2 items-center justify-center hidden md:flex">
							<img src="${pageContext.request.contextPath}/public/assets/images/task.png" alt="logo" />
							<div class="text-slate-800 text-center py-4 px-6 font-montserrat font-bold text-3xl">
								<span class="text-7xl font-extrabold">"</span>Turning Ambitions into
								Reality, Task by Task.
							</div>
						</div>
					</div>
				</body>

				</html>