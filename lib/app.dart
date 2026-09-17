import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';

import 'features/post/post_di.dart';

class PracticeBlocWithRest extends StatelessWidget {
  const PracticeBlocWithRest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [...initializePostDependencies()],
      child: MultiBlocProvider(
        providers: [...initializePostBlocs()],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Practice BLoC with REST API',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: AppRouter.routes,
        ),
      ),
    );
  }
}
