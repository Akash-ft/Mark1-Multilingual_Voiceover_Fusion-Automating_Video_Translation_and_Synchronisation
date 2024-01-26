import 'package:MVF/screens/home_screen/state.dart';
import 'package:MVF/screens/home_screen/video_translate_widget/view.dart';
import 'package:MVF/screens/home_screen/voice_translate_widget/view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    handleStateChange(ref, context);
    final state = ref.watch(homeSProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F455C),
        centerTitle: true,
        title: Text(
          'MVF',
          style: TextStyle(color: Colors.white,fontFamily: "Quicksand",fontWeight: FontWeight.w700),
        ),
      ),
      body: IndexedStack(
        index: state.tabIndex,
        children: const [
          Center(child: VideoTranslateWidget()),
          Center(child: VoiceTranslateWidget()),
        ],
      ),
      bottomNavigationBar:  BottomNavigationBar(
        backgroundColor: Color(0xFF2F455C),
          currentIndex: state.tabIndex!,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.switch_video_outlined, size: 40),
                label: 'Media'),
            BottomNavigationBarItem(
                icon: Icon(Icons.record_voice_over_outlined, size: 40),
                label: 'Voice'),
          ],
          selectedItemColor:Color(0xFF21D0B2) ,
          unselectedItemColor: Colors.white,
          onTap: (value) {
            ref.read(homeSProvider.notifier).switchTab(value);
          },
        ),
    );
  }
}

void handleStateChange(
  WidgetRef ref,
  BuildContext context,
) {
  ref.listen<HomeScreenState>(homeSProvider, (previous, next) {});
}
