package dev.young.timeZY.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.young.timeZY.model.Location;

@Repository
public interface LocationRepository extends JpaRepository<Location, Long>{
}
