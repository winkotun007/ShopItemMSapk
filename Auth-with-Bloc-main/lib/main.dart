import 'dart:io';

import 'package:auth_with_bloc/core/base/service/auth_service.dart';
import 'package:auth_with_bloc/core/constants/app/string_constants.dart';
import 'package:auth_with_bloc/core/init/cache/auth_cache_manager.dart';
import 'package:auth_with_bloc/core/init/network/dio_manager.dart';
import 'package:auth_with_bloc/view/auth/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/base/bloc/auth_bloc.dart';
import 'core/base/bloc/product/productSerarch/product_search_bloc.dart';
import 'core/base/bloc/product/product_list_cubit.dart';
import 'core/init/cache/tokenProvider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
void main() {
  HttpOverrides.global = MyHttpOverrides();
  // runApp(
  //   BlocProvider<AuthBloc>(
  //     create: (_) => AuthBloc(
  //       AuthService(DioManager.instance),
  //       AuthCacheManager(),
  //     ),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(
    MultiProvider(
      providers: [
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) =>
                  AuthBloc(
                    AuthService(DioManager.instance),
                    AuthCacheManager(),
                  ),
            ),
            BlocProvider<SearchProductBloc>(
              create: (_) => SearchProductBloc(),
            ),
            BlocProvider<ProductListCubit>(
              create: (_) => ProductListCubit(),
            ),
          ],
          child: const MyApp(),
        ),
      ],
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home: SplashView(),
    );
  }
}




class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
