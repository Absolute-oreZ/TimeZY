package dev.young.timeZY.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

// import io.young.timeZY.model.Task;
// import io.young.timeZY.service.TaskService;

@Controller
@RequestMapping("/tasks")
public class TaskController {

    // @Autowired
    // private TaskService taskService;

    @GetMapping
    public String listTasks(Model model) {
        // List<Task> tasks = taskService.getAllTasks();
        // model.addAttribute("tasks", tasks);
        model.addAttribute("contentPage", "tasks/list.jsp");
        return "rootLayout";
    }

    // @GetMapping("/create")
    // public String showCreateForm(Model model) {
    //     model.addAttribute("task", new Task());
    //     model.addAttribute("contentPage", "tasks/create.jsp");
    //     return "rootLayout";
    // }

    // @PostMapping("/create")
    // public String createTask(@ModelAttribute Task task) {
    //     taskService.createTask(task);
    //     return "redirect:/tasks";
    // }

    // @GetMapping("/edit/{id}")
    // public String showEditForm(@PathVariable Long id, Model model) {
    //     Task task = taskService.getTaskbyId(id).orElseThrow(() -> new RuntimeException("Task not found!"));
    //     model.addAttribute("task", task);
    //     model.addAttribute("contentPage", "tasks/edit.jsp");
    //     return "rootLayout";
    // }

    // @PostMapping("/edit/{id}")
    // public String updateTask(@PathVariable Long id, @ModelAttribute Task task) {
    //     taskService.updateTask(id, task);
    //     return "redirect:/tasks";
    // }

    // @GetMapping("/delete/{id}")
    // public String deleteTask(@PathVariable Long id) {
    //     taskService.deleteTask(id);
    //     return "redirect:/tasks";
    // }

}
