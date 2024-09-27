
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pet_cubit.dart';
import '../models/pet_model.dart';

class PetTextWidget extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<PetCubit, PetModel>(
			builder: (context, state) {
				return GestureDetector(
					onTap: () {
						context.read<PetCubit>().togglePet();
					},
					child: Row(
						children: [
							Text(state.text),
							Icon(state.icon),
						],
					),
				);
			},
		);
	}
}
