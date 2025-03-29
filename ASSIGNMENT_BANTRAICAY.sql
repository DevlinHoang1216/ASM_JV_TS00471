GO
USE MASTER
GO
CREATE DATABASE ASSIGNMENT_BANTRAICAY
GO
USE ASSIGNMENT_BANTRAICAY

-- Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    phone NVARCHAR(15),
    address NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    password_hash NVARCHAR(255) NOT NULL
);

INSERT INTO customers (full_name, email, phone, address, created_at, password_hash) VALUES
(N'Nguyễn Văn A', 'nguyenvana@gmail.com', '0901234567', N'123 Đường Láng, Hà Nội', '2025-01-01 10:00:00', 'hashed_password_1'),
(N'Trần Thị B', 'tranthib@gmail.com', '0912345678', N'45 Lê Lợi, TP.HCM', '2025-01-02 15:30:00', 'hashed_password_2'),
(N'Lê Minh C', 'leminhc@gmail.com', '0923456789', N'78 Hùng Vương, Đà Nẵng', '2025-01-03 09:15:00', 'hashed_password_3'),
(N'Phạm Thị D', 'phamthid@gmail.com', '0934567890', N'12 Nguyễn Trãi, Huế', '2025-01-04 14:20:00', 'hashed_password_4'),
(N'Hoàng Văn E', 'hoangvane@gmail.com', '0945678901', N'56 Trần Phú, Nha Trang', '2025-01-05 11:45:00', 'hashed_password_5'),
(N'Đỗ Thị F', 'dothif@gmail.com', '0956789012', N'89 Phạm Ngũ Lão, Hà Nội', '2025-01-06 16:10:00', 'hashed_password_6'),
(N'Vũ Văn G', 'vuvang@gmail.com', '0967890123', N'34 Nguyễn Huệ, TP.HCM', '2025-01-07 13:25:00', 'hashed_password_7'),
(N'Bùi Thị H', 'buithih@gmail.com', '0978901234', N'67 Lê Đại Hành, Đà Lạt', '2025-01-08 08:50:00', 'hashed_password_8'),
(N'Ngô Văn I', 'ngovani@gmail.com', '0989012345', N'90 Bạch Đằng, Hải Phòng', '2025-01-09 17:00:00', 'hashed_password_9'),
(N'Mai Thị K', 'maithik@gmail.com', '0990123456', N'23 Điện Biên Phủ, Cần Thơ', '2025-01-10 12:30:00', 'hashed_password_10');

-- Bảng categories (Danh mục)
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);

INSERT INTO categories (name, description) VALUES
(N'Trái cây nội địa', N'Các loại trái cây được trồng trong nước'),
(N'Trái cây nhập khẩu', N'Trái cây nhập từ nước ngoài'),
(N'Trái cây hữu cơ', N'Trái cây được trồng theo tiêu chuẩn hữu cơ'),
(N'Trái cây theo mùa', N'Trái cây chỉ có theo mùa trong năm');

-- Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    image_url NVARCHAR(255),
    unit NVARCHAR(20),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (name, description, price, stock, category_id, image_url, unit) VALUES
(N'Dưa hấu', N'Dưa hấu đỏ, ngọt, không hạt', 25000.00, 100, 1, '/images/dua-hau.jpg', 'kg'),
(N'Xoài Cát', N'Xoài ngọt, thơm, từ Tiền Giang', 45000.00, 80, 1, '/images/xoai-cat.jpg', 'kg'),
(N'Chuối Laba', N'Chuối ngọt, dẻo, từ Đà Lạt', 20000.00, 150, 1, '/images/chuoi-laba.jpg', 'kg'),
(N'Táo Mỹ', N'Táo nhập khẩu từ Mỹ, giòn, ngọt', 90000.00, 50, 2, '/images/tao-my.jpg', 'kg'),
(N'Nho mẫu đơn', N'Nho nhập từ Nhật, ngọt thanh', 250000.00, 20, 2, '/images/nho-mau-don.jpg', 'kg'),
(N'Cam sành', N'Cam mọng nước, chua ngọt', 30000.00, 120, 1, '/images/cam-sanh.jpg', 'kg'),
(N'Lê Hàn Quốc', N'Lê giòn, ngọt, nhập từ Hàn', 85000.00, 40, 2, '/images/le-han-quoc.jpg', 'kg'),
(N'Dâu tây Đà Lạt', N'Dâu tây hữu cơ, ngọt tự nhiên', 120000.00, 30, 3, '/images/dau-tay.jpg', 'kg'),
(N'Thanh long', N'Thanh long ruột đỏ, ngọt mát', 35000.00, 90, 1, '/images/thanh-long.jpg', 'kg'),
(N'Mít tố nữ', N'Mít ngọt, thơm, từ miền Tây', 40000.00, 70, 1, '/images/mit-to-nu.jpg', 'kg'),
(N'Chôm chôm', N'Chôm chôm đỏ, ngọt, từ Vĩnh Long', 30000.00, 60, 4, '/images/chom-chom.jpg', 'kg'),
(N'Sầu riêng', N'Sầu riêng thơm, béo, từ Đồng Nai', 80000.00, 25, 1, '/images/sau-rieng.jpg', 'kg');

-- Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10,2) NOT NULL,
    status NVARCHAR(20) CHECK (status IN (N'Chờ xử lý', N'Đang giao', N'Hoàn thành', N'Hủy')) DEFAULT N'Chờ xử lý',
    shipping_address NVARCHAR(MAX),
    payment_method NVARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_date, total_amount, status, shipping_address, payment_method) VALUES
(1, '2025-03-01 10:30:00', 75000.00, N'Hoàn thành', N'123 Đường Láng, Hà Nội', 'COD'),
(2, '2025-03-02 14:15:00', 135000.00, N'Đang giao', N'45 Lê Lợi, TP.HCM', N'Chuyển khoản'),
(3, '2025-03-03 09:45:00', 40000.00, N'Chờ xử lý', N'78 Hùng Vương, Đà Nẵng', 'COD'),
(4, '2025-03-04 16:20:00', 250000.00, N'Hoàn thành', N'12 Nguyễn Trãi, Huế', N'Chuyển khoản'),
(5, '2025-03-05 11:00:00', 90000.00, N'Hủy', N'56 Trần Phú, Nha Trang', 'COD'),
(6, '2025-03-06 13:30:00', 60000.00, N'Đang giao', N'89 Phạm Ngũ Lão, Hà Nội', 'COD'),
(7, '2025-03-07 15:50:00', 170000.00, N'Hoàn thành', N'34 Nguyễn Huệ, TP.HCM', N'Chuyển khoản'),
(8, '2025-03-08 08:10:00', 120000.00, N'Chờ xử lý', N'67 Lê Đại Hành, Đà Lạt', 'COD'),
(9, '2025-03-09 17:25:00', 35000.00, N'Hoàn thành', N'90 Bạch Đằng, Hải Phòng', 'COD'),
(10, '2025-03-10 12:00:00', 85000.00, N'Đang giao', N'23 Điện Biên Phủ, Cần Thơ', N'Chuyển khoản');

-- Bảng order_details (Chi tiết đơn hàng)
CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 3, 25000.00),
(2, 2, 3, 45000.00),
(3, 3, 2, 20000.00),
(4, 5, 1, 250000.00),
(5, 4, 1, 90000.00),
(6, 6, 2, 30000.00),
(7, 7, 2, 85000.00),
(8, 8, 1, 120000.00),
(9, 9, 1, 35000.00),
(10, 10, 2, 40000.00);

-- Bảng cart (Giỏ hàng)
CREATE TABLE cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO cart (customer_id, product_id, quantity, added_at) VALUES
(1, 2, 2, '2025-03-20 10:00:00'),
(2, 4, 1, '2025-03-20 12:30:00'),
(3, 6, 3, '2025-03-21 09:15:00'),
(4, 8, 1, '2025-03-21 14:45:00'),
(5, 10, 2, '2025-03-22 11:20:00'),
(6, 1, 4, '2025-03-22 16:00:00'),
(7, 3, 5, '2025-03-23 08:30:00'),
(8, 5, 1, '2025-03-23 13:10:00'),
(9, 7, 2, '2025-03-24 15:25:00'),
(10, 9, 3, '2025-03-24 17:50:00');

-- Bảng reviews (Đánh giá)
CREATE TABLE reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(MAX),
    review_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO reviews (customer_id, product_id, rating, comment, review_date) VALUES
(1, 1, 5, N'Dưa hấu ngọt, rất tươi!', '2025-03-02 12:00:00'),
(2, 2, 4, N'Xoài ngon nhưng hơi nhỏ', '2025-03-03 15:30:00'),
(3, 3, 5, N'Chuối dẻo, tuyệt vời', '2025-03-04 10:15:00'),
(4, 5, 3, N'Nho hơi đắt', '2025-03-05 17:00:00'),
(5, 4, 4, N'Táo giòn, đáng tiền', '2025-03-06 09:45:00'),
(6, 6, 5, N'Cam mọng nước, thích lắm', '2025-03-07 14:20:00'),
(7, 7, 4, N'Lê ngon nhưng giá cao', '2025-03-08 11:30:00'),
(8, 8, 5, N'Dâu tây siêu ngọt', '2025-03-09 16:00:00'),
(9, 9, 4, N'Thanh long tươi, ok', '2025-03-10 13:25:00'),
(10, 10, 5, N'Mít thơm, tuyệt vời', '2025-03-11 08:50:00');

-- Bảng admins (Quản trị viên)
CREATE TABLE admins (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100),
    email NVARCHAR(100)
);

INSERT INTO admins (username, password_hash, full_name, email) VALUES
('admin1', 'hashed_password_admin1', N'Nguyễn Admin', 'admin1@gmail.com'),
('admin2', 'hashed_password_admin2', N'Trần Quản Lý', 'admin2@gmail.com'),
('admin3', 'hashed_password_admin3', N'Lê Quản Trị', 'admin3@gmail.com');

-- Bảng promotions (Khuyến mãi)
CREATE TABLE promotions (
    promotion_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    discount DECIMAL(3,2) CHECK (discount >= 0 AND discount <= 1),
    start_date DATE,
    end_date DATE
);

INSERT INTO promotions (name, discount, start_date, end_date) VALUES
(N'Khuyến mãi Tết', 0.20, '2025-01-01', '2025-02-01'),
(N'Giảm giá mùa hè', 0.15, '2025-06-01', '2025-06-30'),
(N'Black Friday', 0.30, '2025-11-25', '2025-11-30');