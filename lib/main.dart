
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/core/routes/go_router.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
import 'package:ta9sela/feature/home/data/repositories/DriverRepository.dart';
import 'package:ta9sela/feature/home/data/repositories/TripRepository.dart';
import 'package:ta9sela/feature/home/data/repositories/UserRepository.dart';
import 'package:ta9sela/firebase_options.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => UserCubit(UserRepository())),
      BlocProvider(create: (_) => DriverCubit(DriverRepository(), UserRepository())),
      BlocProvider(create: (_) => TripCubit(TripRepository())),
    ],
    child: const MyApp(),
  ),
);


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
          routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        fontFamily: 'Hacen',   
      ),
    );
  }
}

