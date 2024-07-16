<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <body class="bg-gray-100">
                <div class="flex items-center justify-center h-[90%]">
                    <div class="w-full max-w-3xl">
                        <div class="bg-white shadow-md rounded-lg overflow-hidden">
                            <div class="p-6 md:p-8">
                                <div class="flex items-center justify-between mb-6">
                                    <h2 class="text-2xl font-semibold text-gray-800">Edit Profile</h2>
                                    <a href="/profile/${currentUser.userId}" class="text-blue-500 hover:text-blue-600">
                                        <i class="fas fa-arrow-left fa-lg"></i> Back to Profile
                                    </a>
                                </div>
                                <div id="editingError" class="text-red-500 mb-4">
                                    <% String editingError=(String) request.getAttribute("editingError"); if
                                        (editingError !=null) { out.print(editingError); } %>
                                </div>
                                <form action="/profile/edit/${currentUser.userId}" method="POST" onsubmit="return validateForm()">
                                    <div class="mb-6">
                                        <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                                        <input type="text" id="name" name="name" value="${currentUser.name}"
                                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                    </div>
                                    <div class="mb-6">
                                        <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                        <input type="email" id="email" name="email" value="${currentUser.email}"
                                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                            readonly>
                                        <p class="mt-2 text-sm text-gray-500">Email cannot be changed.</p>
                                    </div>
                                    <div class="mb-6">
                                        <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                                        <input type="text" id="phone" name="phone" value="${currentUser.phone}"
                                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                    </div>
                                    <div class="mb-6">
                                        <label for="password"
                                            class="block text-sm font-medium text-gray-700">Password</label>
                                        <input type="password" id="password" name="password" placeholder="********"
                                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        <p class="mt-2 text-sm text-gray-500">Leave blank to keep current password.</p>
                                    </div>
                                    <div class="flex justify-end">
                                        <button type="submit"
                                            class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                            Save Changes
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    function validateForm() {
                        var password = document.getElementById("password").value;
                
                        if (password !== "" && (password.length < 8 || password.length > 20)) {
                            alert("Password must be between 8 to 20 characters.");
                            return false;
                        }
                
                        return true;
                    }
                </script>
                
            </body>

            </html>