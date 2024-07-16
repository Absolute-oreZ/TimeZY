package dev.young.timeZY.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.young.timeZY.enums.TaskCategory;
import dev.young.timeZY.enums.TaskPriority;
import dev.young.timeZY.enums.UserRole;
import dev.young.timeZY.model.Attendance;
import dev.young.timeZY.model.Location;
import dev.young.timeZY.model.Task;
import dev.young.timeZY.model.User;
import dev.young.timeZY.service.AttendanceService;
import dev.young.timeZY.service.EmailService;
import dev.young.timeZY.service.LocationService;
import dev.young.timeZY.service.TaskService;
import dev.young.timeZY.service.UserService;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private final UserService userService;
	private final AttendanceService attendanceService;
	private final LocationService locationService;
	private final EmailService emailService;
	private final TaskService taskService;

	@Autowired
	public AdminController(UserService userService, AttendanceService attendanceService,
			LocationService locationService, EmailService emailService, TaskService taskService) {
		this.userService = userService;
		this.attendanceService = attendanceService;
		this.locationService = locationService;
		this.emailService = emailService;
		this.taskService = taskService;
	}

	@GetMapping
	public String dashboard(Model model) {
		// Fetch data from service layer
		int totalUsers = userService.getTotalUsers();
		int activeTasks = taskService.getActiveTasks();
		double attendanceRate = attendanceService.getAttendanceRate();
		Map<String, Double> taskProgressions = taskService.getTaskProgressions();
		List<Attendance> recentAttendance = attendanceService.getRecentAttendance(10);

		// Add attributes to the model
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("activeTasks", activeTasks);
		model.addAttribute("attendanceRate", attendanceRate);
		model.addAttribute("taskCreatedPercentage", taskProgressions.get("CREATED"));
		model.addAttribute("taskInProgressPercentage", taskProgressions.get("IN_PROGRESS"));
		model.addAttribute("taskCompletedPercentage", taskProgressions.get("COMPLETED"));
		model.addAttribute("taskOverduePercentage", taskProgressions.get("OVERDUE"));
		model.addAttribute("recentAttendance", recentAttendance);

		model.addAttribute("contentPage", "admin/adminDashboard.jsp");
		return "rootLayout";
	}

	// User
	@GetMapping("/users")
	public String listUsers(Model model) {
		List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
		List<User> manager = userService.getAllUsersByRole(UserRole.MANAGER);
		List<User> cleanersAndManagers = Stream.concat(cleaners.stream(), manager.stream())
				.collect(Collectors.toList());
		model.addAttribute("cleanersAndManagers", cleanersAndManagers);
		model.addAttribute("contentPage", "shared/userList.jsp");
		return "rootLayout";
	}

	@GetMapping("/user/new")
	public String showCreateForm(@RequestParam(value = "error", required = false) String error, Model model) {
		model.addAttribute("user", new User());
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "admin/registerNewUser.jsp");
		return "rootLayout";
	}

	@GetMapping("/user/edit/{id}")
	public String showEditForm(@PathVariable Long id, Model model) {
		User user = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));
		model.addAttribute("user", user);
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "admin/editUser.jsp");
		return "rootLayout";
	}

	@GetMapping("/user/delete/{id}")
	public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			User deletedUser = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));
			userService.deleteUser(id);

			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "User " + deletedUser.getName() + " deleted successfully!");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error deleting user: " + e.getMessage());
		}

		return "redirect:/admin/users";
	}

	// Profile
	@GetMapping("/profile/{id}")
	public String showProfile(@PathVariable Long id, Model model) {
		model.addAttribute("pageContent", "shared/profile.jsp");
		return "rootLayout";
	}

	// Attendance
	@GetMapping("/cleaners/attendances")
	public String showAttendanceList(Model model) {
		List<Attendance> attendances = attendanceService.getAllAttendanceSortedByDateDescending();
		model.addAttribute("attendances", attendances);
		model.addAttribute("contentPage", "shared/attendanceList.jsp");
		return "rootLayout";
	}

	@GetMapping("/cleaners/attendance/{id}/note")
	public String leaveNote(Model model, @PathVariable Long id, @RequestParam("notes") String notes,
			RedirectAttributes redirectAttributes) {
		try {
			Attendance existingAttendance = attendanceService.getAttendanceById(id)
					.orElseThrow(() -> new RuntimeException("Attendance not found!"));
			// Set email from existing user
			// Append new note with a newline character
			String existingNotes = existingAttendance.getNotes();
			String updatedNotes = existingNotes + "\n" + notes.trim(); // Adding trim() to ensure no leading/trailing
																		// whitespace
			existingAttendance.setNotes(updatedNotes);

			attendanceService.updateAttendance(id, existingAttendance);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "Notes " + notes + " sent!");
			return "redirect:/admin/cleaners/attendances";
		} catch (Exception e) {
			model.addAttribute("editingError", "Error sending notes: " + e.getMessage());
		}
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "admin/editUser.jsp");
		return "rootLayout";
	}

	// Location
	@GetMapping("/locations")
	public String showLocation(Model model) {
		List<Location> locations = locationService.getAllLocation();
		model.addAttribute("locations", locations);
		model.addAttribute("contentPage", "admin/locationList.jsp");
		return "rootLayout";
	}

	@GetMapping("/location/new")
	public String showCreateLocationForm(Model model) {
		model.addAttribute("location", new Location());
		model.addAttribute("contentPage", "admin/registerNewLocation.jsp");
		return "rootLayout";
	}

	@GetMapping("/location/edit/{id}")
	public String showEditLocationForm(@PathVariable Long id, Model model) {
		Location location = locationService.getLocationById(id)
				.orElseThrow(() -> new RuntimeException("Location not found!"));
		model.addAttribute("location", location);
		model.addAttribute("contentPage", "admin/editLocation.jsp");
		return "rootLayout";
	}

	@GetMapping("/location/delete/{id}")
	public String deleteLocation(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			Location deletedLocation = locationService.getLocationById(id)
					.orElseThrow(() -> new RuntimeException("Location not found!"));
			locationService.deleteLocation(id);

			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert",
					"Location " + deletedLocation.getLocationName() + " deleted successfully!");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error deleting locatoon: " + e.getMessage());
		}

		return "redirect:/admin/locations";
	}

	// Tasks
	@GetMapping("/tasks")
	public String showTaskLists(Model model) {
		List<Task> tasks = taskService.getAllTask();
		model.addAttribute("tasks", tasks);
		model.addAttribute("contentPage", "shared/taskList.jsp");
		return "rootLayout";
	}

	@GetMapping("/task/new")
	public String showCreateTaskForm(@RequestParam(value = "error", required = false) String error, Model model) {
		List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
		List<Location> locations = locationService.getAllLocation();
		model.addAttribute("task", new Task());
		model.addAttribute("cleaners", cleaners);
		model.addAttribute("locations", locations);
		model.addAttribute("taskCategory", Arrays.asList(TaskCategory.values()));
		model.addAttribute("taskPriority", Arrays.asList(TaskPriority.values()));
		model.addAttribute("contentPage", "shared/registerNewTask.jsp");
		return "rootLayout";
	}

	@GetMapping("/task/edit/{id}")
	public String showEditTaskForm(@PathVariable Long id, @RequestParam(value = "error", required = false) String error,
			Model model) {
		List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
		List<Location> locations = locationService.getAllLocation();
		Task task = taskService.getTaskById(id).orElseThrow(() -> new RuntimeException("Task not found!"));
		model.addAttribute("task", task);
		model.addAttribute("cleaners", cleaners);
		model.addAttribute("locations", locations);
		model.addAttribute("taskCategory", Arrays.asList(TaskCategory.values()));
		model.addAttribute("taskPriority", Arrays.asList(TaskPriority.values()));
		model.addAttribute("contentPage", "shared/editTask.jsp");
		return "rootLayout";
	}

	@GetMapping("/task/delete/{id}")
	public String deleteTask(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			Task deletedTask = taskService.getTaskById(id).orElseThrow(() -> new RuntimeException("Task not found!"));
			taskService.deleteTask(id);

			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert",
					"Task " + deletedTask.getTaskName() + " deleted successfully!");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error deleting task: " + e.getMessage());
		}

		return "redirect:/admin/tasks";
	}

	@PostMapping("/user/new")
	public String createUser(@ModelAttribute User user, Model model, RedirectAttributes redirectAttributes) {
		try {
			userService.saveUser(user);

			String to = user.getEmail();
			String subject = "Your Password For TimeZY";
			String text = "<html><body><h1>Your Password For TimeZY</h1>" + "<h3>Hello " + user.getName() + ",</h3>"
					+ "<p>Please use the following password for logging into TimeZY:</p>" + "<p>" + user.getPassword()
					+ "</p>" + "<br><br>" + "<img src='cid:logoImage'></body></html>";
			String imagePath = "static/assets/images/Welcoming Image.png";

			emailService.sendEmailWithInlineImage(to, subject, text, imagePath);

			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "User " + user.getName() + " created successfully!");
			return "redirect:/admin/users";
		} catch (DataIntegrityViolationException e) {
			model.addAttribute("registerError", "This email has been used in another account.");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("registerError", "Unknown error occurred. Please try again.");
		}

		model.addAttribute("user", user);
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "admin/registerNewUser.jsp");
		return "rootLayout";
	}

	@PostMapping("/location/new")
	public String createLocation(@ModelAttribute Location location, Model model,
			RedirectAttributes redirectAttributes) {
		try {
			locationService.saveLocation(location);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert",
					"Location " + location.getLocationName() + " created successfully!");
			return "redirect:/admin/locations";
		} catch (Exception e) {
			model.addAttribute("registerError", "Unknown error occurred. Please try again.");
		}
		model.addAttribute("contentPage", "admin/registerNewUser.jsp");
		return "rootLayout";
	}

	@PostMapping("/user/edit/{id}")
	public String updateUser(@PathVariable Long id, @ModelAttribute User user, Model model,
			RedirectAttributes redirectAttributes) {
		try {
			User existingUser = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));
			// Set email from existing user
			user.setEmail(existingUser.getEmail());
			user.setUserId(id);
			userService.updateUser(id, user);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "User " + user.getName() + " updated successfully!");
			return "redirect:/admin/users";
		} catch (Exception e) {
			model.addAttribute("editingError", "Error updating user: " + e.getMessage());
		}

		model.addAttribute("user", user);
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "admin/editUser.jsp");
		return "rootLayout";
	}

	@PostMapping("/location/edit/{id}")
	public String updateLocation(@PathVariable Long id, @ModelAttribute Location location, Model model,
			RedirectAttributes redirectAttributes) {
		try {
			location.setLocationId(id);
			locationService.updateLocation(id, location);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert",
					"Location " + location.getLocationName() + " updated successfully!");
			return "redirect:/admin/locations";
		} catch (Exception e) {
			model.addAttribute("editingError", "Error updating location: " + e.getMessage());
		}

		model.addAttribute("location", location);
		model.addAttribute("contentPage", "admin/editLocation.jsp");
		return "rootLayout";
	}

	@PostMapping("/task/new")
	public String assignTask(@RequestParam("taskName") String taskName,
			@RequestParam("taskDescription") String taskDescription, @RequestParam("cleaner") Long cleanerId,
			@RequestParam("location") Long locationId, @RequestParam("taskDeadline") String taskDeadlineStr,
			@RequestParam("taskCategory") TaskCategory taskCategory,
			@RequestParam("taskPriority") TaskPriority taskPriority, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		try {
			Task task = new Task();
			task.setTaskName(taskName);
			task.setTaskDescription(taskDescription);
			task.setTaskCategory(taskCategory);
			task.setTaskPriority(taskPriority);

			// Parse the taskDeadlineStr to Timestamp
			Timestamp taskDeadline = datetimeLocalToTimestamp(taskDeadlineStr);

			// Fetch entities from IDs
			User cleaner = userService.getUserById(cleanerId)
					.orElseThrow(() -> new RuntimeException("Cleaner not found"));
			User currentUser = (User) request.getSession().getAttribute("currentUser");
			Location location = locationService.getLocationById(locationId)
					.orElseThrow(() -> new RuntimeException("Location not found"));

			// Set the fetched entities and converted timestamp
			task.setCleaner(cleaner);
			task.setManager(currentUser);
			task.setLocation(location);
			task.setTaskDeadline(taskDeadline);

			taskService.saveTask(task);
			redirectAttributes.addFlashAttribute("alert", "Task " + task.getTaskName() + " created successfully!");
			return "redirect:/admin/tasks";
		} catch (Exception e) {
			model.addAttribute("registerError", "Error creating task: " + e.getMessage());
			// Re-populate form data
			List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
			List<Location> locations = locationService.getAllLocation();
			model.addAttribute("cleaners", cleaners);
			model.addAttribute("locations", locations);
			model.addAttribute("taskCategory", Arrays.asList(TaskCategory.values()));
			model.addAttribute("taskPriority", Arrays.asList(TaskPriority.values()));
			model.addAttribute("contentPage", "shared/registerNewTask.jsp");
			return "rootLayout";
		}
	}

	@PostMapping("/task/edit/{id}")
	public String updateTask(@PathVariable Long id, @RequestParam("taskName") String taskName,
			@RequestParam("taskDescription") String taskDescription, @RequestParam("cleaner") Long cleanerId,
			@RequestParam("location") Long locationId, @RequestParam("taskDeadline") String taskDeadlineStr,
			@RequestParam("taskCategory") TaskCategory taskCategory,
			@RequestParam("taskPriority") TaskPriority taskPriority, Model model, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		try {
			Task task = taskService.getTaskById(id).orElseThrow(null);
			task.setTaskName(taskName);
			task.setTaskDescription(taskDescription);
			task.setTaskCategory(taskCategory);
			task.setTaskPriority(taskPriority);

			// Parse the taskDeadlineStr to Timestamp
			Timestamp taskDeadline = datetimeLocalToTimestamp(taskDeadlineStr);

			// Fetch entities from IDs
			User cleaner = userService.getUserById(cleanerId)
					.orElseThrow(() -> new RuntimeException("Cleaner not found"));
			User currentUser = (User) request.getSession().getAttribute("currentUser");
			Location location = locationService.getLocationById(locationId)
					.orElseThrow(() -> new RuntimeException("Location not found"));

			// Set the fetched entities and converted timestamp
			task.setCleaner(cleaner);
			task.setManager(currentUser);
			task.setLocation(location);
			task.setTaskDeadline(taskDeadline);

			taskService.updateTask(id, task);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "Task " + task.getTaskName() + " updated successfully!");
			return "redirect:/admin/tasks";
		} catch (Exception e) {
			model.addAttribute("editingError", "Error updating location: " + e.getMessage());
			List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
			List<Location> locations = locationService.getAllLocation();
			model.addAttribute("cleaners", cleaners);
			model.addAttribute("locations", locations);
			model.addAttribute("taskCategory", Arrays.asList(TaskCategory.values()));
			model.addAttribute("taskPriority", Arrays.asList(TaskPriority.values()));
			model.addAttribute("contentPage", "shared/editTask.jsp");
			return "rootLayout";
		}
	}

	protected Timestamp datetimeLocalToTimestamp(String dateTimeStr) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			Date parsed = formatter.parse(dateTimeStr);
			return new Timestamp(parsed.getTime());
		} catch (java.text.ParseException e) {
			throw new RuntimeException("Error parsing date: " + dateTimeStr, e);
		}
	}

}
