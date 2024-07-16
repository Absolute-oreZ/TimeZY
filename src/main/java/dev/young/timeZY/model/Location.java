package dev.young.timeZY.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Location")
public class Location {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "location_id")
    private Long locationId;

    @Column(name = "location_name", nullable = false)
    private String locationName;

    @Column(name = "building_name")
    private String buildingName;

    @Column(name = "floor_number")
    private Integer floorNumber;

    // Constructors
    public Location() {}

    public Location(String locationName, String buildingName, Integer floorNumber) {
        this.locationName = locationName;
        this.buildingName = buildingName;
        this.floorNumber = floorNumber;
    }

    // Setters Getters
    public Long getLocationId() {
        return locationId;
    }

    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public Integer getFloorNumber() {
        return floorNumber;
    }

    public void setFloorNumber(Integer floorNumber) {
        this.floorNumber = floorNumber;
    }
}
