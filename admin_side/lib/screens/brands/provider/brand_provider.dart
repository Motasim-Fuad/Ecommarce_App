import '../../../models/api_response.dart';
import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';


class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;




  BrandProvider(this._dataProvider);




  //TODO: should complete addBrand
  addBrand()async{
    try{
      Map<String, dynamic> brand={'name':brandNameCtrl.text,"subcategoryId" :selectedSubCategory?.sId};

      final response = await service.addItem(endpointUrl: "brands", itemData:brand );
      if(response.isOk){
        ApiResponse apiResponse=ApiResponse.fromJson(response.body, null);
        if(apiResponse.success ==true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar("${apiResponse.message}");
          _dataProvider.getAllBrands(); //List a data show korar jonno , jokon update korbo

        }else{
          SnackBarHelper.showErrorSnackBar("Failed to add Brand name: ${apiResponse.message}");
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


  //TODO: should complete updateBrand

  updateBrand()async{
    try{
      if(brandForUpdate !=null){
        Map<String, dynamic> brand={'name':brandNameCtrl.text,"subcategoryId" :selectedSubCategory?.sId};
        final response = await service.updateItem(endpointUrl: "brands", itemId: brandForUpdate?.sId ??"", itemData: brand);
        if(response.isOk){
          ApiResponse apiResponse =ApiResponse.fromJson(response.body, null);
          if(apiResponse.success ==true){
            clearFields();
            SnackBarHelper.showSuccessSnackBar("${apiResponse.message}");
            _dataProvider.getAllBrands(); //List a data show korar jonno , jokon update korbo

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

  //TODO: should complete submitBrand

  submitBrands(){
    if(brandForUpdate != null){
      updateBrand();
    }else{
      addBrand();
    }
  }
  //complete

  //TODO: should complete deleteBrand
  deleteBrands(Brand brand)async{
    try{
      Response response= await service.deleteItem(endpointUrl: 'brands', itemId:brand.sId??"");
      if(response.isOk){
        ApiResponse apiResponse =ApiResponse.fromJson(response.body, null);
        if(apiResponse.success ==true){

          SnackBarHelper.showSuccessSnackBar("Brand Deleted SuccessFully");
          _dataProvider.getAllBrands(); //List a data show korar jonno , jokon delete korbo

        }else{
          SnackBarHelper.showErrorSnackBar("Failed to Delete Brand: ${apiResponse.message}");
        }
      }
    }catch(e){
      SnackBarHelper.showErrorSnackBar(e.toString());
      return;
    }

  }
  //complete

  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull((element) => element.sId == brand.subcategoryId?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI(){
    notifyListeners();
  }

}
