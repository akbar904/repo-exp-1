
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:com.example.simple_pet_app/models/pet_model.dart';

void main() {
	group('PetModel', () {
		test('should create a PetModel with the correct text and icon', () {
			final petModel = PetModel(text: 'Cat', icon: Icons.pets);

			expect(petModel.text, 'Cat');
			expect(petModel.icon, Icons.pets);
		});

		test('should update text and icon correctly', () {
			final petModel = PetModel(text: 'Cat', icon: Icons.pets);

			petModel.text = 'Dog';
			petModel.icon = Icons.person;

			expect(petModel.text, 'Dog');
			expect(petModel.icon, Icons.person);
		});
	});
}
