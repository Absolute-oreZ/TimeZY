<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<body class="bg-gray-100">
	<c:if test="${not empty alert}">
		<script>
			window.alert("${alert}");
		</script>
	</c:if>

	<c:if test="${not empty error}">
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			${error}
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>

	<div class="container mx-auto p-4">
		<div class="mb-4">
			<p class="text-xl font-bold">Cleaner:
				${todayAttendance.cleaner.name}</p>
			<p class="mt-2">
				Attendance Date:
				<%=java.time.LocalDate.now()%>
			</p>
		</div>

		<div>
			<div class="bg-white shadow-md rounded-lg p-4 mb-4">
				<c:choose>
					<c:when
						test="${empty todayAttendance.loginTime and empty todayAttendance.logoutTime}">
						<p class="text-lg font-bold mb-2">Status:
							${todayAttendance.status.toString()}</p>
						<form
							action="<%=request.getContextPath()%>/cleaner/log-in-working/${todayAttendance.attendanceId}"
							method="post">
							<button type="submit"
								class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded flex items-center">
								<i class="fas fa-sign-out-alt mr-2"></i> Log In Working
							</button>
						</form>
					</c:when>
					<c:when
						test="${not empty todayAttendance.loginTime and empty todayAttendance.logoutTime}">
						<p class="text-lg font-bold mb-2">Status: LOGGED IN</p>
						<p>Logged In Time: ${todayAttendance.loginTime}</p>
						<div class="flex items-center">
							<p class="mr-2">Working Time:</p>
							<p id="elapsedTime" class="font-bold text-blue-500"></p>
						</div>
						<form
							action="<%=request.getContextPath()%>/cleaner/log-out-working/${todayAttendance.attendanceId}"
							method="post">
							<button type="submit"
								class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded flex items-center mt-4">
								<i class="fas fa-sign-out-alt mr-2"></i> Log Out Working
							</button>
						</form>
					</c:when>
					<c:otherwise>
						<p class="text-lg font-bold mb-2">Status: PRESENT</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- Include attendance list or other components as needed -->
		<div>
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/jsp/shared/attendanceList.jsp" />
		</div>
	</div>

	<!-- JavaScript to update elapsed time -->
	<script>
		// Function to update elapsed time every second
		function updateElapsedTime() {
			var loginTime = new Date("${todayAttendance.loginTime}").getTime(); // Get login time in milliseconds
			var currentTime = new Date().getTime(); // Get current time in milliseconds

			var elapsedTime = currentTime - loginTime; // Calculate elapsed time in milliseconds

			// Convert milliseconds to hours, minutes, seconds
			var hours = Math.floor(elapsedTime / (1000 * 60 * 60));
			var minutes = Math.floor((elapsedTime % (1000 * 60 * 60))
					/ (1000 * 60));
			var seconds = Math.floor((elapsedTime % (1000 * 60)) / 1000);

			// Display elapsed time
			document.getElementById("elapsedTime").textContent = hours + "h "
					+ minutes + "m " + seconds + "s";
		}

		// Update elapsed time every second
		setInterval(updateElapsedTime, 1000);
	</script>

</body>
</html>
