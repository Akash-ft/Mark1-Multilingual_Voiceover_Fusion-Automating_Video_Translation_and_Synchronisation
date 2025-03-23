
import 'package:MVF/app_settings/app_key.dart';
import 'package:MVF/utils/router/go_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Token().supaBaseUrl,
    anonKey: Token().supaBaseApiKey,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'MVF',
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
