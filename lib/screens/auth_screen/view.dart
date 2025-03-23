import 'package:MVF/screens/auth_screen/registration_widget/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controller.dart';
import 'login_widget/view.dart';


class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ Keeps content visible when the keyboard is open
      backgroundColor: const Color(0xFF2F455C),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Align(
              alignment:
              keyboardOpen ? Alignment.topCenter : Alignment.center, // ✅ Move up when keyboard opens
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30), // Reduced the space from top
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Hero for Logo
                        Hero(
                          tag: "appLogo",
                          child: Image.asset(
                            'asset/icons/app_icon.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Hero for App Name
                        const Hero(
                          tag: "appName",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "VVF",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Closer to the container

                    // Middle Section: Container for Login/Register Tabs
                    Container(
                      width: screenWidth > 600 ? 400 : screenWidth * 0.95,
                      height: 600,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // ✅ Added margin
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEFF5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: DefaultTabController(
                        initialIndex: ref.watch(tabIndexProvider) ,
                        length: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TabBar(
                              labelColor: Color(0xFF2F455C),
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Color(0xFF21D0B2),
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.login),
                                  text: "Login",
                                ),
                                Tab(
                                  icon: Icon(Icons.person_add),
                                  text: "Register",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: Center(
                                child: TabBarView(
                                  children: [
                                    buildLoginTab(context, ref),
                                    buildRegistrationTab(context,ref),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Footer: "Developed by AKASH R"
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Developed by",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Arul S",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
