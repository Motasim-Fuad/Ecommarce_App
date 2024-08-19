const express = require('express');
const router = express.Router();
const { uploadProduct } = require('../uploadFile');
const ProductCintroller = require('../controller/product');

// Get all products
router.get('/', ProductCintroller.getAllProducts);

// Get a product by ID
router.get('/:id', ProductCintroller.getProductById);

// create new product
router.post('/',  uploadProduct.fields([
        { name: 'image1', maxCount: 1 },
        { name: 'image2', maxCount: 1 },
        { name: 'image3', maxCount: 1 },
        { name: 'image4', maxCount: 1 },
        { name: 'image5', maxCount: 1 }
    ]),
    ProductCintroller.createProduct
);

// Update a product
router.put('/:id', uploadProduct.fields([
        { name: 'image1', maxCount: 1 },
        { name: 'image2', maxCount: 1 },
        { name: 'image3', maxCount: 1 },
        { name: 'image4', maxCount: 1 },
        { name: 'image5', maxCount: 1 }
    ]),
    ProductCintroller.updateProduct
);

// Delete a product
router.delete('/:id', ProductCintroller.deleteProduct);

module.exports = router;
