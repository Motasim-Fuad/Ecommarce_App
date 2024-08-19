const asyncHandler = require('express-async-handler');
const express = require('express');
const router = express.Router();
const CuponCodeController = require('../controller/couponCode');

// Get all coupons
router.get('/', CuponCodeController.getAllCupons);

// Get a coupon by ID
router.get('/:id', CuponCodeController.getACuponById);

// Create a new coupon
router.post('/', CuponCodeController.createCupon);

// Update a coupon
router.put('/:id', CuponCodeController.updateCupon);


// Delete a coupon
router.delete('/:id', CuponCodeController.deleteCupon);


router.post('/check-coupon', asyncHandler(async (req, res) => {
    console.log(req.body);
    const { couponCode, productIds, purchaseAmount } = req.body;

    try {
        // Find the coupon with the provided coupon code
        const coupon = await Coupon.findOne({ couponCode });


        // If coupon is not found, return false
        if (!coupon) {
            return res.json({ success: false, message: "Coupon not found." });
        }

        // Check if the coupon is expired
        const currentDate = new Date();
        if (coupon.endDate < currentDate) {
            return res.json({ success: false, message: "Coupon is expired." });
        }

        // Check if the coupon is active
        if (coupon.status !== 'active') {
            return res.json({ success: false, message: "Coupon is inactive." });
        }

       // Check if the purchase amount is greater than the minimum purchase amount specified in the coupon
        if (coupon.minimumPurchaseAmount && purchaseAmount < coupon.minimumPurchaseAmount) {
            return res.json({ success: false, message: "Minimum purchase amount not met." });
        }

        // Check if the coupon is applicable for all orders
        if (!coupon.applicableCategory && !coupon.applicableSubCategory && !coupon.applicableProduct) {
            return res.json({ success: true, message: "Coupon is applicable for all orders." ,data:coupon});
        }

        // Fetch the products from the database using the provided product IDs
        const products = await Product.find({ _id: { $in: productIds } });

        // Check if any product in the list is not applicable for the coupon
        const isValid = products.every(product => {
            if (coupon.applicableCategory && coupon.applicableCategory.toString() !== product.proCategoryId.toString()) {
                return false;
            }
            if (coupon.applicableSubCategory && coupon.applicableSubCategory.toString() !== product.proSubCategoryId.toString()) {
                return false;
            }
            if (coupon.applicableProduct && !product.proVariantId.includes(coupon.applicableProduct.toString())) {
                return false;
            }
            return true;
        });

        if (isValid) {
            return res.json({ success: true, message: "Coupon is applicable for the provided products." ,data:coupon});
        } else {
            return res.json({ success: false, message: "Coupon is not applicable for the provided products." });
        }
    } catch (error) {
        console.error('Error checking coupon code:', error);
        return res.status(500).json({ success: false, message: "Internal server error." });
    }
}));

module.exports = router;
