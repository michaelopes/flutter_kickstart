import 'package:example/assets_snippeds/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../../assets_snippeds/app_icons.dart';
import '../../assets_snippeds/app_images.dart';
import 'use_assets_viewmodel.dart';

class UseAssetsView extends FkView<UseAssetsViewModel> {
  UseAssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to using assets"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
             This is an example of how to use images assets
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                In this way, just place the image file inside the assets/images 
                folder and directly call the file name and its extension separated 
                by the  symbol "$"  as below:


              If the file has the PNG file extension, it is not necessary to inform 
              the extension after the symbol "$" 
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutterj$JPEG,
              ),
              const SizedBox(
                width: 24,
              ),
              /* If image is PNG is not necessary to inform the extension */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutter,
              ),
              const SizedBox(
                width: 24,
              ),
              /* 
               In this way, a snippet was created to aid in the search for image files found 
               within the assets_snippeds/app_images folder. dart the snippet is a reference 
               aid for files added within the assets/images folder, the name of the snippet variable 
               must have the same name as the file in the folder if it is a PNG it is not foreseen 
               to specify the extension of the same case the extension must be written 
               after the symbol "$"  as below:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child:
                    theme.assets<AppImagesSnippets>().flutterj$JPEG.toImage(),
              ),
              const SizedBox(
                width: 24,
              ),
              /* If image is PNG is not necessary to inform the extension */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppImagesSnippets>().flutter.toImage(),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          /*
             This is an example of how to use icons assets
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                In this way, just place the icon file inside the assets/icons 
                folder and directly call the file name and its extension separated 
                by the  symbol "$"  as below:

              If the file has the SVG file extension, it is not necessary to inform 
              the extension after the symbol "$" 
              **/
              SizedBox(height: 50, width: 50, child: theme.icons.flutter$PNG),
              const SizedBox(
                width: 24,
              ),
              /* If image is SVG is not necessary to inform the extension */
              SizedBox(height: 50, width: 50, child: theme.icons.flutter),
              const SizedBox(
                width: 24,
              ),
              /* 
               In this way, a snippet was created to aid in the search for icons files found 
               within the assets_snippeds/app_icons folder. dart the snippet is a reference 
               aid for files added within the assets/icons folder, the name of the snippet variable 
               must have the same name as the file in the folder if it is a SVG it is not foreseen 
               to specify the extension of the same case the extension must be written 
               after the symbol "$"  as below:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppIconsSnippets>().flutter$PNG.toIcon(),
              ),
              const SizedBox(
                width: 24,
              ),
              /* If image is SVG is not necessary to inform the extension */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppIconsSnippets>().flutter.toIcon(),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          /*
             This is an example of how to use animations assets 
             ONLY JSON IS ALLOWED
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                In this way, just place the icon file inside the assets/animations 
                folder and directly call the file name bellow:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.animations.splash2,
              ),
              const SizedBox(
                width: 24,
              ),

              /* 
               In this way, a snippet was created to aid in the search for animations files found 
               within the assets_snippeds/app_animatios folder. dart the snippet is a reference 
               aid for files added within the assets/animations folder, the name of the snippet variable 
               must have the same name as the file in the folder ex:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child:
                    theme.assets<AppAnimationsSnippets>().splash.toAnimation(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
