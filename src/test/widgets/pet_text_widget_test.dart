
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_pet_app/widgets/pet_text_widget.dart';

// Mock PetCubit
class MockPetCubit extends MockCubit<PetModel> implements PetCubit {}

void main() {
	group('PetTextWidget', () {
		late PetCubit petCubit;

		setUp(() {
			petCubit = MockPetCubit();
		});

		testWidgets('displays the initial pet text and icon', (WidgetTester tester) async {
			when(() => petCubit.state).thenReturn(PetModel(text: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: petCubit,
						child: PetTextWidget(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays the updated pet text and icon on click', (WidgetTester tester) async {
			when(() => petCubit.state).thenReturn(PetModel(text: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: petCubit,
						child: PetTextWidget(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();
			
			verify(() => petCubit.togglePet()).called(1);
		});
	});
}
