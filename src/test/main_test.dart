
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_pet_app/main.dart';

class MockPetCubit extends MockCubit<PetModel> implements PetCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders HomeScreen', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('HomeScreen', () {
		late PetCubit petCubit;

		setUp(() {
			petCubit = MockPetCubit();
		});

		testWidgets('displays initial pet text and icon', (tester) async {
			when(() => petCubit.state).thenReturn(PetModel(text: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider.value(
					value: petCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('updates pet text and icon when clicked', (tester) async {
			whenListen(
				petCubit,
				Stream.fromIterable([
					PetModel(text: 'Cat', icon: Icons.access_time),
					PetModel(text: 'Dog', icon: Icons.person),
				]),
				initialState: PetModel(text: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				BlocProvider.value(
					value: petCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
