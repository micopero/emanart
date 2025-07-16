import 'package:emanart/src/core/navigation/emanart_router.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmanArt extends StatelessWidget {
  const EmanArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'EmanArt',
          debugShowCheckedModeBanner: false,
          // we use EmanArtRouter.router INSTEAD OF
          // EmanArtRouter().router.. because we set
          // the router to be static.. but why static?
          // to prevent the router continuous restarting
          // and hence, the splash screen replaying
          routerConfig: EmanArtRouter.router,
        );
      },
    );
  }
}
