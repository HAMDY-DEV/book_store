import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/bottom_navigation_bar.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:book_store/features/check_out/data/dfdf.dart';
import 'package:book_store/features/check_out/model/check_order_model.dart';
import 'package:book_store/features/check_out/presentation/manager/check_out_cubit.dart';
import 'package:book_store/features/check_out/presentation/manager/check_out_state.dart';
import 'package:book_store/features/check_out/presentation/widget/check_outItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class CheckOutView extends StatefulWidget {
  CheckOutView({super.key, required this.checkOrderModel});

  CheckOrderModel checkOrderModel;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  String _specialization = specialization[0];

  @override
  void initState() {
    nameController.text = widget.checkOrderModel.data!.user!.userName!;
    emailController.text = widget.checkOrderModel.data!.user!.userEmail!;
    phoneController.text = widget.checkOrderModel.data!.user!.phone!;
    addressController.text = widget.checkOrderModel.data!.user!.address!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckOutCubit(),
      child: BlocConsumer<CheckOutCubit, CheckOutState>(
          listener: (context, state) {
        if (state is CheckOutSuccess) {
          showRiveDialog(context: context, path: 'assets/riv/success.riv');
          Future.delayed(const Duration(milliseconds: 1500), () {
            navigatorToAndRemoveUntil(context, const BottomNavBar());
          });
        } else if (state is CheckOutError) {
        } else {}
      }, builder: (context, state) {
        var checkOutCubit = CheckOutCubit.get(context);
        return Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 5),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    CustomTextFormField(
                      hintText: 'Enter your name',
                      label: 'Name',
                      keyboardType: TextInputType.text,
                      controller: nameController,
                    ),
                    const Gap(10),
                    CustomTextFormField(
                      hintText: 'Enter your email',
                      label: 'Email',
                      keyboardType: TextInputType.text,
                      controller: emailController,
                    ),
                    const Gap(10),
                    CustomTextFormField(
                      hintText: 'Enter your phone',
                      label: 'Phone',
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const Gap(10),
                    CustomTextFormField(
                      hintText: 'Enter your address',
                      label: 'Address',
                      keyboardType: TextInputType.text,
                      controller: addressController,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: AppColors.primaryColor,
                        icon: const Icon(Icons.expand_circle_down_outlined),
                        value: _specialization,
                        onChanged: (String? newValue) {
                          setState(() {
                            _specialization = newValue ?? specialization[1];
                          });
                        },
                        items: specialization.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
                const Gap(10),
                const Divider(),
                const Gap(10),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: widget.checkOrderModel.data!.cartItems!.length,
                    itemBuilder: (context, index) {
                      return CheckOutItem(
                        index: index,
                        checkOrderModel: widget.checkOrderModel,
                      );
                    },
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'Total Price :  ${widget.checkOrderModel.data!.total}',
                  style: getBodyStyle(context, color: AppColors.whiteColor),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    String id = '1';
                    for (int i = 0; i < specialization_id.length; i++) {
                      if (_specialization == specialization_id[i].name) {
                        id = specialization_id[i].id;
                      }
                    }
                    checkOutCubit.checkOut(
                      context,
                      nameController.text,
                      phoneController.text,
                      addressController.text,
                      id,
                      emailController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor),
                  child: const Text('Order Now'),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
