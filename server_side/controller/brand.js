const BrandModel = require('../model/brand');
const ProductModel = require('../model/product');
const asyncHandler = require('express-async-handler');

exports.getAllBrands = asyncHandler(async (req, res) => {
    try {
        const brands = await BrandModel.find().populate('subcategoryId').sort({'subcategoryId': 1});
        res.json({ success: true, message: "Brands retrieved successfully.", data: brands });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

exports.getBrandbyId = asyncHandler(async (req, res) => {
    try {
        const brandID = req.params.id;
        const brand = await BrandModel.findById(brandID).populate('subcategoryId');
        if (!brand) {
            return res.status(404).json({ success: false, message: "Brand not found." });
        }
        res.json({ success: true, message: "Brand retrieved successfully.", data: brand });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

exports.createNewBrand = asyncHandler(async (req, res) => {
    const { name, subcategoryId } = req.body;
    if (!name || !subcategoryId) {
        return res.status(400).json({ success: false, message: "Name and subcategory ID are required." });
    }

    try {
        const brand = new BrandModel({ name, subcategoryId });
        await brand.save();
        res.json({ success: true, message: "Brand created successfully.", data: null });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

exports.updateBrand = asyncHandler(async (req, res) => {
    const brandID = req.params.id;
    const { name, subcategoryId } = req.body;
    if (!name || !subcategoryId) {
        return res.status(400).json({ success: false, message: "Name and subcategory ID are required." });
    }

    try {
        const updatedBrand = await BrandModel.findByIdAndUpdate(brandID, { name, subcategoryId }, { new: true });
        if (!updatedBrand) {
            return res.status(404).json({ success: false, message: "Brand not found." });
        }
        res.json({ success: true, message: "Brand updated successfully.", data: null });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

exports.deleteABrand = asyncHandler(async (req, res) => {
    const brandID = req.params.id;
    try {
        // Check if any products reference this brand
        const products = await ProductModel.find({ proBrandId: brandID });
        if (products.length > 0) {
            return res.status(400).json({ success: false, message: "Cannot delete brand. Products are referencing it." });
        }

        // If no products are referencing the brand, proceed with deletion
        const brand = await BrandModel.findByIdAndDelete(brandID);
        if (!brand) {
            return res.status(404).json({ success: false, message: "Brand not found." });
        }
        res.json({ success: true, message: "Brand deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});
