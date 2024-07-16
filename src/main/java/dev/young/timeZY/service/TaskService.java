package dev.young.timeZY.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.young.timeZY.enums.TaskStatus;
import dev.young.timeZY.model.Task;
import dev.young.timeZY.model.User;
import dev.young.timeZY.repository.TaskRepository;

@Service
public class TaskService {
	@Autowired
	TaskRepository taskRepository;

	public void saveTask(Task task) {
		taskRepository.save(task);
	}

	public List<Task> getAllTask() {
		return taskRepository.findAll();
	}

	public Optional<Task> getTaskById(long userId) {
		return taskRepository.findById(userId);
	}

	public void updateTask(Long id, Task task) {
		taskRepository.save(task);
	}

	public void updateTaskStatus(Long id, Task task) {
		taskRepository.save(task);
	}

	public void deleteTask(Long id) {
		taskRepository.deleteById(id);
	}

	public List<Task> getAllTasksByManager(User manager) {
		return taskRepository.findAllByManager(manager);
	}

	public List<Task> getAllTasksByCleaner(User cleaner) {
		return taskRepository.findAllByCleaner(cleaner);
	}

	public Task updateTaskStatus(Long taskId, String newStatus) {
		Task task = taskRepository.findById(taskId)
				.orElseThrow(() -> new IllegalArgumentException("Task not found with id: " + taskId));

		TaskStatus currentStatus = task.getStatus();
		TaskStatus updatedStatus;
		try {
			updatedStatus = TaskStatus.valueOf(newStatus);
		} catch (IllegalArgumentException e) {
			throw new IllegalArgumentException("Invalid status: " + newStatus);
		}

		if (currentStatus == TaskStatus.OVERDUE || currentStatus == TaskStatus.COMPLETED) {
			throw new IllegalArgumentException("Cannot change status for this task!");
		} else if (currentStatus == TaskStatus.CREATED) {
			if (updatedStatus == TaskStatus.IN_PROGRESS || updatedStatus == TaskStatus.COMPLETED) {
				task.setStatus(updatedStatus);
			} else {
				throw new IllegalArgumentException("Invalid status change!");
			}
		} else if (currentStatus == TaskStatus.IN_PROGRESS) {
			if (updatedStatus == TaskStatus.COMPLETED) {
				task.setStatus(updatedStatus);
			} else {
				throw new IllegalArgumentException("Invalid status change!");
			}
		}

		return taskRepository.save(task);
	}
	
	public int getActiveTasks() {
	    return (int) taskRepository.countByStatusNot(TaskStatus.COMPLETED);
	}

	public Map<String, Double> getTaskProgressions() {
	    long total = taskRepository.count();
	    Map<String, Double> progressions = new HashMap<>();
	    progressions.put("CREATED", (double) taskRepository.countByStatus(TaskStatus.CREATED) / total * 100);
	    progressions.put("IN_PROGRESS", (double) taskRepository.countByStatus(TaskStatus.IN_PROGRESS) / total * 100);
	    progressions.put("COMPLETED", (double) taskRepository.countByStatus(TaskStatus.COMPLETED) / total * 100);
	    progressions.put("OVERDUE", (double) taskRepository.countByStatus(TaskStatus.OVERDUE) / total * 100);
	    return progressions;
	}
}