import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/features/quran_reciters/logic/quran_readers_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_assets.dart';
import 'quran_error_widget.dart';
import 'quran_readers_list_view.dart';

class ReadersBlocBuilder extends StatelessWidget {
  const ReadersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranReadersCubit, QuranReadersState>(
      builder: (context, state) {
        if (state is QuranReadersFailure) {
          return QurraaErrorWidget(error: state.errMessage);
        } else if (state is QuranReadersSuccess) {
          return ReadersListView(reciters: state.reciters);
        } else {
          return Center(
            child: Lottie.asset(AppAssets.lottiesCircularIndicator),
          );
        }
      },
    );
  }
}
