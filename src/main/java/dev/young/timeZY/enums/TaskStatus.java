package dev.young.timeZY.enums;

public enum TaskStatus {
    COMPLETED("Completed"),
    OVERDUE("Overdue"),
    CREATED("Created"),
    IN_PROGRESS("In Progress");

    private String displayName;

    TaskStatus(String displayName) {
        this.displayName = displayName;
    }

    public String displayName() {
        return displayName;
    }

    @Override
    public String toString() {
        return displayName;
    }
}
