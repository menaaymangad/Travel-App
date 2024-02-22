import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Aswanplaces extends StatefulWidget {
  const Aswanplaces({Key? key}) : super(key: key);

  @override
  State<Aswanplaces> createState() => _AswanplacesState();
}

List<LatLng> coords = [
  ///Elephantine Island
  LatLng(24.0833, 32.8833),
  //https://res.cloudinary.com/https-www-isango-com/image/upload/f_auto/t_m_Prod/v7682/africa/egypt/aswan/18067.jpg
  ///Sail on a Felucca
  LatLng(24.088938, 32.899830),
  //https://planegypttours.com/files/xlarge/1247147424-Felucca-Ride-Aswan.jpg

  ///Abu Simbel
  LatLng(22.3460, 31.6156),
  //https://cdn.britannica.com/27/178127-050-3C447D4F/statues-entrance-Ramses-II-Great-Temple-Aswan.jpg

  ///Philae Temple
  LatLng(24.0127, 32.8775),
  //image https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/df/cd/03.jpg

  ///Nubian Village
  LatLng(24.0614, 32.8719),
  //https://cdn2.civitatis.com/egipto/egipto/guia/pueblo-nubio.jpg
  //image https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg
];

List Names = [
  "Explore Elephantine Island",
  "Sail on a Felucca",
  "Abu Simbel",
  "Philae Temple",
  "Nubian Village",
];

final fivePlaces = [
  'https://res.cloudinary.com/https-www-isango-com/image/upload/f_auto/t_m_Prod/v7682/africa/egypt/aswan/18067.jpg',
  'https://planegypttours.com/files/xlarge/1247147424-Felucca-Ride-Aswan.jpg',
  'https://cdn.britannica.com/27/178127-050-3C447D4F/statues-entrance-Ramses-II-Great-Temple-Aswan.jpg',
  'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/df/cd/03.jpg',
  'https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
];

final urlImages = [
  'https://c4.wallpaperflare.com/wallpaper/995/803/726/aswan-egypt-green-trees-wallpaper-thumb.jpg',
  'https://thumbs.dreamstime.com/b/sailboat-aswan-river-nile-boats-sunset-144671428.jpg',
  'https://img.freepik.com/free-photo/aswan-river-scenery-beautiful-nile-view-egypt_400112-524.jpg',
  'https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
  'https://thumbs.dreamstime.com/b/white-luxury-yachts-sea-harbor-hurghada-egypt-marina-tourist-boats-red-149929446.jpg',
];
final aswanurlImages = [
  'https://res.cloudinary.com/https-www-isango-com/image/upload/f_auto/t_m_Prod/v7682/africa/egypt/aswan/18067.jpg',
  'https://cdn2.civitatis.com/egipto/egipto/guia/pueblo-nubio.jpg',
  ' https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
  'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/df/cd/03.jpg',
  'https://cdn.britannica.com/27/178127-050-3C447D4F/statues-entrance-Ramses-II-Great-Temple-Aswan.jpg',
  'https://planegypttours.com/files/xlarge/1247147424-Felucca-Ride-Aswan.jpg',
  'https://www.outlookindia.com/outlooktraveller/public/uploads/filemanager/images/shutterstock_1238342518.jpg',
  'https://www.traveltoegypt.net/front/images/blog/Elephantine-Island%20.jpg',
  'https://live.staticflickr.com/4265/34954925403_0473215d23_b.jpg',
];

class _AswanplacesState extends State<Aswanplaces> {
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
                    'Highlights in Aswan',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      ' As Swenet, the city had the important role of protecting Egypt from invaders at its southernmost boundary. In Pharaonic Egypt times, during it is believed every dynasty, the city was a military town. Its stone quarries are said to have provided the granite rock known as Syenite for most of the fabulous temples, columns, and obelisks built by the pharaohs, including the Pyramids of Giza. Today, Aswan is characterized by its abundance of palm trees and tropical gardens, standing beside one of the widest parts of the Nile River. As such, it has many islands dotted off its shores. Two of the largest are Kitchener’s Island, known for being covered with exotic plants, and the much larger Elephantine Island.Aswan is Egypt’s southernmost city and lies, like Luxor and Cairo, on the shores of the Nile River, at its first cataract. To its north lies some 750 miles of the Nile until it reaches the Nile Delta and the Mediterranean Sea. What sets this beautiful city apart from Cairo and Luxor, however, is that its buildings occupy only the East Bank and two islands in the river, with its barren West Bank’s dunes, literally, on the waters edge. The West Bank has only a handful, albeit supremely notable, structures including the Monastery of St Simeon, the Aga Khan Mausoleum and the Tombs of the Nobles. Aswan is located roughly where the Western Desert and the Eastern Desert meet, and just north of the great expanse of water created by the Aswan Dam known as Lake Nasser.',
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
                    height: 230,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(fivePlaces[index]),
                                      fit: BoxFit.cover,
                                    )),
                                width: 400,
                                height: 200,
                              ),
                              onTap: () {
                                _deslaunchURL(
                                  coords[index].latitude,
                                  coords[index].longitude,
                                  Names[index],
                                );
                              },
                            ),
                            FittedBox(
                              child: Text(
                                Names[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      },

                      /*
                      * onPressed: () {
                                          _deslaunchURL(
                                            coords[index].latitude,
                                            coords[index].longitude,

                                          );
                                        },

                                        ),
                                        color: ButtonAndIconsColor(),
                      * */
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: GalleryText(),
            // ),
            const SizedBox(
              height: 10,
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
                  itemCount: urlImages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Ink.image(
                        image:
                            CachedNetworkImageProvider(aswanurlImages[index]),
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      onTap: () {
                        openaswanGallery(index);
                      },
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

  void openaswanGallery(index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryWidget(
          urlImages: aswanurlImages,
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
}
