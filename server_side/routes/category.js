const express = require('express');
const router = express.Router();
const CategoryController = require('../controller/category');
const { uploadCategory } = require('../uploadFile');

// Get all categories
router.get('/',  CategoryController.getAllCategories);

// Get a category by ID
router.get('/:id', CategoryController.getCategoriesById);

// Create a new category with image upload
router.post('/', uploadCategory.single("img"), CategoryController.createCategory);

// Update a category
router.put('/:id', uploadCategory.single("img"), CategoryController.updateCategory);

// Delete a category
router.delete('/:id', CategoryController.deleteCategory);


module.exports = router;
