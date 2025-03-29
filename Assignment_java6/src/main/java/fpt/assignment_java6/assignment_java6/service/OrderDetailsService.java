package fpt.assignment_java6.assignment_java6.service;

import fpt.assignment_java6.assignment_java6.entity.OrderDetails;
import fpt.assignment_java6.assignment_java6.repository.OrderDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderDetailsService {
    @Autowired
    private OrderDetailsRepository orderDetailsRepository;

    public List<OrderDetails> getAllOrderDetails() {
        return orderDetailsRepository.findAll();
    }

    public Optional<OrderDetails> getOrderDetailById(Long id) {
        return orderDetailsRepository.findById(id);
    }

    public OrderDetails saveOrderDetail(OrderDetails orderDetail) {
        return orderDetailsRepository.save(orderDetail);
    }

    public void deleteOrderDetail(Long id) {
        orderDetailsRepository.deleteById(id);
    }

    // Thêm phương thức mới để lấy OrderDetails theo orderId
    public List<OrderDetails> getOrderDetailsByOrderId(Long orderId) {
        return orderDetailsRepository.findByOrderId(orderId);
    }
}