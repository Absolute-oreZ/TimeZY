package dev.young.timeZY.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.young.timeZY.model.Location;
import dev.young.timeZY.repository.LocationRepository;

@Service
public class LocationService {
    @Autowired
    LocationRepository locationRepository;

    public void saveLocation(Location location) {
        locationRepository.save(location);
    }

    public List<Location> getAllLocation() {
        return locationRepository.findAll();
    }

    public Optional<Location> getLocationById(long userId) {
        return locationRepository.findById(userId);
    }

    public void updateLocation(Long id, Location location) {
    	locationRepository.save(location);
    }

    public void deleteLocation(Long id) {
    	locationRepository.deleteById(id);
    }
}
