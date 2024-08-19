const express = require('express');
const router = express.Router();
const { uploadPosters } = require('../uploadFile');
const PosterController = require('../controller/poster');

// Get all posters
router.get('/', PosterController.getAllPosters);

// Get a poster by ID
router.get('/:id', PosterController.getPosterById);

// Create a new poster
router.post('/', uploadPosters.single("img"), PosterController.createPoster);

// Update a poster
router.put('/:id', uploadPosters.single("img"), PosterController.updatePoster);

// Delete a poster
router.delete('/:id', PosterController.deletePoster);

module.exports = router;
