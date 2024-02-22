import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

final AswanUrlImages = [
  'https://c4.wallpaperflare.com/wallpaper/995/803/726/aswan-egypt-green-trees-wallpaper-thumb.jpg',
  'https://thumbs.dreamstime.com/b/sailboat-aswan-river-nile-boats-sunset-144671428.jpg',
  'https://img.freepik.com/free-photo/aswan-river-scenery-beautiful-nile-view-egypt_400112-524.jpg',
  'https://thumbs.dreamstime.com/b/sailboat-aswan-river-nile-boats-sunset-144671428.jpg',
  'https://thumbs.dreamstime.com/b/white-luxury-yachts-sea-harbor-hurghada-egypt-marina-tourist-boats-red-149929446.jpg',
];

class Destination {
  double lat;
  double lng;
  MarkerId markerId;
  String name;
  int id;
  void openGallery;
  int phonenumber;
  double timeopens;
  double timecloses;
  String description;
  int? distance;
  int? duration;
  String? durationText;
  String? distanceText;
  BoxDecoration? decoration;
  ListView? viewimages;
  Widget? InkWell;
  Function? onTap;
  Destination(
    this.id,
    this.timeopens,
    this.timecloses,
    this.phonenumber,
    this.lat,
    this.lng,
    this.name,
    this.markerId,
    this.description, {
    this.distance,
    this.duration,
    this.decoration,
    this.viewimages,
    this.openGallery,
    this.InkWell,
    this.onTap,
  });
}

var destinations = [
  Destination(
    0,
    8.0,
    6.0,
    201208527105,
    31.208870,
    29.909201,
    "Alexandria Library",
    const MarkerId("Alexandria Library"),
    "Eskendereyya, Egyptian Arabic: [mækˈtæb(e)t eskendeˈɾejjæ]) is a major library and cultural center on the shore of the Mediterranean Sea in the Egyptian city of Alexandria. It is a commemoration of the Library of Alexandria, once one of the largest libraries worldwide, which was lost in antiquity. The idea of reviving the old library dates back to 1974, when a committee set up by Alexandria University selected a plot of land for its new library. Construction work began in 1995 and, after some US220 million had been spent, the complex was officially inaugurated on 16 October 2002. In 2010, the library received a donation of 500,000 books from the Bibliothèque nationale de France (BnF). The gift makes the Bibliotheca Alexandrina the sixth-largest Francophone library in the world.The library has shelf space for eight million books, with the main reading room covering 20,000 square metres (220,000 sq ft). The complex also houses a conference center; specialized libraries for maps, multimedia, the blind and visually impaired, young people, and for children; four museums; four art galleries for temporary exhibitions; 15 permanent exhibitions; a planetarium; and a manuscript restoration laboratory.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Alexandria-Library.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    1,
    9.0,
    13.0,
    201208527105,
    30.045916,
    31.224291,
    "Cairo Tower",
    const MarkerId("Cairo Tower"),
    "Located at Sharia Hadayek Al Zuhreya Gezira, the 187 meters tall Cairo Tower is known to be one of the most visited tourist attractions in Egypt. Showcasing a stunning architectural design, this towering structure offers mesmerizing panoramic views of the entire Cairo city from its top floor.Built between 1954 and 1961, the tower flaunts brilliant latticework that offers an insight into the excellent Arab craftsmanship of the times gone by. At present, Cairo Tower is home to many elegant nightclubs and restaurants.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/cairotower.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    2,
    8.0,
    6.0,
    201208527105,
    29.977966,
    31.134726,
    "Khufu Ship",
    const MarkerId("Khufu Ship"),
    "The Khufu ship is an intact full-size solar barque from ancient Egypt. It was sealed into a pit at the foot of the Great Pyramid of pharaoh Khufu around 2500 BC, during the Fourth Dynasty of the ancient Egyptian Old Kingdom. Like other buried Ancient Egyptian ships, it was apparently part of the extensive grave goods intended for use in the afterlife. The Khufu ship is one of the oldest, largest and best-preserved vessels from antiquity. It is 43.4 metres (142 ft) long and 5.9 metres (19 ft) wide, and has been identified as the world's oldest intact ship, and described as ,a masterpiece of woodcraft that could sail today if put into a lake or a river.The ship was preserved in the Giza Solar boat museum, but was relocated to the Grand Egyptian Museum in August 2021.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/khufuship.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    3,
    9.0,
    6.0,
    201208527105,
    29.977325,
    31.132446,
    " Nercopolis",
    const MarkerId('Nercopolis'),
    "Saqqara Necropolis is a vast ancient burial ground in Egypt. Located on the West Bank of the Nile, this is one of the most famous Egyptian historical sites and a part of UNESCO World Heritage Site. Step Pyramid of Saqqara is one of the best attractions at this place. Saqqara Necropolis has gained huge number of visitors due to the myths and historical facts attached to this place.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Saqqara Necropolis.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    4,
    8.0,
    6.0,
    201208527105,
    29.976480,
    31.131302,
    "Giza Pyramids",
    const MarkerId("Giza Pyramids"),
    "The three pyramids, which house the tombs of ancient pharaohs, are one of the Seven Wonders of the ancient world. Located on the Giza Plateau, the pyramids are the only Wonder to have remained intact over thousands of years. The Great Pyramid, also known as the Pyramid of Khufu, is 138 meters high and is open to tourists via the Robber’s Tunnel. The limestone Sphinx structure is also part of the same complex. The pyramids complex of Giza is the jewel of Egypt tourist attractions and one of the most popular Egypt sightseeing places.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Pyramids.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    5,
    6.0,
    5.30,
    201208527105,
    25.719595,
    32.655807,
    "Karnak Temple",
    const MarkerId("Karnak Temple"),
    "The Karnark Temple in Luxor is one of the most famous places to visit in Egypt. The temple complex is the most astonishing tourist spot and includes the Karnark Open Air Museum. The temple houses three other famous temples within its premises – the Temple of Khons, the Great Temple of Amun and the Festival Temple of Tuthmosis III. Since the complex is a vast open site, it is advisable to spend a minimum of 2-3 hours to explore the entire complex.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/karnaktemple.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    6,
    6.0,
    5.0,
    201208527105,
    25.746424,
    32.605309,
    "valley of the kings",
    const MarkerId("valley of the kings"),
    "Located on the East bank of river Nile, Luxor was the site of the ancient city of Thebes and is one of the most popular Egypt tourist spots. Hailed as the world’s largest open-air museum, Luxor is best known for the Valley of Kings that houses rock-cut tombs of ancient pharaohs. Famous ancient kings such as Tutankhamun and Amenhotep were buried here. Although there are about 63 tombs that have been excavated, only a small number is open to tourists. Tutankhamun’s tomb, called the KV62, has a separate entry charge. One of the most haunting places to see in Egypt for sure! This is amongst the famous places in Egypt.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/valley of the kings.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    7,
    9.0,
    4.0,
    201208527105,
    30.590179,
    30.721081,
    " Citadel of Saladin",
    const MarkerId("Citadel of Saladin"),
    "One of the many places in ancient Egypt to be declared UNESCO World Heritage Sites, the citadel was built by the famous Ayyubid ruler Saladin to protect the Cairo and Fustat (the first Egyptian capital under the Caliphate) against Crusaders. The huge fortification is lined by several watchtowers and houses several stunning mosques and the Well of Joseph inside. The Al-Naseer, Sulayman Pasha and the Al Gawhara Palace museum are three places that are a must for Egypt sightseeing tours in Cairo.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Citadel-Egypt.png"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    8,
    8.0,
    6.0,
    201208527105,
    29.203171,
    25.519545,
    "Siwa Oasis",
    const MarkerId("Siwa Oasis"),
    "",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/siwaoasis.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    9,
    8.0,
    6.0,
    201208527105,
    24.088938,
    32.899830,
    "Aswan",
    const MarkerId("Aswan"),
    "This is one of the most relaxing Egypt holiday destinations in the Southern part. In ancient Egypt, it was called Swenette and housed the stone quarries that supplied material to build the famous pyramids. However, Aswan is now known for its breathtaking views of the desert dunes and the Nile river. The Elephantine Islands are the perfect getaway for a relaxing weekend. The colorful Nubian villages in the center of the island are offbeat Egypt tourist attractions and make for a great evening stroll.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/aswanriver.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    InkWell: Ink.image(
      image: CachedNetworkImageProvider(AswanUrlImages[2]),
      fit: BoxFit.cover,
      height: 300,
    ),
    onTap: () {
      // AswanFunction(AswanUrlImages);
    },
  ),
  Destination(
    10,
    5.0,
    6.0,
    201208527105,
    23.299880,
    32.106380,
    "Rock Temples of Abu Simbel",
    const MarkerId("Rock Temples of Abu Simbel"),
    "Rock Temple of Abu Simbel located along the Western banks of the Lake Nasser, the twin temples of Ramesses II and his queen Nefertari were carved right into the mountains and are one of the most popular Egypt places to visit. The rock impressions of the king and the queen sitting on their thrones and overlooking the vastness of the Egyptian mountains is an iconic image of ancient Egypt. The temple was relocated because of the rising waters of the lake in the 60s and receives hundreds of visitors every day.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Rock Temples of Abu Simbel.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    11,
    9.0,
    5.0,
    201208527105,
    30.0478,
    31.2336,
    "Egyptian Museum",
    const MarkerId("Egyptian Museum"),
    "The ancient cities of Egypt have been excavated to reveal temples, palaces, and tombs that are thousands of years old, and you may wonder where all the fabled treasure went. After all, the Egyptians were famous for burying their dead with all kinds of things – gold, golden artifacts, books, and so on. Worry not, because the Egyptian Museum is that dream come true. The pyramids tell you only half the story, the other half is housed in this biggest Egypt collection in the world, including the famous excavation from the tomb of Tutankhamun, making it one of the most spectacular Egypt places to visit.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Egyptian Museum.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    12,
    8.0,
    6.0,
    201208527105,
    27.3637,
    28.1219,
    "White Desert",
    const MarkerId("White Desert"),
    "It is hard to believe that this surreal Egypt attraction of the Sahara Desert is natural. Enormous formations of chalk ranging from snow white to cream in color abound in the region, which also features the sand dunes of the Great Sand Sea and the cliffs of the Farafra Depression. The white boulders and pinnacles have been shaped by wind erosion for several millennia. The surrounding national park also houses the Rhim and Dorcas gazelle, the last of which roam the arid landscape here. With endless splendor, it is among the most beautiful places to visit in Egypt.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/whitedesert.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    13,
    7.0,
    4.0,
    201208527105,
    30.169900,
    31.410410,
    "Ras Muhammad National Park",
    const MarkerId("Ras Muhammad National Park"),
    "Other than being the most famous national park within Egypt, Ras Muhammad also happens to be one of the most popular diving sites in the world. The park is tucked amidst the colorful coral reefs and mangroves of the Red Sea as well as the inland desert of the Sinai. It has crystal-clear waters that allow divers and snorkeling enthusiasts to easily spot the vibrant corals as well as vertebrate and invertebrate marine species. If one is to take a boat to go a little further into the sea, they might even be able to spot dolphins, including Risso’s Dolphin. Other than teeming with rich marine creatures and corals, the park is also home to thousands of White Storks.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Ras Muhammad National Park.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    14,
    6.0,
    5.0,
    201208527105,
    26.182570,
    31.923490,
    "Abydos",
    const MarkerId("Abydos"),
    "This city is another literal open-air museum and one of the best places to visit in Egypt. The Mother of Pots, also called the Umm el-Qa’ab, is a sophisticated necropolis where the first pharaohs are buried. The area is named so because of excavations that revealed thousands of shards of pots that were littered in honor of the kings. Abydos is also where the temple of Seti I was found, which contains the famous hieroglyphic inscription called the Abydos List.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Abydos.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    15,
    8,
    6,
    123456789,
    25.7280,
    32.6105,
    'Ramessum',
    const MarkerId('Ramessum'),
    "Ramessum is the great funerary temple of Ramses II. Located on the West Bank of Luxor, it is Luxor’s one of the most promising sites. Well-known for the 57-foot seated statue of Ramses II, the temple was dedicated to the god Amon and the deceased king. The walls of the temple are decorated with reliefs and include scenes depicting the Festival of Min, the Battle of Kadesh and the Syrian wars. It is a must-visit place if you want to explore some interesting places.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/ramesseum-luxor-egypt.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    16,
    7.0,
    5.0,
    201208527105,
    30.9531,
    31.8979,
    "Tanis",
    const MarkerId("Tanis"),
    "Tanis is one of the most interesting places to visit in Egypt. The city offers various attractions. One among them is Tanis Egypt Ark of the Covenant. Many tourists from all over the world come to visit this wooden chest which is covered with gold. There are many myths associated with Tanis which you should not believe until you have seen. Come and explore the city on your own and experience it in person. Make sure to visit the place during daylight so that you are able to see and enjoy everything.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Tanis.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    17,
    8.0,
    6.0,
    201208527105,
    29.8685,
    31.2168,
    "Saqqara",
    const MarkerId("Saqqara"),
    "The name Saqqara refers to an Egyptian village, but more importantly, an age-old necropolis with a scattering of both large and smaller satellite pyramids spread across a dusty desert plateau. Buried beneath the sand overlooking the Nile Valley until the 19th-century, Saqqara has since been undergoing a significant restoration process.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/saqara.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    18,
    9.0,
    7.0,
    201208527105,
    30.0287,
    31.2599,
    "Mosque of Mohamed Ali",
    const MarkerId("Mosque of Mohamed Ali"),
    "Better known as “Alabaster Mosque”, the Mosque of Mohamed Ali is an Islamic shrine, lying in the Citadel of Cairo city. Dating back to the 19th century, this mosque is believed to be one of the best places in Egypt not only for spiritual enthusiasts, but also for architecture buffs.Flaunting its twin minarets and animated silhouette, this mosque is considered to be the largest built structure in the 19th century. The Mosque of Mohamed Ali boasts an Ottoman style architectural design with impressively adorned interiors.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Muhammad_Ali_Mosque.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    19,
    8.0,
    5.0,
    201208527105,
    30.047503,
    31.233702,
    "King Tutankhamun Museum",
    const MarkerId("King Tutankhamun Museum"),
    "The world’s most famous mummy is that of the Egyptian ruler King Tutankhamun. His coffin has been kept in a very carefully preserved state in the Grand Egyptian Museum of Cairo, which is famously referred to as King Tutankhamun Museum.Spread over 480,00 square meters of land just a few miles south of the Pyramid of Giza and considered to be one of the top-rated Egypt places to visit. King Tutankhamun Museum is one of the most intricate accounts of the Ancient Egyptian reign of Pharaohs.The archeologists have also restored the throne of the king and kept it at the conservation center of the museum since August 2019.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/King Tutankhamun Museum.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    20,
    6.0,
    5.0,
    201208527105,
    25.7193,
    32.6013,
    "Temple of Medinat Habu",
    const MarkerId("Temple of Medinat Habu"),
    "Also referred to as the “Mortuary Temple of Ramses III”, the Temple of Medinat Habu is one of the most famous religious places to visit in Egypt’s Luxor city. Although King Ramses III was buried in the Valley of Kings, the Medinet Habu was constructed in his honour. The southeast corner of this monumental structure offers the best view of the whole complex. Some of the important attractions of the Medinet Habu include the Chapels of the Votaresses, the Second Pylon, Sacred Lake, the First Pylon, Nilometer, &  Hypostyle Hall.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Temple of Medinat Habu.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    21,
    7.0,
    6.0,
    201208527105,
    30.0477,
    31.2623,
    "Khan-el-Khalili",
    const MarkerId("Khan-el-Khalili"),
    "Laid down in the 14th century and considered to be one of the best places to visit in Egypt for shoppaholics, Khan-el-Khalili has its name among the largest markets of the world. This colourful open market has a very chirpy and vibrant atmosphere, with vendors selling a number of local items and customers bargaining at their best.Spread across a huge area, the stores and shops here offer all kinds of souvenirs, including semi precious stoneworks, miniature pyramids, toy camels, silverware, gold artifacts, stained glass lamps, antiques, copperware, handmade carpets, and incense.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Khan-el-Khalili.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
  Destination(
    22,
    8.0,
    11.0,
    123456789,
    30.0053,
    31.2302,
    "The Hanging Church",
    const MarkerId("The Hanging Church"),
    "Also referred to as the “Church of Saint Virgin Mary”, the iconic Hanging Church of Cairo happens to be a stunning stone facade, flaunting intricate inscriptions with Arabic and Coptic marks. Established back in the 3rd century AD, the Hanging Church is one of the oldest churches in the world.The church is named as the “Hanging Church” as it is constructed at the top of the gatehouse of the Babylon Fortress and seems to be hanging mid-air.",
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/The Hanging Church.jpg"),
        fit: BoxFit.cover,
      ),
    ),
  ),
];

///create list of markers for the tourism places  in the map  to be used in the map
List<Marker> createMarkers(List<Destination> destinations) {
  List<Marker> markers = <Marker>[];
  for (Destination destination in destinations) {
    markers.add(Marker(
      markerId: destination.markerId,
      position: LatLng(destination.lat, destination.lng),
    ));
  }
  return markers;
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
                initialScale: PhotoViewComputedScale.contained * 0.8,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.urlImages[index]),
              );
            },
            itemCount: widget.urlImages.length,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            onPageChanged: (index) => setState(() => this.index = index,),
            pageController: PageController(initialPage: 2),
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
