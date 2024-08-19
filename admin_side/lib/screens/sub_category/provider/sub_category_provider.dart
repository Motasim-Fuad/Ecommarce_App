import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';


class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;




  SubCategoryProvider(this._dataProvider);


  //TODO: should complete addSubCategory
  addSubCategory()async{
    try{
      Map<String, dynamic> subCategory={'name':subCategoryNameCtrl.text,"categoryId" :selectedCategory?.sId};

      final response = await service.addItem(endpointUrl: "subCategories", itemData:subCategory );
      if(response.isOk){
        ApiResponse apiResponse=ApiResponse.fromJson(response.body, null);
        if(apiResponse.success ==true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar("${apiResponse.message}");
           _dataProvider.getAllSubCategory(); //List a data show korar jonno , jokon update korbo

        }else{
          SnackBarHelper.showErrorSnackBar("Failed to add Category: ${apiResponse.message}");
        }
      }else{
        SnackBarHelper.showErrorSnackBar("Error ${response.body?["message"]?? response.statusText}");

      }
    }catch(e){
      SnackBarHelper.showErrorSnackBar("An error occurred $e");
      return;
    }
  }
//complete
  //TODO: should complete updateSubCategory
  updateSubCategory()async{
    try{
      if(subCategoryForUpdate !=null){
        Map<String, dynamic> subCategory={'name':subCategoryNameCtrl.text,"categoryId" :selectedCategory?.sId};
        final response = await service.updateItem(endpointUrl: "subCategories", itemId: subCategoryForUpdate?.sId ??"", itemData: subCategory);
        if(response.isOk){
          ApiResponse apiResponse =ApiResponse.fromJson(response.body, null);
          if(apiResponse.success ==true){
            clearFields();
            SnackBarHelper.showSuccessSnackBar("${apiResponse.message}");
            _dataProvider.getAllSubCategory(); //List a data show korar jonno , jokon update korbo

          }else{
            SnackBarHelper.showErrorSnackBar("Failed to update sub Category: ${apiResponse.message}");
          }
        }else{
          SnackBarHelper.showErrorSnackBar("Error ${response.body?["message"]?? response.statusText}");
        }
      }
    }catch(e){
      SnackBarHelper.showErrorSnackBar("An error occurred $e");
      return;
    }
  }
  //complete
  //TODO: should complete submitSubCategory
  submitSubCategory(){
    if(subCategoryForUpdate != null){
      updateSubCategory();
    }else{
      addSubCategory();
    }
  }
//complete
  //TODO: should complete deleteSubCategory
  deleteSubCategory(SubCategory subCategory)async{
    try{
      Response response= await service.deleteItem(endpointUrl: 'subCategories', itemId:subCategory.sId??"");
      if(response.isOk){
        ApiResponse apiResponse =ApiResponse.fromJson(response.body, null);
        if(apiResponse.success ==true){

          SnackBarHelper.showSuccessSnackBar("Sub Category Deleted SuccessFully");
          _dataProvider.getAllSubCategory(); //List a data show korar jonno , jokon delete korbo

        }else{
          SnackBarHelper.showErrorSnackBar("Failed to Delete Sub Category: ${apiResponse.message}");
        }
      }
    }catch(e){
      SnackBarHelper.showErrorSnackBar(e.toString());
      return;
    }

  }
//complete

  setDataForUpdateSubCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == subCategory.categoryId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi(){
    notifyListeners();
  }
}
