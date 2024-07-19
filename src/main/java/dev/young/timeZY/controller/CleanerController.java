package dev.young.timeZY.controller;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.young.timeZY.enums.AttendanceStatus;
import dev.young.timeZY.model.Attendance;
import dev.young.timeZY.model.Task;
import dev.young.timeZY.model.User;
import dev.young.timeZY.service.AttendanceService;
import dev.young.timeZY.service.TaskService;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/cleaner")
public class CleanerController {

	private final AttendanceService attendanceService;
	final TaskService taskService;

	@Autowired
	public CleanerController(AttendanceService attendanceService, TaskService taskService) {
		this.attendanceService = attendanceService;
		this.taskService = taskService;
	}

	@GetMapping("/attendances")
	public String showTodayAttendance(Model model, HttpServletRequest request) {
		User cleaner = (User) request.getSession().getAttribute("currentUser");
		LocalDate todayDate = LocalDate.now();

		// Fetch today's attendance for the current user
		Attendance todayAttendance = attendanceService.getAllByAttendanceDateAndCleaner(todayDate, cleaner);

		List<Attendance> attendances = attendanceService.getAllByCleaner(cleaner);

		// Add attendance and other necessary attributes to the model
		model.addAttribute("todayAttendance", todayAttendance);
		model.addAttribute("attendances", attendances);
		model.addAttribute("contentPage", "cleaner/cleanerAttendance.jsp");

		return "rootLayout";
	}

	// Tasks
	@GetMapping("/tasks")
	public String showTaskLists(Model model, HttpServletRequest request) {
		User currentCleaner = (User) request.getSession().getAttribute("currentUser");
		List<Task> tasks = taskService.getAllTasksByCleaner(currentCleaner);
		System.out.println(tasks.size());
		model.addAttribute("tasks", tasks);
		model.addAttribute("contentPage", "shared/taskList.jsp");
		return "rootLayout";
	}

	@PostMapping("/log-in-working/{id}")
	public String logInWorking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			Attendance todayAttendance = attendanceService.getAttendanceById(id)
					.orElseThrow(() -> new RuntimeException("Attendance record not found"));

			if (todayAttendance.getLoginTime() != null) {
				redirectAttributes.addFlashAttribute("alert", "Already logged in today!");
			}

			todayAttendance.setLoginTime(Timestamp.valueOf(LocalDateTime.now()));
			todayAttendance.setStatus(AttendanceStatus.PRESENT);

			attendanceService.saveAttendance(todayAttendance);

			redirectAttributes.addFlashAttribute("alert", "Successfully logged in working!");
			return "redirect:/";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error logging in working: " + e.getMessage());
		}
		return "redirect:/";
	}

	@PostMapping("/log-out-working/{id}")
	public String logOutWorking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		try {
			Attendance todayAttendance = attendanceService.getAttendanceById(id)
					.orElseThrow(() -> new RuntimeException("Attendance record not found"));

			if (todayAttendance.getLogoutTime() != null) {
				redirectAttributes.addFlashAttribute("alert", "Already logged out today!");
			}

			todayAttendance.setLogoutTime(Timestamp.valueOf(LocalDateTime.now()));
			attendanceService.saveAttendance(todayAttendance);

			redirectAttributes.addFlashAttribute("alert", "Logged out successfully!");
			return "redirect:/";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error logging out working: " + e.getMessage());
		}
		return "redirect:/";
	}

	@PostMapping("/task/change-status/{taskId}")
	public String changeTaskStatus(@PathVariable Long taskId, @RequestParam("status") String status,
			RedirectAttributes redirectAttributes) {
		try {
			Task updatedTask = taskService.updateTaskStatus(taskId, status);
			if (updatedTask != null) {
				redirectAttributes.addFlashAttribute("alert", "Task status updated successfully!");
			} else {
				redirectAttributes.addFlashAttribute("alert", "Unable to update task status.");
			}
		} catch (IllegalArgumentException e) {
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error updating task status: " + e.getMessage());
		}
		return "redirect:/cleaner/tasks";
	}

	@GetMapping("/attendance/{id}/reason")
	public String leaveReason(@PathVariable Long id, @RequestParam("reason") String reason,
			RedirectAttributes redirectAttributes) {
		try {
			Attendance existingAttendance = attendanceService.getAttendanceById(id)
					.orElseThrow(() -> new RuntimeException("Attendance not found!"));
			existingAttendance.setReason(reason);

			attendanceService.updateAttendance(id, existingAttendance);
			// Add flash attribute to display success message on the redirected page
			redirectAttributes.addFlashAttribute("alert", "Reason '" + reason + "' sent successfully!");
			return "redirect:/";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "Error sending reason: " + e.getMessage());
		}
		return "redirect:/cleaner/attendances/" + id;
	}

}
