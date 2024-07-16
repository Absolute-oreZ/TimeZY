package dev.young.timeZY.enums;

public enum UserRole {
    CLEANER("Cleaner"), 
    MANAGER("Manager"), 
    ADMIN("Admin");

    private String displayName;

    UserRole(String displayName) {
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