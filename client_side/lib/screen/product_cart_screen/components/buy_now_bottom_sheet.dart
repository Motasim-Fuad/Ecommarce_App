import '../provider/cart_provider.dart';
import '../../../utility/extensions.dart';
import '../../../widget/compleate_order_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/applay_coupon_btn.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/custom_text_field.dart';

void showCustomBottomSheet(BuildContext context) {
  context.cartProvider.clearCouponDiscount();
  context.cartProvider.retrieveSavedAddress();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: context.cartProvider.buyNowFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toggle Address Fields
                ListTile(
                  title: const Text('Enter Address'),
                  trailing: IconButton(
                    icon: Icon(context.cartProvider.isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    onPressed: () {
                      context.cartProvider.isExpanded = !context.cartProvider.isExpanded;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),

                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return Visibility(
                      visible: cartProvider.isExpanded,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            CustomTextField(
                              height: 65,
                              labelText: 'Phone',
                              onSave: (value) {},
                              inputType: TextInputType.number,
                              controller: context.cartProvider.phoneController,
                              validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'Street',
                              onSave: (val) {},
                              controller: context.cartProvider.streetController,
                              validator: (value) => value!.isEmpty ? 'Please enter a street' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'City',
                              onSave: (value) {},
                              controller: context.cartProvider.cityController,
                              validator: (value) => value!.isEmpty ? 'Please enter a city' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'State',
                              onSave: (value) {},
                              controller: context.cartProvider.stateController,
                              validator: (value) => value!.isEmpty ? 'Please enter a state' : null,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'Postal Code',
                                    onSave: (value) {},
                                    inputType: TextInputType.number,
                                    controller: context.cartProvider.postalCodeController,
                                    validator: (value) => value!.isEmpty ? 'Please enter a code' : null,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'Country',
                                    onSave: (value) {},
                                    controller: context.cartProvider.countryController,
                                    validator: (value) => value!.isEmpty ? 'Please enter a country' : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Payment Options
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CustomDropdown<String>(
                        bgColor: Colors.white,
                        hintText: cartProvider.selectedPaymentOption,
                        items: const ['cod', 'prepaid'],
                        onChanged: (val) {
                          cartProvider.selectedPaymentOption = val ?? 'cod';
                          cartProvider.updateUI();
                        },
                        displayItem: (val) => val);
                  },
                ),
                // Coupon Code Field
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        height: 60,
                        labelText: 'Enter Coupon code',
                        onSave: (value) {},
                        controller: context.cartProvider.couponController,
                      ),
                    ),
                    ApplyCouponButton(onPressed: () {
                      context.cartProvider.checkCoupon();
                    })
                  ],
                ),
                //? Text for Total Amount, Total Offer Applied, and Grand Total
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5, left: 6),
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Amount            : \$${context.cartProvider.getCartSubTotal()}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('Total Offer Applied   : \$${cartProvider.couponCodeDiscount}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('Grand Total            : \$${cartProvider.getGrandTotal()}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
                //? Pay Button
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CompleteOrderButton(
                        labelText: 'Complete Order  \$${cartProvider.getGrandTotal()} ',
                        onPressed: () {
                          if (!cartProvider.isExpanded) {
                            cartProvider.isExpanded = true;
                            cartProvider.updateUI();
                            return;
                          }
                          // Check if the form is valid
                          if (context.cartProvider.buyNowFormKey.currentState!.validate()) {
                            context.cartProvider.buyNowFormKey.currentState!.save();
                            cartProvider.submitOrder(context);
                            return;
                          }
                        });
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
