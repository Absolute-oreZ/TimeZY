<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User List</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/public/index.css" />
    </head>

    <body class="bg-gray-100">
        <c:if test="${not empty alert}">
            <script>
                window.alert("${alert}");
            </script>
        </c:if>
        <section class="container mx-auto p-4">
            <div class="flex justify-between items-center">
                <c:choose>
                    <c:when test="${currentUser.role == 'ADMIN'}">
                        <h1 class="font-extrabold text-xl">User List</h1>
                        <a href="/admin/user/new"
                            class="inline-block px-4 py-2 text-lg font-semibold text-green-600 bg-white border-2 border-green-600 rounded transition duration-300 hover:bg-green-600 hover:text-white">
                            + New User </a>
                    </c:when>
                    <c:when test="${currentUser.role == 'MANAGER'}">
                        <h1 class="font-extrabold text-xl">Cleaner List</h1>
                    </c:when>
                </c:choose>
            </div>

            <div class="mt-4">
                <table class="w-full bg-white border-collapse border border-gray-300">
                    <thead>
                        <tr class="bg-gray-200">
                            <c:choose>
                                <c:when test="${currentUser.role == 'ADMIN'}">
                                    <th class="px-4 py-2 text-left">No.</th>
                                    <th class="px-4 py-2 text-left">Employee ID</th>
                                    <th class="px-4 py-2 text-left">Name</th>
                                    <th class="px-4 py-2 text-left">Email</th>
                                    <th class="px-4 py-2 text-left">Role</th>
                                    <th class="px-4 py-2 text-left">Phone Number</th>
                                    <th class="px-4 py-2 text-left">Joined At</th>
                                    <th class="px-4 py-2 text-left">Actions</th>
                                </c:when>
                                <c:when test="${currentUser.role == 'MANAGER'}">
                                    <th class="px-4 py-2 text-left">No.</th>
                                    <th class="px-4 py-2 text-left">Employee Id</th>
                                    <th class="px-4 py-2 text-left">Name</th>
                                    <th class="px-4 py-2 text-left">Email</th>
                                    <th class="px-4 py-2 text-left">Phone Number</th>
                                </c:when>
                            </c:choose>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${currentUser.role == 'ADMIN'}">
                                <c:forEach var="user" items="${cleanersAndManagers}" varStatus="loop">
                                    <tr class="border-b border-gray-300">
                                        <td class="px-4 py-2">${loop.index + 1}</td>
                                        <td class="px-4 py-2">${user.userId}</td>
                                        <td class="px-4 py-2">${user.name}</td>
                                        <td class="px-4 py-2"><a href="mailto:${user.email}"
                                                class="hover:underline hover:text-blue-500">${user.email}</a></td>
                                        <td class="px-4 py-2">${user.role.toString()}</td>
                                        <td class="px-4 py-2">${user.phone}</td>
                                        <td class="px-4 py-2">${user.createdAt}</td>
                                        <td class="px-4 py-2"><a href="/admin/user/edit/${user.userId}"
                                                class="edit-button text-blue-600">Edit</a> | <a
                                                href="/admin/user/delete/${user.userId}"
                                                class="delete-button text-red-600"
                                                onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:when test="${currentUser.role == 'MANAGER'}">
                                <c:forEach var="cleaner" items="${cleaners}" varStatus="loop">
                                    <tr class="border-b border-gray-300">
                                        <td class="px-4 py-2">${loop.index + 1}</td>
                                        <td class="px-4 py-2">${cleaner.userId}</td>
                                        <td class="px-4 py-2">${cleaner.name}</td>
                                        <td class="px-4 py-2"><a href="mailto:${cleaner.email}"
                                                class="hover:underline hover:text-blue-500">${cleaner.email}</a></td>
                                        <td class="px-4 py-2">${cleaner.phone}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </section>
    </body>

    </html>