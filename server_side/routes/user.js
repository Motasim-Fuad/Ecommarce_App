const express = require('express');
const router = express.Router();
const UserController = require('../controller/user');

// Get all users
router.get('/', UserController.getAllUsers);

// login
router.post('/login', UserController.login);

// Get a user by ID
router.get('/:id', UserController.getUserById);

// Create a new user
router.post('/register', UserController.createUser);

// Update a user
router.put('/:id', UserController.updateUser);

// Delete a user
router.delete('/:id', UserController.deleteUser);

module.exports = router;
