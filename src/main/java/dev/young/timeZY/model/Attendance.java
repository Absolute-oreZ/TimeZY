package dev.young.timeZY.model;

import java.sql.Date;
import java.sql.Timestamp;

import dev.young.timeZY.enums.AttendanceStatus;
import jakarta.persistence.*;

@Entity
@Table(name = "Attendance")
public class Attendance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attendance_id")
    private Long attendanceId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cleaner_id", nullable = false)
    private User cleaner;

    @Column(name = "login_time")
    private Timestamp loginTime;

    @Column(name = "logout_time")
    private Timestamp logoutTime;

    @Column(name = "attendance_date", nullable = false)
    private Date attendanceDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private AttendanceStatus status;

    @Column(name = "reason")
    private String reason;

    @Column(name = "notes")
    private String notes;

    // Constructors
    public Attendance() {
    }

    public Attendance(User cleaner, Timestamp loginTime, Timestamp logoutTime, Date attendanceDate,
            AttendanceStatus status, String reason, String notes) {
        this.cleaner = cleaner;
        this.loginTime = loginTime;
        this.logoutTime = logoutTime;
        this.attendanceDate = attendanceDate;
        this.status = status;
        this.reason = reason;
        this.notes = notes;
    }

    // Setters Getters
    public Long getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(Long attendanceId) {
        this.attendanceId = attendanceId;
    }

    public User getCleaner() {
        return cleaner;
    }

    public void setCleaner(User cleaner) {
        this.cleaner = cleaner;
    }

    public Timestamp getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }

    public Timestamp getLogoutTime() {
        return logoutTime;
    }

    public void setLogoutTime(Timestamp logoutTime) {
        this.logoutTime = logoutTime;
    }

    public Date getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public AttendanceStatus getStatus() {
        return status;
    }

    public void setStatus(AttendanceStatus status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}

