const Poster = require('../model/poster');
const asyncHandler = require('express-async-handler');

// Get all posters
exports.getAllPosters = asyncHandler(async (req, res) => {
    try {
        const posters = await Poster.find({});
        res.json({ success: true, message: "Posters retrieved successfully.", data: posters });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Get a poster by ID
exports.getPosterById = asyncHandler(async (req, res) => {
    try {
        const posterID = req.params.id;
        const poster = await Poster.findById(posterID);
        if (!poster) {
            return res.status(404).json({ success: false, message: "Poster not found." });
        }
        res.json({ success: true, message: "Poster retrieved successfully.", data: poster });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

// Create a new poster
exports.createPoster = asyncHandler(async (req, res) => {
    try {
        const { name } = req.body;
        let imageUrl = 'no_url';
        if (req.file) {
            imageUrl = `http://localhost:3000/image/poster/${req.file.filename}`;
        }

        if (!name) {
            return res.status(400).json({ success: false, message: "Name is required." });
        }

        try {
            const newPoster = new Poster({
                name: name,
                imageUrl: imageUrl
            });
            await newPoster.save();
            res.json({ success: true, message: "Poster created successfully.", data: null });
        } catch (error) {
            console.error("Error creating Poster:", error);
            res.status(500).json({ success: false, message: error.message });
        }
    } catch (err) {
        console.log(`Error creating Poster: ${err.message}`);
        return res.status(500).json({ success: false, message: err.message });
    }
});

// Update a poster
exports.updatePoster = asyncHandler(async (req, res) => {
    try {
        const categoryID = req.params.id;
        const { posterName } = req.body;
        let image = req.body.image;

        if (req.file) {
            image = `http://localhost:3000/image/poster/${req.file.filename}`;
        }

        if(!posterName || !image) {
            return res.status(400).json({ success: false, message: "Name and image are required." });
        }

        try {
            const updatedPoster = await Poster.findByIdAndUpdate(categoryID, { posterName: posterName, imageUrl: image }, { new: true });
            if (!updatedPoster) {
                return res.status(404).json({ success: false, message: "Poster not found." });
            }
            res.json({ success: true, message: "Poster updated successfully.", data: null });
        } catch (error) {
            res.status(500).json({ success: false, message: error.message });
        }
    } catch (err) {
        console.log(`Error updating poster: ${err.message}`);
        return res.status(500).json({ success: false, message: err.message });
    }
});

// Delete a poster
exports.deletePoster = asyncHandler(async (req, res) => {
    const posterID = req.params.id;
    try {
        const deletedPoster = await Poster.findByIdAndDelete(posterID);
        if (!deletedPoster) {
            return res.status(404).json({ success: false, message: "Poster not found." });
        }
        res.json({ success: true, message: "Poster deleted successfully." });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});