import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class menyaplaces extends StatefulWidget {
  const menyaplaces({Key? key}) : super(key: key);

  @override
  State<menyaplaces> createState() => _menyaplacesState();
}

List<LatLng> coords = [
  ///Tuna el-Gebel
  LatLng(27.773630, 30.738470),

  ///Akhenaton Museum
  LatLng(28.09507, 30.77137),

  ///Tel Al-Amarna
  LatLng(29.286360, 31.210150),

  ///El Bahnasa
  LatLng(28.594130, 30.695860),

  ///Deir Al Adhra
  LatLng(28.312882, 30.719941),
];

List Names = [
  "Tuna el-Gebel",
  "Akhenaton Museum",
  "Tel Al-Amarna",
  "El Bahnasa",
  "Deir Al Adhra",
];

final fivePlaces = [
  'https://www.egypttoday.com/siteimages/Larg/6660.jpg',
  'https://www.egypttoday.com/siteimages/Larg/65508.jpg',
  'https://i.pinimg.com/originals/d2/f4/99/d2f4995694955560b6bbeb413a106bc9.jpg',
  'https://www.etltravel.com/wp-content/uploads/2013/03/el-bahnasa-el-minya.jpg',
  'https://www.cairo24.com/Upload/libfiles/56/3/450.jpg',
];

final urlImages = [
  'https://s3.us-east-2.amazonaws.com/sie-development-production/images/images/000/000/182/original/el_menya_museum.jpg?1591646410',
  'https://thumbs.dreamstime.com/b/sailboat-menya-river-nile-boats-sunset-144671428.jpg',
  'https://img.freepik.com/free-photo/menya-river-scenery-beautiful-nile-view-egypt_400112-524.jpg',
  'https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
  'https://thumbs.dreamstime.com/b/white-luxury-yachts-sea-harbor-hurghada-egypt-marina-tourist-boats-red-149929446.jpg',
];
final menyaurlImages = [
  'https://res.cloudinary.com/https-www-isango-com/image/upload/f_auto/t_m_Prod/v7682/africa/egypt/menya/18067.jpg',
  'https://cdn2.civitatis.com/egipto/egipto/guia/pueblo-nubio.jpg',
  ' https://www.cairotoptours.com/uploads/pages/slider/bda61ad8a38153b65b6560ecba485860.jpg',
  'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/df/cd/03.jpg',
  'https://cdn.britannica.com/27/178127-050-3C447D4F/statues-entrance-Ramses-II-Great-Temple-menya.jpg',
  'https://planegypttours.com/files/xlarge/1247147424-Felucca-Ride-menya.jpg',
  'https://www.outlookindia.com/outlooktraveller/public/uploads/filemanager/images/shutterstock_1238342518.jpg',
  'https://www.traveltoegypt.net/front/images/blog/Elephantine-Island%20.jpg',
  'https://live.staticflickr.com/4265/34954925403_0473215d23_b.jpg',
];

class _menyaplacesState extends State<menyaplaces> {
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
                    'Highlights in menya',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      ' Minya is the capital of the Minya Governorate in Upper Egypt. It is located approximately 245 km (152 mi) south of Cairo on the western bank of the Nile River, which flows north through the city. The name of the city is derived from its Ancient Egyptian name Menat Khufu, meaning the nursing city of Khufu, linking it to the Pharaoh Khufu or Cheops, builder of the Great Pyramid at Giza.8 reasons why you should visit Minya:1- Minya governorate is the hometown of many Egyptian cultural icons, such as the great writer Taha Hussein, famous musician Ammar El Sherei and pioneering feminist leader Huda Shaarawi2- The small town Mallawi in Minya governorate was the birthplace of Maria the Copt, who married the Prophet Mohammad (peace and prayers be upon him). It is also the birthplace of Hagar, the wife of Prophet Ibrahim (peace and prayers be upon him).3- The governorate is considered one of Egypt’s agricultural governorates, with around 452,000 acres of agricultural lands, representing around 6.5 percent of Egypt’s total agricultural lands. The most important crops are cotton, wheat, corn, potatoes, and sugar cane.4- Minya is famous for creating molasses (or “black honey” as Egyptians call it) and has Egypt’s largest cornice.5- The governorate has a number of important ancient mosques from several ages, such as the Egyptian Mosque and Al Foley Mosque.6- The most important archaeological sites of the governorate are:Tuna el-Gebel (Greek monuments),Tel Al-Amarna (ancient Egyptian monuments),El-Bahnasa (ancient Egyptian, Greek, Christian and Islamic monuments) 7- El-Bahnasa is one of the most famous archaeological cities in the governorate, containing monuments from different Egyptian eras, such as ancient Egyptian, Roman, Islamic and even modern monuments, with mansions and buildings that are more than 100 years old 8- The Monastery of the Virgin or Dair al-Adhra is 25 kilometers northeast of Minya City and about 2 kilometers from the Eastern Desert Road. It is one of the most important Christian sites, which the Holy Family went through and stayed at during their journey in Egypt.',
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
                            CachedNetworkImageProvider(menyaurlImages[index]),
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      onTap: () {
                        openmenyaGallery(index);
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

  void openmenyaGallery(index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryWidget(
          urlImages: menyaurlImages,
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
