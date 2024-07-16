package dev.young.timeZY.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dev.young.timeZY.enums.UserRole;
import dev.young.timeZY.model.User;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RootController {

	@GetMapping("/")
	public String home(Model model, HttpServletRequest request) {
		User currentUser = (User) request.getSession().getAttribute("currentUser");

		if (currentUser != null) {
			if (currentUser.getRole().equals(UserRole.ADMIN)) {
				return "redirect:/admin";
			} else if (currentUser.getRole().equals(UserRole.MANAGER)) {
				return "redirect:/manager";
			} else if (currentUser.getRole().equals(UserRole.CLEANER)) {
				return "redirect:/cleaner/attendances";
			} else {
				return "redirect:/login";
			}
		} else {
			return "redirect:/login";
		}
	}
}
