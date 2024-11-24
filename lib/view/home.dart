import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallspace/view/components/category_container.dart';
import 'package:wallspace/view/components/image_container.dart';
import 'package:wallspace/view/components/text.dart';
import 'package:wallspace/view/components/textfield.dart';
import 'package:wallspace/controller/api_operations.dart';
import 'package:wallspace/controller/text_controllers.dart';
import 'package:wallspace/model/photos_model.dart';
import 'package:wallspace/view/search.dart';
import 'package:wallspace/view/wallpaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Instance of Controllers
  final TextControllers _controllers = TextControllers();
  //List for Categories
  final List categories = [
    ['Nature', 'images/Nature.jpg'],
    ['Animals', 'images/Animals.jpg'],
    ['Games', 'images/Games.jpg'],
    ['Art', 'images/Art.jpg'],
    ['Astrology', 'images/Astro.jpg'],
    ['Cars', 'images/Cars.jpg'],
  ];
  //List for Trending Wallpapers
  List<PhotosModel> trending = [];
  //Funtion to Add Data in Trending List
  getTrendingWallpapers() async {
    trending = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const CustomText(
          text: 'Your Screen, Your Style.',
          fontSize: 36,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomTextfield(
            labelText: 'Search',
            controller: _controllers.searchController,
            suffixIcon: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPage(
                    query: _controllers.searchController.text,
                  ),
                ));
              },
              child: const Icon(
                Icons.search_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomText(
                text: 'Categories..',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _controllers.pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchPage(
                                query: categories[index][0],
                              ),
                            ));
                          },
                          child: CategoryContainer(
                            title: categories[index][0],
                            asset: categories[index][1],
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmoothPageIndicator(
                          controller: _controllers.pageController,
                          count: 6,
                          effect: JumpingDotEffect(
                            dotColor: Colors.white,
                            activeDotColor:
                                Theme.of(context).colorScheme.secondary,
                            dotHeight: 3.0,
                            offset: 4.0,
                            jumpScale: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: CustomText(
                  text: 'Trending..',
                  fontSize: 36,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: MasonryGridView.builder(
                  shrinkWrap: true,
                  itemCount: trending.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: trending[index].imgSrc,
                      child: ImageContainer(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                WallpaperScreen(imgUrl: trending[index].imgSrc),
                          ));
                        },
                        child: Image.network(
                          trending[index].imgSrc,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
