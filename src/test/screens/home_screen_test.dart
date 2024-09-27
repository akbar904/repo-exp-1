
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_pet_app/screens/home_screen.dart';

class MockPetCubit extends MockCubit<PetModel> implements PetCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays initial pet text and icon', (WidgetTester tester) async {
			// Arrange
			final mockCubit = MockPetCubit();
			when(() => mockCubit.state).thenReturn(PetModel(text: 'Cat', icon: Icons.pets));

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<PetCubit>(
						create: (_) => mockCubit,
						child: HomeScreen(),
					),
				),
			);

			// Assert
			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('changes pet text and icon on click', (WidgetTester tester) async {
			// Arrange
			final mockCubit = MockPetCubit();
			whenListen(
				mockCubit,
				Stream.fromIterable([
					PetModel(text: 'Cat', icon: Icons.pets),
					PetModel(text: 'Dog', icon: Icons.person),
				]),
				initialState: PetModel(text: 'Cat', icon: Icons.pets),
			);

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<PetCubit>(
						create: (_) => mockCubit,
						child: HomeScreen(),
					),
				),
			);
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			// Assert
			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
