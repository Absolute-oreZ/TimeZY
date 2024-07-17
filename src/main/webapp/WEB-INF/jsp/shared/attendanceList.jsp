<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style type="text/css">
/* Button used to open the contact form - fixed at the bottom of the page */
.open-button {
	background-color: #555;
	color: white;
	padding: 4px 8px;
	border: none;
	cursor: pointer;
	opacity: 0.8;
}

/* The popup form - hidden by default */
.form-popup {
	display: none;
	position: fixed;
	bottom: 0;
	right: 15px;
	border: 3px solid #f1f1f1;
	z-index: 9;
}

/* Add styles to the form container */
.form-container {
	max-width: 300px;
	padding: 10px;
	background-color: white;
}

/* Full-width input fields */
.form-container input[type=text], .form-container input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	border: none;
	background: #f1f1f1;
}

/* When the inputs get focus, do something */
.form-container input[type=text]:focus, .form-container input[type=password]:focus
	{
	background-color: #ddd;
	outline: none;
}

/* Set a style for the submit/login button */
.form-container .btn {
	background-color: #04AA6D;
	color: white;
	padding: 16px 20px;
	border: none;
	cursor: pointer;
	width: 100%;
	margin-bottom: 10px;
	opacity: 0.8;
}

/* Add a red background color to the cancel button */
.form-container .cancel {
	background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
	opacity: 1;
}
</style>
</head>
<body class="bg-gray-100">
	<section class="container mx-auto p-4">
		<div class="flex items-center">
			<h1 class="font-extrabold text-xl">Attendances</h1>
		</div>

		<div class="mt-4">
			<table class="w-full bg-white border-collapse border border-gray-300">
				<thead>
					<tr class="bg-gray-200">
						<th class="px-4 py-2 text-left">No.</th>
						<th class="px-4 py-2 text-left">Date</th>
						<th class="px-4 py-2 text-left">Cleaner</th>
						<th class="px-4 py-2 text-left">Status</th>
						<th class="px-4 py-2 text-left">Login At</th>
						<th class="px-4 py-2 text-left">Logout At</th>
						<th class="px-4 py-2 text-left">Notes</th>
						<th class="px-4 py-2 text-left">Reason</th>
						<th class="px-4 py-2 text-left">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="attendance" items="${attendances}" varStatus="loop">
						<tr
							class="border-b border-gray-300 
                            <c:choose>
                                <c:when test="${attendance.status == 'ABSENT'}">bg-red-200 text-red-800</c:when>
                                <c:when test="${attendance.status == 'PRESENT'}">bg-green-200 text-green-800</c:when>
                                <c:when test="${attendance.status == 'LATE'}">bg-yellow-200 text-yellow-800</c:when>
                            </c:choose>">
							<td class="px-4 py-2">${loop.index + 1}</td>
							<td class="px-4 py-2"><fmt:formatDate
									value="${attendance.attendanceDate}" pattern="dd MMM yyyy" /></td>
							<td class="px-4 py-2">${attendance.cleaner.name}</td>
							<td class="px-4 py-2">${attendance.status.toString()}</td>
							<td class="px-4 py-2"><fmt:formatDate
									value="${attendance.loginTime}" pattern="hh:mm:ss" /></td>
							<td class="px-4 py-2"><fmt:formatDate
									value="${attendance.logoutTime}" pattern="hh:mm:ss" /></td>
							<td class="px-4 py-2"><pre>${attendance.notes}</pre></td>
							<td class="px-4 py-2">${attendance.reason}</td>
							<td class="px-4 py-2"><c:choose>
									<c:when test="${currentUser.role == 'CLEANER'}">
										<c:if test="${attendance.status == 'ABSENT'}">
											<button class="open-button"
												onclick="openForm('${attendance.attendanceId}', 'reason')">Add
												Reason</button>
										</c:if>
									</c:when>
									<c:otherwise>
										<button class="open-button"
											onclick="openForm('${attendance.attendanceId}', 'note')">Leave
											a Note</button>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- Reason Form -->
		<div class="form-popup" id="reasonForm" style="display: none;">
			<form id="reasonFormInner" action="" class="form-container">
				<h1>Add Reason</h1>
				<label for="reason"><b>Reason</b></label> <input type="text"
					placeholder="Enter reason" id="reason" name="reason" required>
				<button type="submit" class="btn">Send Reason</button>
				<button type="button" class="btn cancel"
					onclick="closeForm('reason')">Close</button>
			</form>
		</div>

		<!-- Note Form -->
		<div class="form-popup" id="noteForm" style="display: none;">
			<form id="noteFormInner" action="" class="form-container">
				<h1>Leave a Note</h1>
				<label for="notes"><b>Notes</b></label> <input type="text"
					placeholder="Enter notes" id="notes" name="notes" required>
				<button type="submit" class="btn">Send Note</button>
				<button type="button" class="btn cancel" onclick="closeForm('note')">Close</button>
			</form>
		</div>

	</section>

	<script>
		function openForm(attendanceId, formType) {
			if (formType === 'reason') {
				document.getElementById("reasonForm").style.display = "block";
				document.getElementById("reasonFormInner").action = "/cleaner/attendance/"
						+ attendanceId + "/reason";
			} else if (formType === 'note') {
				document.getElementById("noteForm").style.display = "block";
				document.getElementById("noteFormInner").action = "/manager/attendance/"
						+ attendanceId + "/note";
			}
		}

		function closeForm(formType) {
			if (formType === 'reason') {
				document.getElementById("reasonForm").style.display = "none";
			} else if (formType === 'note') {
				document.getElementById("noteForm").style.display = "none";
			}
		}
	</script>
</body>
</html>
