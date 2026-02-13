import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ta9sela/feature/auth/presentation/screens/createUser.dart';
import 'package:ta9sela/feature/auth/presentation/screens/page1.dart';
import 'package:ta9sela/feature/auth/presentation/screens/page2.dart';
import 'package:ta9sela/feature/home/presentation/widgets/livelocation.dart';
import 'package:ta9sela/feature/map/presentation/screens/driverDetails.dart';
import 'package:ta9sela/feature/map/presentation/screens/map.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripCubit.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/usersCubit.dart';
import 'package:ta9sela/feature/home/data/repositories/DriverRepository.dart';
import 'package:ta9sela/feature/home/data/repositories/TripRepository.dart';
import 'package:ta9sela/feature/home/data/repositories/UserRepository.dart';
import 'package:ta9sela/feature/home/presentation/screens/layout.dart';
import 'package:ta9sela/feature/home/presentation/widgets/home_screen.dart';
import 'package:ta9sela/feature/message/presentation/screens/message.dart';
import 'package:ta9sela/feature/onboarding/onboarding_screen.dart';
import 'package:ta9sela/feature/profile/presentation/screens/profile.dart';
import 'package:ta9sela/feature/profile/presentation/screens/update_profile.dart';
import 'package:ta9sela/feature/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String page1 = '/page1';
  static const String onboarding = '/onboarding';
  static const String page2 = '/page2';
  static const String createuser = '/createuser';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String message = '/message';
  static const String layout = '/layout';
  static const String driverDetails = '/driverDetails';
  static const String live = '/live';
  static const String update='/update';

  static GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(
        path: update,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return UserCubit(UserRepository());
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DriverCubit(DriverRepository(), UserRepository());
                },
              ),
            ],
            child: EditProfileScreen(user: state.extra as dynamic),
          );
        },
      ),
     
      GoRoute(path:   live, builder: (context, state) => LiveTrackScreen(tripId: state.extra as String? ?? '',)),
      GoRoute(
        path: driverDetails,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final driver = extra['driver'];
          final user = extra['user'];

          return BlocProvider(
            create: (BuildContext  context) {
              return TripCubit(TripRepository());
            },
            child: Driverdetails(driver: driver!, user: user),
          );
        },
      ),
      GoRoute(
        path: layout,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final user = extra['user'];
          final usertype = extra['usertype'];
          return MainLayout(user: user, usertype: usertype);
        },
      ),

       GoRoute(path: profile, builder: (context, state) => ProfileScreen(user: state.extra, usertype: 'user')),
      GoRoute(
        path: history,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return UserCubit(UserRepository());
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DriverCubit(DriverRepository(), UserRepository());
                },
              ),
            ],
            child: HistoryScreen(user: state.extra),
          );
        },
      ),
      GoRoute(path: message, builder: (context, state) => MessageScreen()),
      GoRoute(
        path: home,
        builder: (context, state) {
          return HomeScreen(user: state.extra, usertype: null);
        },
      ),

      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => OnBoardingScreens(),
      ),
      GoRoute(
        path: page1,
        builder: (context, state) =>
            LoginOptionsScreen(usertype: state.extra.toString()),
      ),
      //GoRoute(path: page2, builder: (context, state) =>  LoginScreen(usertype: state.extra as Usertype),),
      // GoRoute(path: createuser, builder: (context, state) => Createuser(usertype: state.extra as Usertype),),
      GoRoute(
        path: page2,
        builder: (context, state) {
          final usertype = state.extra;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return UserCubit(UserRepository());
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DriverCubit(DriverRepository(), UserRepository());
                },
              ),
            ],
            child: LoginScreen(usertype: usertype.toString()),
          );
        },
      ),
      GoRoute(
        path: createuser,
        builder: (context, state) {
          // final usertype = state.extra! as Usertype;
          final usertype = state.extra ?? "user";

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) {
                  return UserCubit(UserRepository());
                },
              ),
              BlocProvider(
                create: (BuildContext context) {
                  return DriverCubit(DriverRepository(), UserRepository());
                },
              ),
            ],
            child: Createuser(usertype: usertype.toString()),
          );
        },
      ),
    ],
  );
}
