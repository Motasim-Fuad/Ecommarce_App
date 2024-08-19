const Product = require('../model/product');
const asyncHandler = require('express-async-handler');

// Get all products
exports.getAllProducts = asyncHandler(async (req, res) => {
    try {
        const products = await Product.find()
            .populate('proCategoryId', 'id name')
            .populate('proSubCategoryId', 'id name')
            .populate('proBrandId', 'id name')
            .populate('proVariantTypeId', 'id type')
            .populate('proVariantId', 'id name');
        res.json({ success: true, message: "Products retrieved successfully.", data: products });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Get a product by ID
exports.getProductById = asyncHandler(async (req, res) => {
    try {
        const productID = req.params.id;
        const product = await Product.findById(productID)
            .populate('proCategoryId', 'id name')
            .populate('proSubCategoryId', 'id name')
            .populate('proBrandId', 'id name')
            .populate('proVariantTypeId', 'id name')
            .populate('proVariantId', 'id name');
        if (!product) {
            return res.status(404).json({ success: false, message: "Product not found." });
        }
        res.json({ success: true, message: "Product retrieved successfully.", data: product });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// create new product
exports.createProduct = asyncHandler(async (req, res) => {
    try {
        // Extract product data from the request body
        const { name, description, quantity, price, offerPrice, proCategoryId, proSubCategoryId, proBrandId, proVariantTypeId, proVariantId } = req.body;

        // Check if any required fields are missing
        if (!name || !quantity || !price || !proCategoryId || !proSubCategoryId) {
            return res.status(400).json({ success: false, message: "Required fields are missing." });
        }

        // Initialize an array to store image URLs
        const imageUrls = [];

        // Iterate over the file fields
        const fields = ['image1', 'image2', 'image3', 'image4', 'image5'];
        fields.forEach((field, index) => {
            if (req.files[field] && req.files[field].length > 0) {
                const file = req.files[field][0];
                const imageUrl = `http://localhost:3000/image/products/${file.filename}`;
                imageUrls.push({ image: index + 1, url: imageUrl });
            }
        });

        // Create a new product object with data
        const newProduct = new Product({ name, description, quantity, price, offerPrice, proCategoryId, proSubCategoryId, proBrandId, proVariantTypeId, proVariantId, images: imageUrls });

        // Save the new product to the database
        await newProduct.save();

        // Send a success response back to the client
        res.json({ success: true, message: "Product created successfully.", data: null });
    } catch (error) {
        // Handle any errors that occur during the process
        console.error("Error creating product:", error);
        res.status(500).json({ success: false, message: error.message });
    }
});

// Update a product
exports.updateProduct = asyncHandler(async (req, res) => {
    const productId = req.params.id;
    try {
        const { name, description, quantity, price, offerPrice, proCategoryId, proSubCategoryId, proBrandId, proVariantTypeId, proVariantId } = req.body;

        // Find the product by ID
        const productToUpdate = await Product.findById(productId);
        if (!productToUpdate) {
            return res.status(404).json({ success: false, message: "Product not found." });
        }
        // Update product properties if provided
        productToUpdate.name = name || productToUpdate.name;
        productToUpdate.description = description || productToUpdate.description;
        productToUpdate.quantity = quantity || productToUpdate.quantity;
        productToUpdate.price = price || productToUpdate.price;
        productToUpdate.offerPrice = offerPrice || productToUpdate.offerPrice;
        productToUpdate.proCategoryId = proCategoryId || productToUpdate.proCategoryId;
        productToUpdate.proSubCategoryId = proSubCategoryId || productToUpdate.proSubCategoryId;
        productToUpdate.proBrandId = proBrandId || productToUpdate.proBrandId;
        productToUpdate.proVariantTypeId = proVariantTypeId || productToUpdate.proVariantTypeId;
        productToUpdate.proVariantId = proVariantId || productToUpdate.proVariantId;

        // Iterate over the file fields to update images
        const fields = ['image1', 'image2', 'image3', 'image4', 'image5'];
        fields.forEach((field, index) => {
            if (req.files[field] && req.files[field].length > 0) {
                const file = req.files[field][0];
                const imageUrl = `http://localhost:3000/image/products/${file.filename}`;
                // Update the specific image URL in the images array
                let imageEntry = productToUpdate.images.find(img => img.image === (index + 1));
                if (imageEntry) {
                    imageEntry.url = imageUrl;
                } else {
                    // If the image entry does not exist, add it
                    productToUpdate.images.push({ image: index + 1, url: imageUrl });
                }
            }
        });

        // Save the updated product
        await productToUpdate.save();
        res.json({ success: true, message: "Product updated successfully." });
    } catch (error) {
        console.error("Error updating product:", error);
        res.status(500).json({ success: false, message: error.message });
    }
});

// Delete a product
exports.deleteProduct = asyncHandler(async (req, res) => {
    const productID = req.params.id;
    try {
        const product = await Product.findByIdAndDelete(productID);
        if (!product) {
            return res.status(404).json({ success: false, message: "Product not found." });
        }
        res.json({ success: true, message: "Product deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});