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
        return "index";
    }
}
