import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travelapp/core/usecases/usecase.dart';
import 'package:travelapp/features/places/presentation/cubit/places_cubit.dart';
import 'package:travelapp/features/places/presentation/cubit/places_state.dart';
import 'package:travelapp/features/places/domain/entities/place.dart';
import 'package:travelapp/features/places/domain/usecases/filter_places_usecase.dart';
import 'package:dartz/dartz.dart';

class MockFilterPlacesUseCase extends Mock implements FilterPlacesUseCase {}

void main() {
  group('PlacesCubit', () {
    late PlacesCubit cubit;
    late MockFilterPlacesUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockFilterPlacesUseCase();
      cubit = PlacesCubit(filterPlacesUseCase: mockUseCase);
    });

    test('emits [PlacesFiltering, PlacesFiltered] when filterPlaces is called',
        () async {
      final places = [
        Place(
          id: '1',
          name: 'Pyramids',
          category: 'Historical',
          type: 'Monument',
          rating: 4.9,
          imageUrl: 'url',
          description: 'desc',
        ),
      ];
      when(mockUseCase(NoParams() as FilterPlacesParams))
          .thenAnswer((_) async => Right(places));

      expectLater(
        cubit.stream,
        emitsInOrder([
          isA<PlacesFiltering>(),
          isA<PlacesFiltered>().having((s) => s.places, 'places', places),
        ]),
      );

      await cubit.filterPlaces(category: 'Historical');
    });
  });
}
