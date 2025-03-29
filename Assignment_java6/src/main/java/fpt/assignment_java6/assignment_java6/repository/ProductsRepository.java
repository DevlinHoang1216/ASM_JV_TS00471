package fpt.assignment_java6.assignment_java6.repository;

import fpt.assignment_java6.assignment_java6.entity.Products;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductsRepository extends JpaRepository<Products, Long> {
}