
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_package_name/cubits/pet_cubit.dart';
import 'package:your_package_name/models/pet_model.dart';

// Mocking PetModel since it's used within PetCubit
class MockPetModel extends Mock implements PetModel {}

void main() {
	group('PetCubit', () {
		late PetCubit petCubit;
		late PetModel initialPetModel;
		late PetModel toggledPetModel;

		setUp(() {
			initialPetModel = PetModel(text: 'Cat', icon: Icons.pets);
			toggledPetModel = PetModel(text: 'Dog', icon: Icons.person);
			petCubit = PetCubit();
		});

		tearDown(() {
			petCubit.close();
		});

		test('initial state is correct', () {
			expect(petCubit.state.text, equals('Cat'));
			expect(petCubit.state.icon, equals(Icons.pets));
		});

		blocTest<PetCubit, PetModel>(
			'emits [toggledPetModel] when togglePet is called',
			build: () => petCubit,
			act: (cubit) => cubit.togglePet(),
			expect: () => [toggledPetModel],
		);

		blocTest<PetCubit, PetModel>(
			'emits [initialPetModel] when togglePet is called twice',
			build: () => petCubit,
			act: (cubit) {
				cubit.togglePet();
				cubit.togglePet();
			},
			expect: () => [toggledPetModel, initialPetModel],
		);
	});
}
