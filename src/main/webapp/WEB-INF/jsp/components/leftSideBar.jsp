<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav class="px-6 py-10 flex flex-col justify-between w-full bg-gray-900 dark:bg-gradient-to-t dark:from-gray-400">
	<div class="flex flex-col gap-11">
		<ul class="flex flex-col gap-6">
			<!-- Conditional links based on currentUser.role -->
			<!-- Admin-specific links -->
			<c:if test="${currentUser.role == 'ADMIN'}">
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/admin/users" class="text-white hover:text-gray-800">Users</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/admin/cleaners/attendances"
					class="text-white hover:text-gray-800">Attendance</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/admin/locations" class="text-white hover:text-gray-800">Locations</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/admin/tasks" class="text-white hover:text-gray-800">Tasks</a>
				</li>
			</c:if>

			<!-- Manager-specific links -->
			<c:if test="${currentUser.role == 'MANAGER'}">
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/manager/cleaners" class="text-white hover:text-gray-800">Cleaners</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/manager/cleaners/attendances"
					class="text-white hover:text-gray-800">Attendance</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/manager/tasks" class="text-white hover:text-gray-800">Tasks</a>
				</li>
			</c:if>

			<!-- Cleaner-specific links -->
			<c:if test="${currentUser.role == 'CLEANER'}">
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/cleaner/attendances"
					class="text-white hover:text-gray-800">My Attendance</a>
				</li>
				<li
					class="rounded-lg px-2 py-3 base-medium hover:bg-slate-500 transition">
					<a href="/cleaner/tasks" class="text-white hover:text-gray-800">My Tasks</a>
				</li>
			</c:if>
		</ul>
	</div>

	<!-- Always visible logout button -->
	<a
		class="px-4 py-2 text-white text-md font-semibold uppercase rounded-lg transition duration-300 hover:text-rose-500"
		href="/logout"> Log Out </a>
</nav>
