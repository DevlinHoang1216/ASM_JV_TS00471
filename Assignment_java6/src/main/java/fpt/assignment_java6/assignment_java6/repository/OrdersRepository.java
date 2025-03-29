package fpt.assignment_java6.assignment_java6.repository;

import fpt.assignment_java6.assignment_java6.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrdersRepository extends JpaRepository<Orders, Long> {
}
