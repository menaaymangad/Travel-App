import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../cubit/restaurants_cubit.dart';
import '../cubit/restaurants_state.dart';
import 'restaurant_details_page.dart';

/// Page displaying a list of restaurants
class RestaurantsPage extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/restaurants';

  /// Creates a new [RestaurantsPage] instance
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCuisine;
  double? _minPrice;
  double? _maxPrice;
  double? _minRating;
  bool _hasDelivery = false;
  bool _hasTakeaway = false;
  bool _hasReservations = false;
  bool _sortByPrice = false;
  bool _sortByRating = false;
  bool _sortAscending = true;

  final List<String> _cuisineTypes = [
    'Egyptian',
    'Mediterranean',
    'Middle Eastern',
    'Italian',
    'Asian',
    'Seafood',
    'Fast Food',
    'Vegetarian',
  ];

  @override
  void initState() {
    super.initState();
    context.read<RestaurantsCubit>().getRestaurants();
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
        title: const Text('Best Restaurants'),
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
                hintText: 'Search restaurants...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<RestaurantsCubit>().getRestaurants();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<RestaurantsCubit>().searchRestaurants(value);
                } else {
                  context.read<RestaurantsCubit>().getRestaurants();
                }
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _cuisineTypes.map((cuisine) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cuisine),
                    selected: _selectedCuisine == cuisine,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCuisine = selected ? cuisine : null;
                      });
                      if (selected) {
                        context.read<RestaurantsCubit>().filterRestaurants(
                              cuisineType: cuisine,
                            );
                      } else {
                        context.read<RestaurantsCubit>().getRestaurants();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
              builder: (context, state) {
                if (state is RestaurantsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RestaurantsLoaded) {
                  return state.restaurants.isEmpty
                      ? const Center(child: Text('No restaurants found'))
                      : ListView.builder(
                          itemCount: state.restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = state.restaurants[index];
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
                                    RestaurantDetailsPage.routeName,
                                    arguments: restaurant.id,
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
                                        restaurant.imageUrl,
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
                                            restaurant.name,
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
                                                restaurant.location,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              RatingBarIndicator(
                                                rating: restaurant.rating,
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
                                                restaurant.rating.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            '\$${restaurant.averagePrice.toStringAsFixed(2)} per person',
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
                                          Wrap(
                                            spacing: 8.0,
                                            children: restaurant.cuisineTypes
                                                .map((cuisine) {
                                              return Chip(
                                                label: Text(cuisine),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                              );
                                            }).toList(),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Row(
                                            children: [
                                              if (restaurant.hasDelivery)
                                                _buildFeatureChip(
                                                    context,
                                                    'Delivery',
                                                    Icons.delivery_dining),
                                              if (restaurant.hasTakeaway)
                                                _buildFeatureChip(
                                                    context,
                                                    'Takeaway',
                                                    Icons.takeout_dining),
                                              if (restaurant.hasReservations)
                                                _buildFeatureChip(
                                                    context,
                                                    'Reservations',
                                                    Icons.book_online),
                                            ],
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            restaurant.description,
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
                } else if (state is RestaurantsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No restaurants available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(BuildContext context, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        avatar: Icon(
          icon,
          size: 16.0,
          color: Theme.of(context).primaryColor,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
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
              title: const Text('Filter Restaurants'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price Range (per person)'),
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
                    const Text('Minimum Rating'),
                    Slider(
                      value: _minRating ?? 0,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: _minRating == null ? 'Any' : _minRating.toString(),
                      onChanged: (value) {
                        setState(() {
                          _minRating = value == 0 ? null : value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Features'),
                    CheckboxListTile(
                      title: const Text('Delivery'),
                      value: _hasDelivery,
                      onChanged: (value) {
                        setState(() {
                          _hasDelivery = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Takeaway'),
                      value: _hasTakeaway,
                      onChanged: (value) {
                        setState(() {
                          _hasTakeaway = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Reservations'),
                      value: _hasReservations,
                      onChanged: (value) {
                        setState(() {
                          _hasReservations = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
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
                    context.read<RestaurantsCubit>().filterRestaurants(
                          cuisineType: _selectedCuisine,
                          minPrice: _minPrice,
                          maxPrice: _maxPrice,
                          minRating: _minRating,
                          hasDelivery: _hasDelivery ? true : null,
                          hasTakeaway: _hasTakeaway ? true : null,
                          hasReservations: _hasReservations ? true : null,
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
