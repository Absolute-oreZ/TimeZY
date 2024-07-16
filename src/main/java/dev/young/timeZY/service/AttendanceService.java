package dev.young.timeZY.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import dev.young.timeZY.enums.AttendanceStatus;
import dev.young.timeZY.model.Attendance;
import dev.young.timeZY.model.User;
import dev.young.timeZY.repository.AttendanceRepository;

@Service
public class AttendanceService {
	@Autowired
    private AttendanceRepository attendanceRepository;

    public void saveAttendance(Attendance attendance) {
        attendanceRepository.save(attendance);
    }

    public List<Attendance> getAllAttendanceSortedByDateDescending() {
        Sort sort = Sort.by(Sort.Direction.DESC, "attendanceDate");
        return attendanceRepository.findAllByOrderByAttendanceDate(sort);
    }


    public List<Attendance> getAllAttendance() {
        return attendanceRepository.findAll();
    }

    public Optional<Attendance> getAttendanceById(long userId) {
        return attendanceRepository.findById(userId);
    }

    public void updateAttendance(Long id, Attendance attendance) {
    	attendanceRepository.save(attendance);
    }

    public void deleteUser(Long id) {
    	attendanceRepository.deleteById(id);
    }
    
    public List<Attendance> getAllByCleaner(User cleaner) {
    	return attendanceRepository.findAllByCleaner(cleaner);
    }
    
    public Attendance getAllByAttendanceDateAndCleaner(LocalDate attendanceDate, User cleaner) {
        Date sqlDate = Date.valueOf(attendanceDate);
        return attendanceRepository.findByAttendanceDateAndCleaner(sqlDate, cleaner);
    }
    
    public double getAttendanceRate() {
        long total = attendanceRepository.count();
        long present = attendanceRepository.countByStatus(AttendanceStatus.PRESENT);
        return (double) present / total * 100;
    }

    public List<Attendance> getRecentAttendance(int limit) {
        return attendanceRepository.findTopByOrderByAttendanceDateDesc(PageRequest.of(0, limit));
    }

}
