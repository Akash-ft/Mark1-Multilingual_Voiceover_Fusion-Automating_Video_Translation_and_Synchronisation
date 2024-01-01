import 'package:b_native/screens/home_screen/video_translate_widget/view.dart';
import 'package:b_native/screens/home_screen/voice_translate_widget/view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build layout");
    final homeController = ref.read(homeSProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'BNative',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        print("Build body");
        final currentIndex = ref.watch(homeController.bottomNavIndexProvider);
        return IndexedStack(
          index: currentIndex,
          children: const [
            Center(child: VideoTranslateWidget()),
            Center(child: AudioTranslateWidget()),
          ],
        );
      }),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          print(" build nav");
          final currentIndex = ref.watch(homeController.bottomNavIndexProvider);
          return NavigationBar(
            selectedIndex: currentIndex,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.switch_video_outlined, size: 30),
                  label: 'Media'),
              // NavigationDestination(
              //   icon: Icon(Icons.image_search_outlined,size: 30), label: 'Image'),
              NavigationDestination(
                  icon: Icon(Icons.record_voice_over_outlined, size: 30),
                  label: 'Voice'),
            ],
            onDestinationSelected: (value) {
              ref
                  .read(homeController.bottomNavIndexProvider.notifier)
                  .update((state) => value);
            },
          );
        },
      ),
    );
  }
}
