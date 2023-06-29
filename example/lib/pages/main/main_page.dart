import 'package:example/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../../assets_snippeds/app_icons.dart';
import '../../assets_snippeds/app_images.dart';
import 'main_viewmodel.dart';

class MainView extends FkView<MainViewModel> {
  MainView({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr.pages.main.testeX(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  vm.setModuleValue();
                  context.push(AppRoutes.mainSecond);
                },
                child: const Text("Navegação"),
              ),
              const SizedBox(
                height: 16,
              ),

              const SizedBox(
                height: 16,
              ),
              Text(vm.reactive.novo4),
              const Text("ViewModel"),
              Text(vm.reactive.global.counter.toString()),
              const SizedBox(
                height: 16,
              ),
              const Text("User status"),
              Text(vm.reactive.user.enable.toString()),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  vm.increment();
                },
                child: const Text("Increment"),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost icon import
              SizedBox(
                height: 50,
                width: 50,
                child: theme.icons.flutter,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppIcons>().flutter.toIcon(),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost image import without extension
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutter,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped without extension
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppImages>().flutter.toImage(),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost image import with extension
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutterj$JPEG,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped withextension
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppImages>().flutterj$JPEG.toImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class MainPage extends FkStatefulPage<IMainViewmodel> {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("context build f ${context.hashCode}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tr.pages.main.title(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.vm.setModuleValue();
                  context.push(Modules.mainSecond);
                },
                child: const Text("Navegação"),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost icon import
              SizedBox(
                height: 50,
                width: 50,
                child: widget.icons.flutter,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped
              SizedBox(
                height: 50,
                width: 50,
                child: widget.assets<AppIcons>().flutter.toIcon(),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost image import without extension
              SizedBox(
                height: 50,
                width: 50,
                child: widget.images.flutter,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped without extension
              SizedBox(
                height: 50,
                width: 50,
                child: widget.assets<AppImages>().flutter.toImage(),
              ),
              const SizedBox(
                height: 16,
              ),
              //Ghost image import with extension
              SizedBox(
                height: 50,
                width: 50,
                child: widget.images.flutterj$JPEG,
              ),
              const SizedBox(
                height: 16,
              ),
              //Import icon by snipped withextension
              SizedBox(
                height: 50,
                width: 50,
                child: widget.assets<AppImages>().flutterj$JPEG.toImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/


/*class MainPage extends FkStatelessPage<IMainViewmodel> {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr.pages.main.title(),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            QR.toName(Modules.mainSecond);
          },
          child: Text("teste"),
        ),
      ),
    );
  }
}*/
