import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feature/favorites/cubit/favorites_cubit.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavoritesCubit>(),
      child: const Scaffold(
        body: Center(
          child: Text("Favorites View"),
        ),
      ),
    );
  }
}
