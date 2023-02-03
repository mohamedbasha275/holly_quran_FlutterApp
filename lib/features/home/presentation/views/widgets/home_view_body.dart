import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/styles.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/best_seller_listview.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/featured_books_listview.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: CustomAppBar(),
              ),
              FeaturedBooksListView(),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Newest Books', style: Styles.textStyle18),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BestSellerListView(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
