package fpt.assignment_java6.assignment_java6.repository;

import fpt.assignment_java6.assignment_java6.entity.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Long> {
    @Query("SELECT od FROM OrderDetails od WHERE od.orderId = :orderId")
    List<OrderDetails> findByOrderId(@Param("orderId") Long orderId);
}