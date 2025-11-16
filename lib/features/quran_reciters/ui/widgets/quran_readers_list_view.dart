import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/widgets/top_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/reciter_model.dart';
import 'reciter_widget.dart';
import 'reciters_search_bar.dart';

class ReadersListView extends StatelessWidget {
  const ReadersListView({super.key, required this.reciters});
  final List<ReciterModel> reciters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.imagesWhiteBackground),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280.h,
              child: Stack(
                children: [
                  TopBar(height: 260.h, label: 'القـــراء'),
                  Positioned.fill(
                    top: context.isTablet ? 205.h : 185.h,
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: RecitersSearchBar(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (context.isTablet)
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList.separated(
            itemCount: reciters.length,
            itemBuilder: (context, index) {
              return ReciterWidget(reciter: reciters[index]);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 30),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
