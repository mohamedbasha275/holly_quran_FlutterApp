import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/widgets/custom_error_widget.dart';
import 'package:holly_quran/core/widgets/custom_loading_widget.dart';
import 'package:holly_quran/features/home/presentation/view_models/similar_books/similar_books_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/custom_book_image.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if(state is SimilarBooksSuccess){
          return  SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              itemCount: state.books.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    GoRouter.of(context).push(AppRouters.kBookDetailsView,extra: state.books[index]);
                  },
                  child: Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                    child:  CustomBookImage(book: state.books[index]),
                  ),
                );
              },
            ),
          );
        }else if(state is SimilarBooksFailure){
          return CustomErrorWidget(errorMessage: state.errorMessage);
        }else{
          return const CustomLoadingWidget();
        }
      },
    );
  }
}

