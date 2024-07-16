package dev.young.timeZY.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.young.timeZY.enums.UserRole;
import dev.young.timeZY.model.User;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmailAndPassword(String email,String password);
    List<User> findAllByRole(UserRole role);
}