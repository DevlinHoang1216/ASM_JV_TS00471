package fpt.assignment_java6.assignment_java6.controller;

import fpt.assignment_java6.assignment_java6.entity.Orders;
import fpt.assignment_java6.assignment_java6.entity.OrderDetails;
import fpt.assignment_java6.assignment_java6.service.OrdersService;
import fpt.assignment_java6.assignment_java6.service.OrderDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrdersService ordersService;

    @Autowired
    private OrderDetailsService orderDetailsService;

    @GetMapping("/view")
    public String showOrders(
            @RequestParam(defaultValue = "0") int page,
            Model model) {
        try {
            Pageable pageable = PageRequest.of(page, 10);
            Page<Orders> ordersPage = ordersService.findByFilters(null, null, null, pageable);

            for (Orders order : ordersPage.getContent()) {
                System.out.println("Mã đơn hàng: " + order.getOrderId() + ", Trạng thái: " + order.getStatus());
            }

            model.addAttribute("ordersList", ordersPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", ordersPage.getTotalPages());
            return "orders";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách đơn hàng: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/detail/{id}")
    public String showOrderDetail(@PathVariable("id") Long id, Model model) {
        try {
            Orders order = ordersService.getOrderById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Mã đơn hàng không hợp lệ"));
            List<OrderDetails> orderDetailsList = orderDetailsService.getOrderDetailsByOrderId(id);

            model.addAttribute("order", order);
            model.addAttribute("orderDetailsList", orderDetailsList);
            return "order-detail";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", "Đơn hàng không tồn tại.");
            return "error";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải chi tiết đơn hàng: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/update/{id}")
    public String updateOrder(
            @PathVariable("id") Long id,
            @RequestParam("fullName") String fullName,
            @RequestParam("shippingAddress") String shippingAddress,
            @RequestParam("phone") String phone,
            @RequestParam("status") String status,
            @RequestParam("orderDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate orderDate,
            @RequestParam("totalAmount") double totalAmount) {
        try {
            Orders order = ordersService.getOrderById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Mã đơn hàng không hợp lệ"));

            // Chuyển LocalDate thành LocalDateTime
            LocalDateTime orderDateTime = orderDate.atTime(LocalTime.MIDNIGHT);

            // Cập nhật thông tin đơn hàng
            order.setShippingAddress(shippingAddress);
            order.setStatus(status);
            order.setOrderDate(orderDateTime);
            order.setTotalAmount(totalAmount);

            // Cập nhật thông tin khách hàng
            if (order.getCustomer() != null) {
                order.getCustomer().setFullName(fullName);
                order.getCustomer().setPhone(phone);
            }

            // Lưu đơn hàng
            ordersService.saveOrder(order);
            return "redirect:/admin/orders/detail/" + id;
        } catch (IllegalArgumentException e) {
            return "redirect:/admin/orders/view?errorMessage=Đơn hàng không tồn tại.";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/orders/view?errorMessage=Có lỗi xảy ra khi cập nhật đơn hàng: " + e.getMessage();
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteOrder(@PathVariable("id") Long id) {
        try {
            ordersService.deleteOrder(id);
            return "redirect:/admin/orders/view";
        } catch (Exception e) {
            return "redirect:/admin/orders/view?errorMessage=Có lỗi xảy ra khi xóa đơn hàng: " + e.getMessage();
        }
    }
}