<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="lg:hidden fixed inset-x-0 bottom-0 w-full bg-gray-900 text-white border-t border-gray-300 h-16 flex flex-col lg:flex-row items-center justify-center px-4">
    <div class="flex flex-wrap justify-center lg:justify-start items-center space-x-4 lg:space-x-8">
        <!-- Conditional links based on currentUser.role -->
        <!-- Admin-specific links -->
        <c:if test="${currentUser.role == 'ADMIN'}">
            <a href="/admin/users" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-users fa-lg"></i> <span>Users</span>
            </a>
            <a href="/admin/cleaners/attendances" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="far fa-calendar-check fa-lg"></i> <span>Attendance</span>
            </a>
            <a href="/admin/locations" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-map-marker-alt fa-lg"></i> <span>Locations</span>
            </a>
            <a href="/admin/tasks" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-tasks fa-lg"></i> <span>Tasks</span>
            </a>
        </c:if>

        <!-- Manager-specific links -->
        <c:if test="${currentUser.role == 'MANAGER'}">
            <a href="/manager/cleaners" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-users fa-lg"></i> <span>Cleaners</span>
            </a>
            <a href="/manager/cleaners/attendances" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="far fa-calendar-check fa-lg"></i> <span>Attendance</span>
            </a>
            <a href="/manager/tasks" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-tasks fa-lg"></i> <span>Tasks</span>
            </a>
        </c:if>

        <!-- Cleaner-specific links -->
        <c:if test="${currentUser.role == 'CLEANER'}">
            <a href="/cleaner/attendances" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="far fa-calendar-alt fa-lg"></i> <span>My Attendance</span>
            </a>
            <a href="/cleaner/tasks" class="text-gray-300 hover:text-white flex items-center space-x-2">
                <i class="fas fa-tasks fa-lg"></i> <span>My Tasks</span>
            </a>
        </c:if>
    </div>
    <div class="mt-4 lg:mt-0">
        <a href="/logout" class="text-gray-300 hover:text-white">Log Out</a>
    </div>
</footer>