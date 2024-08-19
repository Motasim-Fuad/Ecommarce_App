const express = require('express');
const router = express.Router();
const VarientController = require('../controller/varient')

// Get all variants
router.get('/', VarientController.getAllVariants);

// Get a variant by ID
router.get('/:id', VarientController.getVariantById);

// Create a new variant
router.post('/', VarientController.createVariant);

// Update a variant
router.put('/:id', VarientController.updateVariant);

// Delete a variant
router.delete('/:id', VarientController.deleteVariant);


module.exports = router;
