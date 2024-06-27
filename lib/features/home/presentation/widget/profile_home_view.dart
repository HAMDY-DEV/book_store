import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:book_store/features/home/presentation/widget/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        ProfileModel? profile = HomeCubit.get(context).profileModel;
        return profile == null
            ? const ProfileShimmer()
            : Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(Icons.menu)),
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,${profile.data!.name!}',
                        style: getTitleStyle(context),
                      ),
                      Text(
                        'What are you reading today?',
                        style:
                            getSmallStyle(context, color: AppColors.greyColor),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile.data!.image!),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              );
      },
    );
  }
}
