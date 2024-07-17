package dev.young.timeZY.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.young.timeZY.model.User;
import dev.young.timeZY.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private HttpServletRequest request;

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            Model model) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        if (error != null) {
            model.addAttribute("loginError", "Invalid username or password.");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully.");
        }
        model.addAttribute("user", new User());
        model.addAttribute("contentPage", "auth/login.jsp");
        return "authLayout";
    }

    @PostMapping("/login")
    public String authenticateUser(@ModelAttribute User user, HttpServletRequest request) {
        User authenticatedUser = userService.loginByEmailAndPassword(user.getEmail(), user.getPassword());

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", authenticatedUser);
            return "redirect:/";
        } else {
            return "redirect:/login?error";
        }
    }

    @GetMapping("/logout")
    public String logOut(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }

    @GetMapping("/profile/{id}")
    public String showProfile(@PathVariable Long id, Model model, HttpServletResponse response) {
        // Add cache control headers
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // Fetch the user from the database instead of relying on session data
        User currentUser = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("contentPage", "auth/profile.jsp");
        return "index";
    }

    @GetMapping("/profile/edit/{id}")
    public String showEditProfile(@PathVariable Long id, Model model) {
        User currentUser = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("contentPage", "auth/editProfile.jsp");
        return "index";
    }

    @PostMapping("/profile/edit/{id}")
    public String updateProfile(@PathVariable Long id, @ModelAttribute User user,
            RedirectAttributes redirectAttributes, HttpSession session) {
        try {
            User existingUser = userService.getUserById(id)
                    .orElseThrow(() -> new RuntimeException("User not found!"));

            // Update only the fields that are allowed to be modified
            existingUser.setName(user.getName());
            existingUser.setPhone(user.getPhone());

            // Only update password if a new one is provided
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                existingUser.setPassword(user.getPassword());
            }

            userService.updateUser(id, existingUser);
            User updatedUser = userService.getUserById(id).orElseThrow(() -> new RuntimeException("User not found!"));

            // Update the session with the new user data
            session.setAttribute("currentUser", updatedUser);

            redirectAttributes.addFlashAttribute("alert", "Profile updated successfully!");
            return "redirect:/profile/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("editingError", "Error updating profile: " + e.getMessage());
            return "redirect:/profile/edit/" + id;
        }
    }
    
    
}