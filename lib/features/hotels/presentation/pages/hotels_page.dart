import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../cubit/hotels_cubit.dart';
import '../cubit/hotels_state.dart';
import 'hotel_details_page.dart';

/// Page displaying a list of hotels
class HotelsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/hotels';

  /// Creates a new [HotelsPage] instance
  const HotelsPage({Key? key}) : super(key: key);

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  final TextEditingController _searchController = TextEditingController();
  double? _minPrice;
  double? _maxPrice;
  int? _starRating;
  bool _sortByPrice = false;
  bool _sortByRating = false;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<HotelsCubit>().getHotels();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Hotels'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search hotels...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<HotelsCubit>().getHotels();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<HotelsCubit>().searchHotels(value);
                } else {
                  context.read<HotelsCubit>().getHotels();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<HotelsCubit, HotelsState>(
              builder: (context, state) {
                if (state is HotelsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HotelsLoaded) {
                  return state.hotels.isEmpty
                      ? const Center(child: Text('No hotels found'))
                      : ListView.builder(
                          itemCount: state.hotels.length,
                          itemBuilder: (context, index) {
                            final hotel = state.hotels[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    HotelDetailsPage.routeName,
                                    arguments: hotel.id,
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                      child: Image.network(
                                        hotel.imageUrl,
                                        height: 180.0,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 180.0,
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotel.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 16.0,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                hotel.location,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              ...List.generate(
                                                hotel.stars,
                                                (index) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 18.0,
                                                ),
                                              ),
                                              ...List.generate(
                                                5 - hotel.stars,
                                                (index) => const Icon(
                                                  Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: hotel.rating,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              const SizedBox(width: 8.0),
                                              Text(
                                                hotel.rating.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            '\$${hotel.pricePerNight.toStringAsFixed(2)} per night',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            hotel.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                } else if (state is HotelsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No hotels available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Filter Hotels'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price Range (per night)'),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Min Price',
                              prefixText: '\$',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _minPrice = double.tryParse(value);
                                });
                              } else {
                                setState(() {
                                  _minPrice = null;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Max Price',
                              prefixText: '\$',
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _maxPrice = double.tryParse(value);
                                });
                              } else {
                                setState(() {
                                  _maxPrice = null;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Star Rating'),
                    Wrap(
                      spacing: 8.0,
                      children: List.generate(
                        5,
                        (index) => FilterChip(
                          label: Text('${index + 1}'),
                          selected: _starRating == index + 1,
                          onSelected: (selected) {
                            setState(() {
                              _starRating = selected ? index + 1 : null;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Sort By'),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text('Price'),
                            value: _sortByPrice,
                            onChanged: (value) {
                              setState(() {
                                _sortByPrice = value ?? false;
                                if (_sortByPrice) {
                                  _sortByRating = false;
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text('Rating'),
                            value: _sortByRating,
                            onChanged: (value) {
                              setState(() {
                                _sortByRating = value ?? false;
                                if (_sortByRating) {
                                  _sortByPrice = false;
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    if (_sortByPrice || _sortByRating)
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Ascending'),
                              value: true,
                              groupValue: _sortAscending,
                              onChanged: (value) {
                                setState(() {
                                  _sortAscending = value ?? true;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Descending'),
                              value: false,
                              groupValue: _sortAscending,
                              onChanged: (value) {
                                setState(() {
                                  _sortAscending = value ?? false;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<HotelsCubit>().filterHotels(
                          stars: _starRating,
                          minPrice: _minPrice,
                          maxPrice: _maxPrice,
                          sortByPrice: _sortByPrice,
                          sortByRating: _sortByRating,
                          sortAscending: _sortAscending,
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
