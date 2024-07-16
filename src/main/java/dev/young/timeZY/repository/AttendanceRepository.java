package dev.young.timeZY.repository;

import java.sql.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.young.timeZY.enums.AttendanceStatus;
import dev.young.timeZY.model.Attendance;
import dev.young.timeZY.model.User;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {
	List<Attendance> findAllByOrderByAttendanceDate(Sort sort);

	List<Attendance> findAllByCleaner(User cleaner);

	Attendance findByAttendanceDateAndCleaner(Date attendanceDate, User cleaner);

	long countByStatus(AttendanceStatus status);

	List<Attendance> findTopByOrderByAttendanceDateDesc(Pageable pageable);
}
