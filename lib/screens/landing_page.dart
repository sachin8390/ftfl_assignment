import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ui_portfolio/theme.dart';
import 'package:ui_portfolio/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: context.isPhone
            ? InkWell(
                onTap: () {
                  _key.currentState?.openDrawer();
                },
                child: const Icon(Icons.menu),
              )
            : null,
        title: Text(
          'Creative',
          style: GoogleFonts.dancingScript(
            fontSize: context.isPhone ? 30 : 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        actions: context.isPhone
            ? []
            : [
                _createNavItem(context, 'Home', selected: true),
                _createNavItem(context, 'Skills'),
                _createNavItem(context, 'Services'),
                _createNavItem(context, 'Contact'),
              ],
      ),
      drawer: context.isPhone
          ? SafeArea(
              child: Drawer(
                width: 40.w,
                child: const Column(
                  children: [
                    SizedBox(height: 40),
                    ListTile(
                      title: Text('Home'),
                    ),
                    ListTile(
                      title: Text('Skills'),
                    ),
                    ListTile(
                      title: Text('Services'),
                    ),
                    ListTile(
                      title: Text('Contact'),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: context.isPhone ? 0 : 90.w),
              child: Transform.rotate(
                angle: 2.2,
                child: Container(
                  width: 100.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.rotate(
                        angle: -2.2,
                        child: Image.asset(
                          'assets/images/businessman.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.isPhone ? 38.h : 12.h),
                context.isPhone ? _wrapCenter(_introSection()) : _introSection(),
                const SizedBox(height: 30),
                context.isPhone ? _wrapCenter(_hireMeButton()) : _hireMeButton(),
                const SizedBox(height: 30),
                context.isPhone ? _wrapCenter(_statisticsWidget()) : _statisticsWidget(),
                context.isPhone ? SizedBox(height: 10.h) : SizedBox(height: 3.h),
                _socialMediaSection(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _introSection() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.isPhone ? 0 : 20.w,
      ),
      child: Column(
        crossAxisAlignment: context.isPhone ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'HEY THERE, ',
            style: TextStyle(
              fontSize: context.isPhone ? 21 : 40,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'I AM ',
                  style: TextStyle(
                    fontSize: context.isPhone ? 28 : 50,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: 'SMITH WILLIS',
                  style: TextStyle(
                    fontSize: context.isPhone ? 28 : 50,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: context.isPhone ? 80.w : 60.w,
            child: Text(
              'lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              textAlign: context.isPhone ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hireMeButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.isPhone ? 0 : 20.w,
      ),
      child: ElevatedButton(
        onPressed: () {
          ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
          if (themeNotifier.themeMode == ThemeMode.light) {
            themeNotifier.setTheme(ThemeMode.dark);
          } else {
            themeNotifier.setTheme(ThemeMode.light);
          }
          },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 1.5.h,
            horizontal: 50,
          ), backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'HIRE ME',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _statisticsWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.isPhone ? 0 : 20.w,
      ),
      child: Row(
        mainAxisAlignment: context.isPhone ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          _statisticsWidgetComponent('281+', 'TASK DONE'),
          const SizedBox(width: 10),
          _statisticsWidgetComponent('2800', 'CLIENTS'),
          const SizedBox(width: 10),
          _statisticsWidgetComponent('50+', 'COMPANIES'),
        ],
      ),
    );
  }

  Container _statisticsWidgetComponent(String title, String subtitle) {
    return Container(
      width: context.isPhone ? 28.w : 15.w,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.isDarkMode ? Colors.white : Colors.blueAccent.withOpacity(0.7),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: context.isDarkMode
                  ? Theme.of(context).primaryColor.withOpacity(.8)
                  : Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.isDarkMode
                  ? Theme.of(context).primaryColor.withOpacity(.8)
                  : Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _socialMediaSection() {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              launch("https://mail.google.com/mail/u/0/#inbox");
            },
            child: Icon(
              Icons.mail_outline,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              launch("https://github.com/");
            },
            child: Icon(
              Icons.call_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              launch("https://www.snapchat.com/");
            },
            child: Icon(
              Icons.snapchat_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              launch("https://www.instagram.com/accounts/login/?hl=en");
            },
            child: Icon(
              Icons.wordpress_outlined,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _wrapCenter(Widget child) {
    return Center(
      child: child,
    );
  }

  Row _createNavItem(BuildContext context, String title, {bool selected = false}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 2,
              width: 40,
              color: selected ? Theme.of(context).primaryColor : Colors.transparent,
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  static void launch(String address) async {
    Uri url = Uri.parse(address);
    if (await canLaunchUrl(url)) {
      await launchUrl(url); // Launch the URL

    } else {
      throw 'Could not launch $url';
    }
  }
}
