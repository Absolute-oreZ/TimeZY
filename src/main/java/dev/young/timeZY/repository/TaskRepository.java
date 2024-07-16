package dev.young.timeZY.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.young.timeZY.enums.TaskStatus;
import dev.young.timeZY.model.Task;
import dev.young.timeZY.model.User;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
	List<Task> findAllByManager(User manager);

	List<Task> findAllByCleaner(User cleaner);

	long countByStatusNot(TaskStatus status);

	long countByStatus(TaskStatus status);
}
