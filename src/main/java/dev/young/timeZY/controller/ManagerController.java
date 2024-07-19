package dev.young.timeZY.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.young.timeZY.enums.TaskCategory;
import dev.young.timeZY.enums.TaskPriority;
import dev.young.timeZY.enums.UserRole;
import dev.young.timeZY.model.Attendance;
import dev.young.timeZY.model.Location;
import dev.young.timeZY.model.Task;
import dev.young.timeZY.model.User;
import dev.young.timeZY.service.AttendanceService;
import dev.young.timeZY.service.LocationService;
import dev.young.timeZY.service.TaskService;
import dev.young.timeZY.service.UserService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	private final UserService userService;
	private final AttendanceService attendanceService;
	private final LocationService locationService;
	private final TaskService taskService;

	@Autowired
	public ManagerController(UserService userService, AttendanceService attendanceService,
			LocationService locationService, TaskService taskService) {
		this.userService = userService;
		this.attendanceService = attendanceService;
		this.locationService = locationService;
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

				model.addAttribute("contentPage", "manager/managerDashboard.jsp");
				return "rootLayout";
	}

	// User
	@GetMapping("/cleaners")
	public String listUsers(Model model) {
		List<User> cleaners = userService.getAllUsersByRole(UserRole.CLEANER);
		model.addAttribute("cleaners", cleaners);
		model.addAttribute("contentPage", "shared/userList.jsp");
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

	@GetMapping("/attendance/{id}/note")
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
			return "redirect:/manager/cleaners/attendances";
		} catch (Exception e) {
			model.addAttribute("editingError", "Error sending notes: " + e.getMessage());
		}
		model.addAttribute("userRoles", Arrays.asList(UserRole.values()));
		model.addAttribute("contentPage", "manager/editUser.jsp");
		return "rootLayout";
	}

	// Tasks
	@GetMapping("/tasks")
	public String showTaskLists(Model model, HttpServletRequest request) {
		User currentManager = (User) request.getSession().getAttribute("currentUser");
		List<Task> tasks = taskService.getAllTasksByManager(currentManager);
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
			Task deletedTask = taskService.getTaskById(id)
					.orElseThrow(() -> new RuntimeException("Task not found!"));
			taskService.deleteTask(id);

			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert",
					"Task " + deletedTask.getTaskName() + " deleted successfully!");

		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error deleting task: " + e.getMessage());
		}

		return "redirect:/manager/tasks";
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
			return "redirect:/manager/tasks";
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
			redirectAttributes.addFlashAttribute("alert",
					"Task " + task.getTaskName() + " updated successfully!");
			return "redirect:/manager/tasks";
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
