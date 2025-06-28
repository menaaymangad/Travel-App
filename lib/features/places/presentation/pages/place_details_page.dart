import 'package:flutter/material.dart';
import 'package:travelapp/constants/color.dart';

/// Page for displaying details about a specific place
class PlaceDetailsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/place-details';

  /// The place ID to display details for
  final String placeId;

  /// Creates a new [PlaceDetailsPage] instance
  const PlaceDetailsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  late Map<String, dynamic> placeData;

  @override
  void initState() {
    super.initState();
    placeData = getPlaceData(widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          placeData['name'],
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: AssetImage(placeData['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    placeData['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: KprimaryColor),
                      const SizedBox(width: 8),
                      Text(
                        placeData['location'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    placeData['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Attractions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    placeData['attractions'].length,
                    (index) => _buildAttractionItem(
                      placeData['attractions'][index]['name'],
                      placeData['attractions'][index]['description'],
                      placeData['attractions'][index]['image'],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttractionItem(String name, String description, String image) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getPlaceData(String placeId) {
    // This would ideally come from a repository or service
    final placesData = {
      'cairo': {
        'name': 'Cairo',
        'location': 'Capital of Egypt',
        'image': 'assets/images/cairotower.jpg',
        'description':
            "Cairo, Egypt's sprawling capital, is set on the Nile River. At its heart is Tahrir Square and the vast Egyptian Museum, a trove of antiquities including royal mummies and gilded King Tutankhamun artifacts.",
        'attractions': [
          {
            'name': 'Egyptian Museum',
            'description':
                "Home to the world's largest collection of Pharaonic antiquities.",
            'image': 'assets/images/Egyptian Museum.jpg',
          },
          {
            'name': 'Cairo Tower',
            'description':
                'A 187-meter-high tower offering panoramic views of Cairo.',
            'image': 'assets/images/cairotower.jpg',
          },
          {
            'name': 'Khan el-Khalili',
            'description':
                'A major souk (market) in the historic center of Islamic Cairo.',
            'image': 'assets/images/Khan-el-Khalili.jpg',
          },
        ],
      },
      'giza': {
        'name': 'Giza',
        'location': 'Cairo Governorate, Egypt',
        'image': 'assets/images/pyra.jpg',
        'description':
            'Giza is best known as the location of the Giza Plateau: the site of some of the most impressive ancient monuments in the world, including a complex of ancient Egyptian royal mortuary and sacred structures.',
        'attractions': [
          {
            'name': 'Great Pyramids',
            'description':
                'The only remaining wonder of the ancient world, built as tombs for the pharaohs.',
            'image': 'assets/images/Pyramids.jpg',
          },
          {
            'name': 'Great Sphinx',
            'description':
                'A limestone statue of a reclining sphinx with the face of the pharaoh Khafre.',
            'image': 'assets/images/pyra.jpg',
          },
        ],
      },
      'luxor': {
        'name': 'Luxor',
        'location': 'Upper Egypt',
        'image': 'assets/images/luxor.jpg',
        'description':
            "Luxor is a city on the east bank of the Nile River in southern Egypt. It's on the site of ancient Thebes, the pharaohs' capital at the height of their power, during the 16th–11th centuries B.C.",
        'attractions': [
          {
            'name': 'Karnak Temple',
            'description':
                'A vast temple complex dedicated primarily to Amun-Ra, a key religious center in ancient Egypt.',
            'image': 'assets/images/karnaktemple.jpg',
          },
          {
            'name': 'Valley of the Kings',
            'description':
                'A valley where tombs were constructed for the Pharaohs and powerful nobles of the New Kingdom.',
            'image': 'assets/images/valley of the kings.jpg',
          },
        ],
      },
      'aswan': {
        'name': 'Aswan',
        'location': 'Southern Egypt',
        'image': 'assets/images/aswan.jpg',
        'description':
            'Aswan is a city in the south of Egypt, and is the capital of the Aswan Governorate. Aswan is a busy market and tourist center located just north of the Aswan Dam on the east bank of the Nile.',
        'attractions': [
          {
            'name': 'Abu Simbel Temples',
            'description':
                'Two massive rock temples in Nubia, southern Egypt on the western bank of Lake Nasser.',
            'image': 'assets/images/Rock Temples of Abu Simbel.jpg',
          },
          {
            'name': 'Philae Temple',
            'description':
                'An island temple dedicated to the goddess Isis, now relocated to Agilkia Island.',
            'image': 'assets/images/aswan/1.jpg',
          },
        ],
      },
      'assiut': {
        'name': 'Assiut',
        'location': 'Central Egypt',
        'image': 'assets/images/assiut.jpg',
        'description':
            'Assiut is the largest town in Upper Egypt and lies about 234 miles south of Cairo. The city is home to Al-Azhar University campus and the Assiut Barrage.',
        'attractions': [
          {
            'name': 'Assiut Barrage',
            'description': 'A dam across the Nile River at Assiut.',
            'image': 'assets/images/assiut.jpg',
          },
        ],
      },
      'sohag': {
        'name': 'Sohag',
        'location': 'Upper Egypt',
        'image': 'assets/images/sohag.jpg',
        'description':
            'Sohag is a city in Egypt that lies on the west bank of the Nile. It has been the capital of Sohag Governorate since 1960.',
        'attractions': [
          {
            'name': 'White Monastery',
            'description':
                'A Coptic Orthodox monastery named after Saint Shenouda.',
            'image': 'assets/images/sohag.jpg',
          },
        ],
      },
      'qena': {
        'name': 'Qena',
        'location': 'Upper Egypt',
        'image': 'assets/images/qena.jpg',
        'description':
            'Qena is a city in Upper Egypt, and the capital of the Qena Governorate. Situated on the east bank of the Nile, it was known as Kaine during the Greco-Roman period.',
        'attractions': [
          {
            'name': 'Dendera Temple Complex',
            'description':
                'An ancient Egyptian temple complex located about 2.5 km south-east of Dendera.',
            'image': 'assets/images/qena.jpg',
          },
        ],
      },
    };

    return (placesData[placeId] ?? placesData['cairo']) as Map<String, dynamic>;
  }
}
