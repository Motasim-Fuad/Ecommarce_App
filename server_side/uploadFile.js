const multer = require("multer");
const path = require('path');

const storageCategory = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null, './public/category')
    },
    filename: (req,file,cb)=>{
        cb(null, Date.now() + file.originalname);
    },
});
const uploadCategory = multer({storage: storageCategory});

const storageProduct = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null, './public/products')
    },
    filename: (req,file,cb)=>{
        const filetypes = /jpeg|jpg|png/;
        const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
        if(extname){
            cb(null, Date.now() + file.originalname);
        }
    },
    
});
const uploadProduct = multer({storage: storageProduct,limits: {fileSize: 1024 * 1024 * 5 }});

const storagePosters = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null, './public/posters')
    },
    filename: (req,file,cb)=>{
        const filetypes = /jpeg|jpg|png/;
        const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
        if(extname){
            cb(null, Date.now() + file.originalname);
        }
    },
    
});
const uploadPosters = multer({storage: storagePosters,limits: {fileSize: 1024 * 1024 * 5 }});

module.exports = {
    uploadCategory,
    uploadProduct,
    uploadPosters,
};