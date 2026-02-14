import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider provider;
  late MockApiServices mockApi;

  setUp(() {
    mockApi = MockApiServices();
    provider = RestaurantListProvider(mockApi);
  });

  test('Initial state should be none', () {
    expect(provider.resultState, isA<RestaurantListNoneState>());
  });

  test('Should return restaurant list when API success', () async {
    when(() => mockApi.getRestaurantList()).thenAnswer(
      (_) async => RestaurantListResponse(
        error: false,
        message: '',
        count: 0,
        restaurants: [],
      ),
    );

    await provider.fetchRestaurantList();
    expect(provider.resultState, isA<RestaurantListLoadedState>());
  });

  test('Should return error when API failed', () async {
    when(() => mockApi.getRestaurantList()).thenThrow(Exception('Error'));

    await provider.fetchRestaurantList();
    expect(provider.resultState, isA<RestaurantListErrorState>());
  });
}
