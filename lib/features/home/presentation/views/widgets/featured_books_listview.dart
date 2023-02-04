import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/features/common_widgets/custom_error_widget.dart';
import 'package:holly_quran/features/common_widgets/custom_loading_widget.dart';
import 'package:holly_quran/features/home/presentation/view_models/featured_books/featured_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/custom_book_image.dart';

class FeaturedBooksListView extends StatelessWidget {
  const FeaturedBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height * 0.3;
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: itemHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              // remove shadow when swap from side
              itemCount: state.books.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: (){
                      GoRouter.of(context).push(Routes.bookDetailsRoute,extra: state.books[index]);
                    },
                    child: CustomBookImage(book: state.books[index]),
                  ),
                );
              },
            ),
          );
        } else if (state is FeaturedBooksFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
