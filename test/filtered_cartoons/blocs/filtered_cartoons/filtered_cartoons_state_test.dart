import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/filtered_cartoons/blocs/filtered_cartoons_bloc/filtered_cartoons_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class MockPoliticalCartoon extends Mock implements PoliticalCartoon {}

void main() {
  group('FilteredCartoonsState', () {
    group('FilteredCartoonsLoading', () {
      test('supports value comparisons', () {
        expect(
          FilteredCartoonsLoading(),
          FilteredCartoonsLoading(),
        );
      });
    });
    group('UpdateFilteredCartoons', () {
      var cartoons = [MockPoliticalCartoon()];
      test('supports value comparisons', () {
        expect(
          FilteredCartoonsLoaded(cartoons, Unit.unit1),
          FilteredCartoonsLoaded(cartoons, Unit.unit1),
        );
      });
    });

    group('UpdateFilteredCartoons', () {
      test('supports value comparisons', () {
        expect(
          FilteredCartoonsFailed('Error'),
          FilteredCartoonsFailed('Error'),
        );
      });
    });
  });
}
