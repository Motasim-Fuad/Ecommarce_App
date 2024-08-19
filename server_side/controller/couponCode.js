const asyncHandler = require('express-async-handler');
const Coupon = require('../model/couponCode'); 
const Product = require('../model/product');

// Get all coupons
exports.getAllCupons = asyncHandler(async (req, res) => {
    try {
        const coupons = await Coupon.find().populate('applicableCategory', 'id name')
            .populate('applicableSubCategory', 'id name')
            .populate('applicableProduct', 'id name');
        res.json({ success: true, message: "Coupons retrieved successfully.", data: coupons });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Get a coupon by ID
exports.getACuponById = asyncHandler(async (req, res) => {
    try {
        const couponID = req.params.id;
        const coupon = await Coupon.findById(couponID)
            .populate('applicableCategory', 'id name')
            .populate('applicableSubCategory', 'id name')
            .populate('applicableProduct', 'id name');
        if (!coupon) {
            return res.status(404).json({ success: false, message: "Coupon not found." });
        }
        res.json({ success: true, message: "Coupon retrieved successfully.", data: coupon });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Create a new coupon
exports.createCupon = asyncHandler(async (req, res) => {
    const { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct } = req.body;
    if (!couponCode || !discountType || !discountAmount || !endDate || !status) {
        return res.status(400).json({ success: false, message: "Code, discountType, discountAmount, endDate, and status are required." });
    }

    try {
        const coupon = new Coupon({
            couponCode,
            discountType,
            discountAmount,
            minimumPurchaseAmount,
            endDate,
            status,
            applicableCategory,
            applicableSubCategory,
            applicableProduct
        });

        const newCoupon = await coupon.save();
        res.json({ success: true, message: "Coupon created successfully.", data: null });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Update a coupon
exports.updateCupon = asyncHandler(async (req, res) => {
    try {
        const couponID = req.params.id;
        const { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct } = req.body;
        console.log(req.body)
        if (!couponCode || !discountType || !discountAmount || !endDate || !status) {
            return res.status(400).json({ success: false, message: "CouponCode, discountType, discountAmount, endDate, and status are required." });
        }

        const updatedCoupon = await Coupon.findByIdAndUpdate(
            couponID,
            { couponCode, discountType, discountAmount, minimumPurchaseAmount, endDate, status, applicableCategory, applicableSubCategory, applicableProduct },
            { new: true }
        );

        if (!updatedCoupon) {
            return res.status(404).json({ success: false, message: "Coupon not found." });
        }

        res.json({ success: true, message: "Coupon updated successfully.", data: null });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Delete a coupon
exports.deleteCupon = asyncHandler(async (req, res) => {
    try {
        const couponID = req.params.id;
        const deletedCoupon = await Coupon.findByIdAndDelete(couponID);
        if (!deletedCoupon) {
            return res.status(404).json({ success: false, message: "Coupon not found." });
        }
        res.json({ success: true, message: "Coupon deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});