const express = require('express');
const router = express.Router();
const OrderController = require('../controller/order');

// Get all orders
router.get('/', OrderController.getAllOrders);


router.get('/orderByUserId/:userId', OrderController.orderByUserId);


// Get an order by ID
router.get('/:id', OrderController.getOrderId);

// Create a new order
router.post('/', OrderController.createOrder);

// Update an order
router.put('/:id', OrderController.updateOrder);

// Delete an order
router.delete('/:id', OrderController.deleteOrder);

module.exports = router;
