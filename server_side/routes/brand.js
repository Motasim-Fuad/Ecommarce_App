const router = require('express').Router();
const BrandController = require("../controller/brand");

// Get all brands
router.get('/', BrandController.getAllBrands);

// Get a brand by ID
router.get('/:id', BrandController.getBrandbyId);

// Create a new brand
router.post('/', BrandController.createNewBrand);

// Update a brand
router.put('/:id', BrandController.updateBrand);

// Delete a brand
router.delete('/:id', BrandController.deleteABrand);


module.exports = router;
