
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_pet_app/cubits/pet_cubit.dart';
import 'package:com.example.simple_pet_app/widgets/pet_text_widget.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Pet App'),
			),
			body: Center(
				child: BlocBuilder<PetCubit, PetModel>(
					builder: (context, state) {
						return GestureDetector(
							onTap: () => context.read<PetCubit>().togglePet(),
							child: PetTextWidget(
								text: state.text,
								icon: state.icon,
							),
						);
					},
				),
			),
		);
	}
}
