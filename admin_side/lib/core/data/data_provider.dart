import '../../models/api_response.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import '../../utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getAllProduct();//ai ta 1st a call kora good,
    getAllCategory();
    getAllSubCategory();
    getAllBrands();
    getAllVariantType();
    getAllVariant();
    getAllPosters();
    getAllCoupons();
  }

  //TODO: should complete getAllCategory
  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "categories");
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
          response.body,
          (json) =>
              (json as List).map((item) => Category.fromJson(item)).toList(),
        );
        _allCategories = apiResponse.data ?? [];
        _filteredCategories =
            List.from(_allCategories); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredCategories;
  }

  //TODO: should complete filterCategories
  void filterCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredCategories =List.from(_allCategories);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredCategories = _allCategories.where((categories) {
        return (categories.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
//complete

  //TODO: should complete getAllSubCategory
  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "subCategories");
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
        ApiResponse<List<SubCategory>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => SubCategory.fromJson(item)).toList(),
        );
        _allSubCategories = apiResponse.data ?? [];
        _filteredSubCategories =
            List.from(_allSubCategories); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredSubCategories;
  }
  //complete
  //TODO: should complete filterSubCategories
  void filterSubCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredSubCategories =List.from(_allSubCategories);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subcategory) {
        return (subcategory.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
  //complete
  //TODO: should complete getAllBrands
  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "brands");
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
        ApiResponse<List<Brand>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => Brand.fromJson(item)).toList(),
        );
        _allBrands = apiResponse.data ?? [];
        _filteredBrands =
            List.from(_allBrands); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredBrands;
  }
  //complete
  //TODO: should complete filterBrands
  void filterBrands(String keyword) {
    if (keyword.isEmpty) {
      _filteredBrands =List.from(_allBrands);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand) {
        return (brand.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
  //complete
  //TODO: should complete getAllVariantType
  Future<List<VariantType>> getAllVariantType({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "variantTypes");
      if (response.isOk) {
        ApiResponse<List<VariantType>> apiResponse =
        ApiResponse<List<VariantType>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => VariantType.fromJson(item)).toList(),
        );
        _allVariantTypes = apiResponse.data ?? [];
        _filteredVariantTypes =
            List.from(_allVariantTypes); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredVariantTypes;
  }
  //complete
  //TODO: should complete filterVariantTypes
  void filterVariantTypes(String keyword) {
    if (keyword.isEmpty) {
      _filteredVariantTypes =List.from(_allVariantTypes);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredVariantTypes = _allVariantTypes.where((variantType) {
        return (variantType.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
//complete
  //TODO: should complete getAllVariant
  Future<List<Variant>> getAllVariant({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "variants");
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
        ApiResponse<List<Variant>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => Variant.fromJson(item)).toList(),
        );
        _allVariants = apiResponse.data ?? [];
        _filteredVariants =
            List.from(_allVariants); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredVariants;
  }
  //complete
  //TODO: should complete filterVariants
  void filterVariants(String keyword) {
    if (keyword.isEmpty) {
      _filteredVariants =List.from(_allVariants);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredVariants = _allVariants.where((variant) {
        return (variant.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
//complete
  //TODO: should complete getAllProduct
  Future<void> getAllProduct({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "products");

        ApiResponse<List<Product>> apiResponse =
        ApiResponse<List<Product>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => Product.fromJson(item)).toList(),
        );
        _allProducts = apiResponse.data ?? [];
        _filteredProducts =
            List.from(_allProducts); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);

    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
  }
//complete
  //TODO: should complete filterProducts
  void filterProducts(String keyword){
    if(keyword.isEmpty){
      _filteredProducts =List.from(_allProducts);
    }else{
      final lowerKeyword= keyword.toLowerCase();

      _filteredProducts =_allProducts.where((product){
        final productNameContainsKeyword =(product.name ??"").toLowerCase().contains(lowerKeyword);
        final categoryNameContainsKeyword =product.proSubCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;
        final subCategoryNameContainsKeyword =product.proSubCategoryId?.name?.toLowerCase().contains(lowerKeyword) ?? false;

        // I can add more condition here if the are more fields to match against

        return productNameContainsKeyword || categoryNameContainsKeyword || subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }
  //complete

  //TODO: should complete getAllCoupons
  Future<List<Coupon>> getAllCoupons({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "couponCodes");
      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
        ApiResponse<List<Coupon>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => Coupon.fromJson(item)).toList(),
        );
        _allCoupons = apiResponse.data ?? [];
        _filteredCoupons =
            List.from(_allCoupons); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredCoupons;
  }
  //TODO: should complete filterCoupons
  void filterCoupons(String keyword) {
    if (keyword.isEmpty) {
      _filteredCoupons =List.from(_allCoupons);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredCoupons = _allCoupons.where((coupon) {
        return (coupon.couponCode ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
  //TODO: should complete getAllPosters
  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: "posters");
      if (response.isOk) {
        ApiResponse<List<Poster>> apiResponse =
        ApiResponse<List<Poster>>.fromJson(
          response.body,
              (json) =>
              (json as List).map((item) => Poster.fromJson(item)).toList(),
        );
        _allPosters = apiResponse.data ?? [];
        _filteredPosters =
            List.from(_allPosters); // Initialize filtered List with all data
        notifyListeners();
        if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    }
    return _filteredPosters;
  }

  //TODO: should complete filterPosters
  void filterPosters(String keyword) {
    if (keyword.isEmpty) {
      _filteredPosters =List.from(_allPosters);
    } else {
      final lowerKeyword =keyword.toLowerCase();
      _filteredPosters = _allPosters.where((poster) {
        return (poster.posterName ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
  //TODO: should complete getAllNotifications

  //TODO: should complete filterNotifications

  //TODO: should complete getAllOrders

  //TODO: should complete filterOrders

  //TODO: should complete calculateOrdersWithStatus




  //TODO: should complete filterProductsByQuantity
    void filterProductsByQuantity(String productQntType){
    if(productQntType == "All Product"){
      _filteredProducts =List.from(_allProducts);
    }else if(productQntType == "Out of Stock"){
      _filteredProducts =_allProducts.where((product){
        //? filter product with quantity equal to 0 (out of stock)
        return product.quantity !=null && product.quantity == 0;
      }).toList();
    }else if(productQntType =="Limited Stock"){
      _filteredProducts =_allProducts.where((product){
        //? filter product with quantity equal to 1 (Limited  stock)
        return product.quantity !=null && product.quantity == 1;
      }).toList();
    }else if (productQntType == 'Other Stock'){
      _filteredProducts =_allProducts.where((product){
        //? filter product with quantity not equal to 0 or 1 (other stock)
        return product.quantity !=null && product.quantity != 0 && product.quantity !=1;
      }).toList();
    }else{
      _filteredProducts = List.from(_allProducts);
    }
    notifyListeners();
    }
//complete

  //TODO: should complete calculateProductWithQuantity

  int calculateProductWithQuantity({int? quantity}){
    int totalProduct =0;
    //? targetQuantity is null it return total product
    if(quantity == null){
      totalProduct =_allProducts.length;
    }else{
      for(Product product in _allProducts){
        if(product.quantity != null && product.quantity ==quantity){
          totalProduct +=1; // Increment the count if quantity
        }
      }
    }
    return totalProduct;
  }
  //complete

}
