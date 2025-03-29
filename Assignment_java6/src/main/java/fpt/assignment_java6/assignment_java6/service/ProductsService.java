package fpt.assignment_java6.assignment_java6.service;

import fpt.assignment_java6.assignment_java6.entity.Products;
import fpt.assignment_java6.assignment_java6.repository.ProductsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductsService {
    @Autowired
    private ProductsRepository productsRepository;

    public List<Products> getAllProducts() {
        return productsRepository.findAll();
    }

    public Optional<Products> getProductById(Long id) {
        return productsRepository.findById(id);
    }

    public Products saveProduct(Products product) {
        return productsRepository.save(product);
    }

    public void deleteProduct(Long id) {
        productsRepository.deleteById(id);
    }
}