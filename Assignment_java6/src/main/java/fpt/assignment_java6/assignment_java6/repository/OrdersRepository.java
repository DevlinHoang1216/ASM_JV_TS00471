package fpt.assignment_java6.assignment_java6.repository;

import fpt.assignment_java6.assignment_java6.entity.Orders;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.Optional;

public interface OrdersRepository extends JpaRepository<Orders, Long> {
    @EntityGraph(attributePaths = {"orderDetails", "orderDetails.product", "customer"})
    @Query("SELECT o FROM Orders o WHERE " +
            "(:orderId IS NULL OR CAST(o.orderId AS string) LIKE %:orderId%) " +
            "AND (:orderDate IS NULL OR o.orderDate = :orderDate) " +
            "AND (:status IS NULL OR o.status = :status)")
    Page<Orders> findByFilters(@Param("orderId") String orderId,
                               @Param("orderDate") LocalDateTime orderDate,
                               @Param("status") String status,
                               Pageable pageable);

    @EntityGraph(attributePaths = {"orderDetails", "orderDetails.product", "customer"})
    Optional<Orders> findById(Long id);
}