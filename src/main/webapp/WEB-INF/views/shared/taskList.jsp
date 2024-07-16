<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Task List</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/public/index.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-p3c6+fM8YsfnS3eiOj8NK3h3NzL0O9dVoB0LYc01imRf5TbJmq8ftduR00K8T6/H9tW0l8FsweA9Cg9t2yqUCg=="
	crossorigin="anonymous" referrerpolicy="no-referrer">
<style>
table {
	width: 100%;
	margin-top: 1rem;
	font-size: 0.875rem;
}

th, td {
	padding: 0.75rem;
}

.alert {
	background-color: #f8d7da;
	border-color: #f5c6cb;
	color: #721c24;
	padding: 1rem;
	margin-bottom: 1rem;
	border: 1px solid transparent;
	border-radius: 0.25rem;
}
</style>
</head>

<body class="bg-gray-100 min-h-screen">
	<c:if test="${not empty alert}">
		<div class="alert">
			<script>
				window.alert("${alert}");
			</script>
		</div>
	</c:if>
	<section class="container mx-auto p-4">
		<div class="flex justify-between items-center">
			<h1 class="font-extrabold text-2xl">Task List</h1>
			<c:if
				test="${currentUser.role == 'ADMIN' || currentUser.role == 'MANAGER'}">
				<a href="/${currentUser.role.toString().toLowerCase()}/task/new"
					class="inline-block px-2 px-1 text-lg font-semibold text-green-600 bg-white border-2 border-green-600 rounded transition duration-300 hover:bg-green-600 hover:text-white">
					+ New Task </a>
			</c:if>
		</div>

		<div class="mt-4">
			<table class="w-full bg-white border border-gray-300">
				<thead>
					<tr class="bg-gray-200">
						<th class="px-2 px-1 text-sm md:text-base">No.</th>
						<th class="px-2 px-1 text-sm md:text-base">Date</th>
						<th class="px-2 px-1 text-sm md:text-base">Task</th>
						<th class="px-2 px-1 text-sm md:text-base">Category</th>
						<th class="px-2 px-1 text-sm md:text-base">Description</th>
						<th class="px-2 px-1 text-sm md:text-base">Priority</th>
						<th class="px-2 px-1 text-sm md:text-base">Status</th>
						<th class="px-2 px-1 text-sm md:text-base">Location</th>
						<th class="px-2 px-1 text-sm md:text-base">Deadline</th>
						<c:choose>
							<c:when
								test="${currentUser.role == 'ADMIN' || currentUser.role == 'MANAGER'}">
								<th class="px-2 px-1 text-sm md:text-base">Responsible
									Cleaner</th>
								<c:if test="${currentUser.role == 'ADMIN'}">
									<th class="px-2 px-1 text-sm md:text-base">Responsible
										Manager</th>
								</c:if>
								<th class="px-2 px-1 text-sm md:text-base">Actions</th>
							</c:when>
							<c:otherwise>
								<th class="px-2 px-1 text-sm md:text-base">Actions</th>
							</c:otherwise>
						</c:choose>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="task" items="${tasks}" varStatus="loop">
						<tr class="border-b border-gray-300">
							<td class="px-2 px-1 text-sm md:text-base">${loop.index + 1}</td>
							<td class="px-2 px-1 text-sm md:text-base"><fmt:formatDate
									value="${task.taskDeadline}" pattern="dd/MM/yy" /></td>
							<td class="px-2 px-1 text-sm md:text-base">${task.taskName}</td>
							<td class="px-2 px-1 text-sm md:text-base">${task.taskCategory}</td>
							<td class="px-2 px-1 text-sm md:text-base">${task.taskDescription}</td>
							<td class="px-2 px-1 text-sm md:text-base">${task.taskPriority.toString()}</td>
							<td class="px-2 px-1 text-sm md:text-base"><span
								class="inline-block rounded-full px-3 py-1 text-xs font-semibold
                                    <c:choose>
                                        <c:when test="${task.status == 'OVERDUE'}">bg-red-200 text-red-800</c:when>
                                        <c:when test="${task.status == 'COMPLETED'}">bg-green-200 text-green-800</c:when>
                                        <c:when test="${task.status == 'IN_PROGRESS'}">bg-yellow-200 text-yellow-800</c:when>
                                        <c:otherwise>bg-blue-200 text-blue-800</c:otherwise>
                                    </c:choose>">
									${task.status} </span></td>
							<td class="px-2 px-1 text-sm md:text-base">${task.location.locationName}</td>
							<td class="px-2 px-1 text-sm md:text-base"><fmt:formatDate
									value="${task.taskDeadline}" pattern="h:mm a" /></td>
							<c:choose>
								<c:when
									test="${currentUser.role == 'ADMIN' || currentUser.role == 'MANAGER'}">
									<td class="px-2 px-1 text-sm md:text-base">${task.cleaner.name}</td>
									<c:if test="${currentUser.role == 'ADMIN'}">
										<td class="px-2 py-1 text-sm md:text-base">${task.manager.name}</td>
									</c:if>
									<td class="px-2 px-1 text-sm md:text-base"><a
										href="/${currentUser.role.toString().toLowerCase()}/task/edit/${task.taskId}"
										class="inline-block px-3 py-1 text-sm font-semibold text-blue-600 hover:bg-blue-200 rounded transition duration-300">
											Edit </a> |
										<form
											action="/${currentUser.role.toString().toLowerCase()}/task/delete/${task.taskId}"
											method="GET" style="display: inline;"
											onsubmit="return confirm('Are you sure you want to delete this task?');">
											<button type="submit"
												class="inline-block px-3 py-1 text-sm font-semibold text-red-600 hover:bg-red-200 rounded transition duration-300">
												Delete</button>
										</form></td>
								</c:when>
								<c:otherwise>
									<td class="px-2 px-1 text-sm md:text-base"><c:choose>
											<c:when test="${task.status == 'CREATED'}">
												<form action="/cleaner/task/change-status/${task.taskId}"
													method="POST" style="display: inline;">
													<input type="hidden" name="status" value="IN_PROGRESS">
													<button type="submit"
														class="inline-block px-3 py-1 text-sm font-semibold text-blue-600 hover:bg-blue-200 rounded transition duration-300">
														Start Task</button>
												</form>
												|
												<form action="/cleaner/task/change-status/${task.taskId}"
													method="POST" style="display: inline;">
													<input type="hidden" name="status" value="COMPLETED">
													<button type="submit"
														class="inline-block px-3 py-1 text-sm font-semibold text-green-600 hover:bg-green-200 rounded transition duration-300">
														Complete Task</button>
												</form>
											</c:when>
											<c:when test="${task.status == 'IN_PROGRESS'}">
												<form action="/cleaner/task/change-status/${task.taskId}"
													method="POST">
													<input type="hidden" name="status" value="COMPLETED">
													<button type="submit"
														class="inline-block px-3 py-1 text-sm font-semibold text-green-600 hover:bg-green-200 rounded transition duration-300">
														Complete Task</button>
												</form>
											</c:when>
										</c:choose></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</section>
</body>

</html>