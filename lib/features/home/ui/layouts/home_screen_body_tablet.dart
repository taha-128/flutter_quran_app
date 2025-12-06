import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extensions/screen_details.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/widgets/full_image.dart';
import '../../../../core/widgets/top_bar_widget.dart';
import '../../data/app_sections_enum.dart';
import '../widgets/tablet_sections_item.dart';

class HomeScreenBodyTablet extends StatelessWidget {
  const HomeScreenBodyTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const FullImage(image: AppAssets.imagesWhiteBackground),
        CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: TopBar(
                height: context.isLandscape ? 250.h : 180.h,
                withBackButton: false,
              ),
            ),
            if (context.isLandscape)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: context.screenWidth * .04,
                ),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 160.h,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 24,
                  ),
                  itemCount: AppSection.values.length,
                  itemBuilder: (context, index) {
                    return TabletSectionsItem(
                      section: AppSection.values[index],
                    );
                  },
                ),
              ),
            if (!context.isLandscape)
              SliverPadding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.screenWidth * .1),
                sliver: SliverList.separated(
                  itemCount: AppSection.values.length,
                  itemBuilder: (context, index) {
                    return TabletSectionsItem(
                      section: AppSection.values[index],
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 20.h),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 30))
            // SliverPadding(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: context.screenWidth * .1),
            //   sliver:
            // ),
          ],
        ),
      ],
    );
  }
}
