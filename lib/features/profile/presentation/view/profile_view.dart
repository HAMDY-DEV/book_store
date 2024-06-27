import 'dart:io';
import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/features/auth/presentation/view/login_view.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/profile/presentation/manager/profile_cubit.dart';
import 'package:book_store/features/profile/presentation/manager/profile_state.dart';
import 'package:book_store/features/profile/presentation/widget/itim_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  XFile? pickedImages;

  Future<void> pickFromGallery() async {
    try {
      pickedImages = await imagePicker.pickImage(source: ImageSource.gallery);

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            ProfileModel? profile = ProfileCubit.get(context).profileModel;

            return profile == null
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -80,
                          left: -150,
                          right: -150,
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(450),
                                bottomRight: Radius.circular(450),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 70,
                            right: 30,
                            child: IconButton(
                                onPressed: () {
                                  ProfileCubit.get(context).logout();
                                  Token.removeToken();
                                  navigatorToAndRemoveUntil(
                                      context, const LoginView());
                                },
                                icon: Icon(
                                  size: 30,
                                  Icons.login,
                                  color: AppColors.whiteColor,
                                ))),
                        Positioned(
                          top: 120,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: AppColors.whiteColor,
                            child: CircleAvatar(
                              radius: 72,
                              backgroundImage:
                                  NetworkImage(profile.data!.image.toString()),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 270,
                          left: 1,
                          right: 1,
                          child: Text(
                            profile.data!.name.toString(),
                            textAlign: TextAlign.center,
                            style: getTitleStyle(context,
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Positioned(
                          top: 315,
                          left: 0,
                          right: 0,
                          child: SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(20),
                                  ItimProfile(
                                    title: 'Email',
                                    icon: Icons.alternate_email,
                                    text: profile.data!.email.toString(),
                                  ),
                                  const Gap(10),
                                  ItimProfile(
                                    title: 'Phone',
                                    icon: Icons.phone,
                                    text: profile.data!.phone.toString(),
                                  ),
                                  ItimProfile(
                                    title: 'city',
                                    icon: Icons.location_city,
                                    text: profile.data!.city.toString(),
                                  ),
                                  ItimProfile(
                                    title: 'address',
                                    icon: Icons.location_on,
                                    text: profile.data!.address.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: CustomButton(
                              text: 'Edit Profile',
                              onTap: () {
                                nameController.text =
                                    profile.data!.name.toString();
                                phoneController.text =
                                    profile.data!.phone.toString();
                                cityController.text =
                                    profile.data!.city.toString();
                                addressController.text =
                                    profile.data!.address.toString();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogcontext) {
                                    return AlertDialog(
                                      title: const Text("Edit Profile"),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                CircleAvatar(
                                                  radius: 58,
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  child: CircleAvatar(
                                                    radius: 55,
                                                    backgroundImage:
                                                        pickedImages ==
                                                                null
                                                            ? NetworkImage(
                                                                profile
                                                                    .data!.image
                                                                    .toString())
                                                            : FileImage(File(
                                                                    pickedImages!
                                                                        .path))
                                                                as ImageProvider,
                                                  ),
                                                ),
                                                Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: CircleAvatar(
                                                      backgroundColor: AppColors
                                                          .primaryColor,
                                                      radius: 15,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            pickFromGallery();
                                                          },
                                                          icon: Icon(
                                                            Icons.camera_alt,
                                                            size: 13,
                                                            color: AppColors
                                                                .whiteColor,
                                                          )),
                                                    ))
                                              ],
                                            ),
                                            const Gap(10),
                                            CustomTextFormField(
                                              hintText: 'Enter your name',
                                              label: 'Name',
                                              keyboardType: TextInputType.text,
                                              controller: nameController,
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
                                              hintText: 'Enter your city',
                                              label: 'City',
                                              keyboardType: TextInputType.text,
                                              controller: cityController,
                                            ),
                                            const Gap(10),
                                            CustomTextFormField(
                                              hintText: 'Enter your address',
                                              label: 'Address',
                                              keyboardType: TextInputType.text,
                                              controller: addressController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.primaryColor),
                                          child: const Text("Update Profile"),
                                          onPressed: () {
                                            ProfileCubit.get(context)
                                                .updateProfile(
                                                    name: nameController.text,
                                                    image: pickedImages!,
                                                    phone: phoneController.text,
                                                    address:
                                                        addressController.text,
                                                    city: cityController.text);
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.primaryColor),
                                          child: const Text("Close"),
                                          onPressed: () {
                                            setState(() {
                                              pickedImages = null;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
