import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:test_app/widget/app_bar.dart';
import '../helper/api.dart';
import 'full_screen.dart';
import 'package:http/http.dart' as http;

class WallpaperList extends StatefulWidget {
  const WallpaperList({super.key});

  @override
  WallpaperListState createState() => WallpaperListState();
}

class WallpaperListState extends State<WallpaperList> {
  ApiHelper apiHelper = ApiHelper(); // Buat instance dari ApiHelper

  List<dynamic> wallpapers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCuratedWallpapers();
  }

  Future<void> saveWallpaperToGallery(String imageUrl) async {
    var response = await http.get(Uri.parse(imageUrl));
    final Uint8List imageBytes = Uint8List.fromList(response.bodyBytes);

    final result = await PhotoManager.editor.saveImage(imageBytes, title: '');
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper saved successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save wallpaper')),
      );
    }
  }

  Future<void> fetchCuratedWallpapers() async {
    List<dynamic> curatedWallpapers = await apiHelper.fetchCuratedWallpapers();
    setState(() {
      wallpapers = curatedWallpapers;
    });
  }

  void searchWallpapers(String query) async {
    List<dynamic> searchedWallpapers = await apiHelper.searchWallpapers(query);
    setState(() {
      wallpapers = searchedWallpapers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(word1: "Photo", word2: "Pixer"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Cari disini cuy!...',
                // border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchWallpapers(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: wallpapers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullscreenImageScreen(
                            imageUrl: wallpapers[index]["src"]["large2x"],
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: wallpapers[index]["src"]["medium"],
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
