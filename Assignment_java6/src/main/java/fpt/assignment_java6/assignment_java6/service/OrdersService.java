package fpt.assignment_java6.assignment_java6.service;

import fpt.assignment_java6.assignment_java6.entity.Orders;
import fpt.assignment_java6.assignment_java6.repository.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrdersService {
    @Autowired
    private OrdersRepository ordersRepository;

    public List<Orders> getAllOrders() {
        return ordersRepository.findAll();
    }

    public Optional<Orders> getOrderById(Long id) {
        return ordersRepository.findById(id);
    }

    public Orders saveOrder(Orders order) {
        return ordersRepository.save(order);
    }

    public void deleteOrder(Long id) {
        ordersRepository.deleteById(id);
    }
}