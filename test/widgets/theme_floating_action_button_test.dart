import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:history_app/blocs/theme/theme.dart';
import 'package:history_app/widgets/theme_floating_action_button.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

void main() {
  group('ThemeButton render', () {
    testWidgets('ThemeButton is rendered', (tester) async {
      await tester.pumpApp(
        ThemeFloatingActionButton(),
      );
      expect(find.byType(ThemeFloatingActionButton), findsOneWidget);
    });
  });

  group('ThemeFloatingActionButton', () {
    const themeFloatingActionKey = Key(
      'ThemeFloatingActionButton_ChangeTheme',
    );

    late ThemeCubit themeCubit;

    setUpAll(() {
      registerFallbackValue<ThemeMode>(ThemeMode.light);
      themeCubit = MockThemeCubit();
    });

    testWidgets(
        'calls themeCubit.changeTheme '
        'when floating action button is pressed', (tester) async {
      const state = ThemeMode.light;
      when(() => themeCubit.state).thenReturn(state);
      when(() => themeCubit.changeTheme()).thenReturn(null);

      await tester.pumpApp(
        BlocProvider.value(
          value: themeCubit,
          child: ThemeFloatingActionButton(),
        ),
      );

      await tester.tap(find.byKey(themeFloatingActionKey));
      verify(() => themeCubit.changeTheme()).called(1);
    });
  });
}
