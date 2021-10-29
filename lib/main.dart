import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_market/cubit/cubit.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => FoodCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              context.read<FoodCubit>().getFoods();
              context.read<TransactionCubit>().getTransaction();
              return MainPage();
            }
            return SignInPage();
          },
        ),
      ),
    );
  }
}
