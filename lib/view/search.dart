// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallspace/view/components/image_container.dart';
import 'package:wallspace/view/components/text.dart';
import 'package:wallspace/view/components/textfield.dart';
import 'package:wallspace/controller/api_operations.dart';
import 'package:wallspace/controller/text_controllers.dart';
import 'package:wallspace/model/photos_model.dart';
import 'package:wallspace/view/wallpaper.dart';

class SearchPage extends StatefulWidget {
  String query;
  SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //Instance of Controllers
  final TextControllers _controllers = TextControllers();
  //List for Search Results
  List<PhotosModel> searched = [];
  //Method to get Search Result
  getSearchResults() async {
    searched = await ApiOperations.searchWallpaper(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults();
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
            labelText: 'Search',
            controller: _controllers.searchController,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: MasonryGridView.builder(
                  itemCount: searched.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: searched[index].imgSrc,
                      child: ImageContainer(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WallpaperScreen(
                                  imgUrl: searched[index].imgSrc),
                            ),
                          );
                        },
                        child: Image.network(
                          searched[index].imgSrc,
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
