
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:your_package_name/models/pet_model.dart';

class PetCubit extends Cubit<PetModel> {
	PetCubit() : super(PetModel(text: 'Cat', icon: Icons.pets));

	void togglePet() {
		if (state.text == 'Cat') {
			emit(PetModel(text: 'Dog', icon: Icons.person));
		} else {
			emit(PetModel(text: 'Cat', icon: Icons.pets));
		}
	}
}
