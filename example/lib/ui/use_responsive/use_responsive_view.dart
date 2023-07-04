import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'use_responsive_viewmodel.dart';

class UseResponsiveView extends FkView<UseResponsiveViewModel> {
  UseResponsiveView({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resposive Grid System",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FkResponsiveLayout.builderByDevice(
              mobile: (_, __) {
                return const Center(
                  child: Text("MOBILE"),
                );
              },
              tablet: (_, __) {
                return const Center(
                  child: Text("TABLET"),
                );
              },
              desktop: (_, __) {
                return const Center(
                  child: Text("DESKTOP"),
                );
              },
            ),
            FkResponsiveRow(
              children: [
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.red,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.blue,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.green,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    width: 400,
                    color: Colors.yellow,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
