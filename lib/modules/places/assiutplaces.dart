import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../widgets/components.dart';

class assiutplaces extends StatefulWidget {
  const assiutplaces({Key? key}) : super(key: key);

  @override
  State<assiutplaces> createState() => _assiutplacesState();
}

final urlImages = [
  'https://upload.wikimedia.org/wikipedia/commons/4/4d/AsyutUniversityMainBldg.jpg',
  'https://media-cdn.tripadvisor.com/media/photo-m/1280/16/ae/7e/8d/hotel-faced.jpg',
  'https://www.etltravel.com/wp-content/uploads/2020/07/asyut-egypt-005-1.jpg',
  'https://www.presidency.eg/media/88364/xaujtygdrm88c40ckgjpg.jpg',
  'https://d1b3667xvzs6rz.cloudfront.net/2018/09/5-1-1-the-Holy-Virgin-Mary-Monastery-in-Assiut.jpg',
];

final desImages = [
  'https://media.gemini.media/img/Original/2020/12/31/2020_12_31_19_30_31_883.jpg',
  'https://s3.us-east-2.amazonaws.com/sie-development-production/images/images/000/000/552/original/12045207_10207847122954885_199287671640865188_o.jpg',
  'https://s3.us-east-2.amazonaws.com/sie-development-production/images/images/000/000/546/original/1.jpg',
  'https://s3.us-east-2.amazonaws.com/sie-development-production/images/images/000/001/328/original/panoramio-109885323.jpg',
  'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/39/49/ab/meir-monumental-tombs.jpg',
  'https://s3.us-east-2.amazonaws.com/sie-development-production/images/images/000/001/873/original/2017-05-28.jpg',
];

List<LatLng> coords = [
  ///khan al khalil
  LatLng(30.0477, 31.2623),

  ///The Hanging Church
  LatLng(30.0053, 31.2302),

  ///Mosque of Mohamed Ali
  LatLng(30.0287, 31.2599),

  ///Egyptian Museum
  LatLng(30.0478, 31.2336),

  ///Cairo Tower
  LatLng(30.045916, 31.224291),
];

List Names = [
  "khan al khalil",
  "The Hanging Church",
  "Mosque of Mohamed Ali",
  "Egyptian Museum",
  "Cairo Tower",
];

class _assiutplacesState extends State<assiutplaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  child: Ink.image(
                    image: CachedNetworkImageProvider(urlImages[2]),
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                  onTap: () {
                    openGallery();
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Highlights in Assiut',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Assiut Governorate is one of the governorates of Upper Egypt, located north of Sohag and south of Minya. Its capital, Assiut, mediates the governorates of Upper Egypt. Its name is derived from the Pharaonic word "Siot", meaning the guard. Assiut is located between two mountain hills, so its climate is continental and it is considered the commercial capital of Upper Egypt. It is famous for its ancient neighborhoods and mausoleums, especially in the cities of Assiut, Apotige and Sadfa.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FivePlacesText(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          _deslaunchURL(
                                            coords[index].latitude,
                                            coords[index].longitude,
                                            Names[index],
                                          );
                                        },
                                        color: ButtonAndIconsColor(),
                                        child: Text(
                                          Names[index],
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Icon(
                                        Icons.gps_fixed,
                                        color: ButtonAndIconsColor(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: GalleryText(),
            // ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0),
              child: SizedBox(
                width: 350,
                height: 350,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: desImages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Ink.image(
                        image: CachedNetworkImageProvider(desImages[index]),
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      onTap: () {
                        openassiutGallery(index);
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  _launchURL();
                },
                color: ButtonAndIconsColor(),
                child: const Text(
                  'Visit Assiut',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(30.0444, 31.2357),
        title: 'Cairo',
      );
    } else {
      throw 'No available maps';
    }
  }

  ///destination urls
  Future<void> _deslaunchURL(lat, lng, name) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(lat, lng),
        title: name,
      );
    } else {
      throw 'No available maps';
    }
  }

  void openGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryWidget(
          urlImages: urlImages,
          index: 0,
        ),
      ),
    );
  }

  void openassiutGallery(index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryWidget(
          urlImages: desImages,
          index: index,
        ),
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final int index;
  final List<String> urlImages;
  const GalleryWidget({super.key, 
    required this.urlImages,
    required this.index,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  late int index = widget.index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.urlImages[index]),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.urlImages[index]),
              );
            },
            itemCount: widget.urlImages.length,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            onPageChanged: (index) => setState(() => this.index = index,),
            pageController: PageController(initialPage: index),
          ),
          Positioned(
            bottom: 0.0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${index + 1}/${widget.urlImages.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(index) async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
    if (availableMaps.isNotEmpty) {
      await availableMaps.first.showMarker(
        coords: Coords(31.000, 12.2),
        title: '',
      );
    } else {
      throw 'No available maps';
    }
  }
}
