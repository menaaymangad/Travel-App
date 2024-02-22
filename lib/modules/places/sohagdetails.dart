import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../widgets/components.dart';

class sohagplaces extends StatefulWidget {
  const sohagplaces({Key? key}) : super(key: key);

  @override
  State<sohagplaces> createState() => _sohagplacesState();
}

final urlImages = [
  'https://www.lonelyplanet.com/news/wp-content/uploads/2019/02/Cairo-market.jpg',
  'https://cdn.theculturetrip.com/wp-content/uploads/2021/07/cairo.jpg',
  'https://www.connollycove.com/wp-content/uploads/2017/09/Downtown-Cairo.jpg',
  'https://cdn.theculturetrip.com/wp-content/uploads/2021/07/cairo.jpg',
  'https://www.tripsavvy.com/thmb/FvV-Qt3kSihHDxS1xndT5xYyrNc=/2248x1333/filters:fill(auto,1)/GettyImages-1285105352-033b77555aea41bc8afaf164ad4f1ee6.jpg',
];

final fivePlaces = [
  'https://res.cloudinary.com/https-www-isango-com/image/upload/f_auto/t_m_Prod/v7682/africa/egypt/aswan/18067.jpg',
  'https://planegypttours.com/files/xlarge/1247147424-Felucca-Ride-Aswan.jpg',
  'https://cdn.britannica.com/27/178127-050-3C447D4F/statues-entrance-Ramses-II-Great-Temple-Aswan.jpg',
  'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/df/cd/03.jpg',
  'https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
];

final desImages = [
  'https://www.timeoutriyadh.com/cloud/timeoutriyadh/2021/07/11/Cairo_1.jpg',
  'https://i.natgeofe.com/n/e9f60a7b-b7a4-4788-96ce-f95f59b5e527/khan-el-khalili-cairo-egypt_3x4.jpg',
  'https://c1.wallpaperflare.com/preview/33/253/311/egypt-cairo-museum-archaeology-boat-funeral.jpg',
  'https://egyptunited.files.wordpress.com/2018/07/2018-07-22-egyptian-museum-cairo-01.jpg',
  'https://cdn.getyourguide.com/img/tour/eb9c6c64aba56090.jpeg/145.jpg',
  'https://cdn.al-ain.com/images/2018/1/03/80-185600-egypt-preparations_700x400.jpeg',
  'https://mediaaws.almasryalyoum.com/news/large/2017/02/27/608166_0.jpeg',
  'https://c0.wallpaperflare.com/preview/146/218/443/egypt-%D9%85%D8%AC%D9%85%D8%B9-%D8%A7%D9%84%D8%A7%D8%AF%D9%8A%D8%A7%D9%86-building-architecture.jpg',
  'https://cnn-arabic-images.cnn.io/cloudinary/image/upload/w_1920,c_scale,q_auto/cnnarabic/2020/05/24/images/155459.jpg',
  'https://www.askideas.com/media/42/Beautiful-Day-Time-Picture-O-fThe-Cairo-Tower.jpg',
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

class _sohagplacesState extends State<sohagplaces> {
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
                    'Highlights in Sohag',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      ' Cairo, Egypt’s sprawling capital, is set on the Nile River. At its heart is Tahrir Square and the vast Egyptian Museum, a trove of antiquities including royal mummies and gilded King Tutankhamun artifacts. Nearby, Giza is the site of the iconic pyramids and Great Sphinx, dating to the 26th century BC. In Gezira Island’s leafy Zamalek district, 187m Cairo Tower affords panoramic city views.',
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
                        opensohagGallery(index);
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
                  'Visit Sohag',
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

  void opensohagGallery(index) {
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
