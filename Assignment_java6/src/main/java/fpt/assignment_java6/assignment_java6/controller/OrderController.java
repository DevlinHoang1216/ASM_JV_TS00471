package fpt.assignment_java6.assignment_java6.controller;

import fpt.assignment_java6.assignment_java6.entity.Orders;
import fpt.assignment_java6.assignment_java6.entity.OrderDetails;
import fpt.assignment_java6.assignment_java6.service.OrdersService;
import fpt.assignment_java6.assignment_java6.service.OrderDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrdersService ordersService;

    @Autowired
    private OrderDetailsService orderDetailsService;

    @GetMapping("/view")
    public String showOrders(Model model, @ModelAttribute("orders") Orders orders) {
        List<OrderDetails> orderDetailsList = orderDetailsService.getAllOrderDetails();
        model.addAttribute("orderDetailsList", orderDetailsList);
        List<Orders> ordersList = ordersService.getAllOrders();
        model.addAttribute("ordersList", ordersList);
        return "orders";
    }

    // Hiển thị chi tiết đơn hàng
    @GetMapping("/detail/{id}")
    public String showOrderDetail(@PathVariable("id") Long id, Model model) {
        // Lấy đơn hàng theo ID
        Optional<Orders> orderOpt = ordersService.getOrderById(id);
        if (orderOpt.isPresent()) {
            Orders order = orderOpt.get();
            // Lấy danh sách chi tiết đơn hàng thuộc đơn hàng này
            List<OrderDetails> orderDetailsList = orderDetailsService.getOrderDetailsByOrderId(id);

            model.addAttribute("order", order);
            model.addAttribute("orderDetailsList", orderDetailsList);
            return "order-detail"; // Trả về file order-detail.html
        } else {
            return "redirect:/admin/orders"; // Nếu không tìm thấy, quay lại danh sách
        }
    }
}