const express = require('express');
const router = express.Router();
const VarientTypeController = require('../controller/varientType');

// Get all variant types
router.get('/', VarientTypeController.getAllVarientType);

// Get a variant type by ID
router.get('/:id', VarientTypeController.getVarientTypeByID);

// Create a new variant type
router.post('/', VarientTypeController.createVarientType);

// Update a variant type
router.put('/:id', VarientTypeController.updateVarientType);

// Delete a variant type
router.delete('/:id', VarientTypeController.deleteVarientType);



module.exports = router;
