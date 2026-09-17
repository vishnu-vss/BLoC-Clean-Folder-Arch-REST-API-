import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';

class PracticeBlocWithRest extends StatelessWidget {
  const PracticeBlocWithRest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Practice BLoC with REST API',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.routes,
    );
  }
}
