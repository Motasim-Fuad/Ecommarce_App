const express = require('express');
const router = express.Router();
const SubCategoryController = require('../controller/subCategory');


// Get all sub-categories
router.get('/', SubCategoryController.getAllSubCategories);

// Get a sub-category by ID
router.get('/:id', SubCategoryController.getSubCategoriesById);

// Create a new sub-category
router.post('/', SubCategoryController.createSubCategory);

// Update a sub-category
router.put('/:id', SubCategoryController.updateSubCategory);

// Delete a sub-category
router.delete('/:id', SubCategoryController.deleteSubCategory);


module.exports = router;
