package dev.young.timeZY.enums;

public enum TaskCategory {
    GENERAL_CLEANING("General Cleaning"),
    SANITIZATION("Sanitization"),
    MAINTENANCE("Maintenance"),
    WASTE_MANAGEMENT("Waste Management"),
    SPECIAL_CLEANING("Special Cleaning"),
    SUPPLY_RESTOCK("Supply Restock");

    private String displayName;

    TaskCategory(String displayName) {
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
