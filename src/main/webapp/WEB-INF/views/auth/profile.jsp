<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <body class="bg-gray-100">
                <c:if test="${not empty alert}">
                    <script>
                        window.alert("${alert}");
                    </script>
                </c:if>
                <div class="flex items-center justify-center h-[90%]">
                    <div class="w-full max-w-3xl">
                        <div class="bg-white shadow-md rounded-lg overflow-hidden">
                            <div class="p-6 md:p-8">
                                <div class="flex items-center justify-between mb-6">
                                    <h2 class="text-2xl font-semibold text-gray-800">User Profile</h2>
                                    <a href="/profile/edit/${currentUser.userId}"
                                        class="text-blue-500 hover:text-blue-600">
                                        <i class="fas fa-edit fa-lg"></i> Edit Profile
                                    </a>
                                </div>
                                <div class="flex flex-col md:flex-row md:space-x-6">
                                    <!-- Left Column -->
                                    <div class="flex-shrink-0 w-full md:w-1/3 mb-6 md:mb-0">
                                        <div class="bg-gray-200 rounded-lg overflow-hidden">
                                            <img class="h-64 w-full object-cover"
                                                src="https://www.gravatar.com/avatar/<c:out value="
                                                ${currentUser.email}" />?s=400"
                                            alt="User Avatar">
                                            <div class="p-4">
                                                <h3 class="text-lg font-semibold text-gray-800">${currentUser.name}</h3>
                                                <p class="text-sm text-gray-600">${currentUser.email}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Right Column -->
                                    <div class="w-full md:w-2/3">
                                        <div class="bg-white rounded-lg shadow-md p-6">
                                            <div class="flex items-center mb-4">
                                                <i class="fas fa-user fa-lg text-gray-600 mr-2"></i>
                                                <div>
                                                    <p class="text-sm font-medium text-gray-600">Role:
                                                        ${currentUser.role}</p>
                                                    <p class="text-sm font-medium text-gray-600">Joined:
                                                        <fmt:formatDate value="${currentUser.createdAt}"
                                                            pattern="MMM dd, yyyy 'at' HH:mm" />
                                                    </p>
                                                    <p class="text-sm font-medium text-gray-600">Last Updated:
                                                        <fmt:formatDate value="${currentUser.updatedAt}"
                                                            pattern="MMM dd, yyyy 'at' HH:mm" />
                                                    </p>
                                                </div>
                                            </div>
                                            <hr class="my-4">
                                            <div class="flex items-center mb-4">
                                                <i class="fas fa-envelope fa-lg text-gray-600 mr-2"></i>
                                                <p class="text-sm font-medium text-gray-600">${currentUser.email}</p>
                                            </div>
                                            <div class="flex items-center mb-4">
                                                <i class="fas fa-phone fa-lg text-gray-600 mr-2"></i>
                                                <p class="text-sm font-medium text-gray-600">${currentUser.phone}</p>
                                            </div>
                                            <div class="flex items-center">
                                                <i class="fas fa-lock fa-lg text-gray-600 mr-2"></i>
                                                <p class="text-sm font-medium text-gray-600">********</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>

            </html>