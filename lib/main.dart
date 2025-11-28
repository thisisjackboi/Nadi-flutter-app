import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'types.dart';
import 'constants.dart';
import 'screens/splash_screen.dart';
import 'screens/language_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/grievance_list_screen.dart';
import 'screens/grievance_detail_screen.dart';
import 'screens/submit_grievance_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const NadiApp());
}

class NadiApp extends StatefulWidget {
  const NadiApp({super.key});

  @override
  State<NadiApp> createState() => _NadiAppState();
}

class _NadiAppState extends State<NadiApp> {
  ScreenName _screen = ScreenName.SPLASH;
  User? _user;
  Language _language = Language.ENGLISH;
  List<Grievance> _grievances = MOCK_GRIEVANCES;
  Grievance? _selectedGrievance;
  String _activeTab = 'home'; // home, submit, profile

  void _handleLogin(String phone) {
    setState(() {
      _user = User(phoneNumber: phone, isVerified: true, name: "Arunav Das");
      _screen = ScreenName.DASHBOARD;
      _activeTab = 'home';
    });
  }

  void _handleLogout() {
    setState(() {
      _user = null;
      _screen = ScreenName.LOGIN_LANG;
      _activeTab = 'home';
      _grievances = MOCK_GRIEVANCES; // Reset
    });
  }

  void _handleTabChange(String tab) {
    if (tab == 'submit') {
      setState(() => _screen = ScreenName.SUBMIT);
    } else {
      setState(() {
        _activeTab = tab;
        if (tab == 'home') _screen = ScreenName.DASHBOARD;
        if (tab == 'profile') _screen = ScreenName.PROFILE;
      });
    }
  }

  void _handleGrievanceSubmit(PartialGrievance g) {
    final newGrievance = Grievance(
      id: 'GR-${DateTime.now().year}-${(DateTime.now().millisecondsSinceEpoch % 10000)}',
      title: g.title!,
      description: g.description!,
      category: g.category!,
      location: g.location!,
      status: GrievanceStatus.SUBMITTED,
      dateSubmitted: DateTime.now().toString().split(' ')[0],
      imageUrl: g.imageUrl ?? 'https://picsum.photos/400/300',
      isAnonymous: g.isAnonymous ?? false,
      updates: [
        GrievanceUpdate(
          date: DateTime.now().toString().split(' ')[0],
          title: 'Submitted',
          description: 'Received by system',
          author: 'System',
        ),
      ],
    );

    setState(() {
      _grievances = [newGrievance, ..._grievances];
      _activeTab = 'home';
      _screen = ScreenName.DASHBOARD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nadi App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            _buildScreen(),
            if (_user != null && (_screen == ScreenName.DASHBOARD || _screen == ScreenName.PROFILE || _screen == ScreenName.ALL_GRIEVANCES))
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomNav(
                  activeTab: _activeTab,
                  onTabChange: _handleTabChange,
                  lang: _language,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen() {
    switch (_screen) {
      case ScreenName.SPLASH:
        return SplashScreen(onComplete: () => setState(() => _screen = ScreenName.LOGIN_LANG));
      
      case ScreenName.LOGIN_LANG:
        return LanguageScreen(onSelect: (l) => setState(() {
          _language = l;
          _screen = ScreenName.LOGIN;
        }));
      
      case ScreenName.LOGIN:
        return LoginScreen(
          onLogin: _handleLogin,
          lang: _language,
        );
      
      case ScreenName.DASHBOARD:
        if (_user == null) return const SizedBox();
        return DashboardScreen(
          user: _user!,
          grievances: _grievances,
          onGrievanceClick: (g) => setState(() {
            _selectedGrievance = g;
            _screen = ScreenName.GRIEVANCE_DETAIL;
          }),
          onViewAll: () => setState(() => _screen = ScreenName.ALL_GRIEVANCES),
          lang: _language,
        );
      
      case ScreenName.ALL_GRIEVANCES:
        return GrievanceListScreen(
          grievances: _grievances,
          onBack: () => setState(() => _screen = ScreenName.DASHBOARD),
          onGrievanceClick: (g) => setState(() {
            _selectedGrievance = g;
            _screen = ScreenName.GRIEVANCE_DETAIL;
          }),
          lang: _language,
        );
      
      case ScreenName.SUBMIT:
        return SubmitGrievanceScreen(
          onClose: () => setState(() => _screen = ScreenName.DASHBOARD),
          onSubmit: _handleGrievanceSubmit,
          lang: _language,
        );
      
      case ScreenName.GRIEVANCE_DETAIL:
        if (_selectedGrievance == null) return const SizedBox();
        return GrievanceDetailScreen(
          grievance: _selectedGrievance!,
          onBack: () => setState(() => _screen = _activeTab == 'home' ? ScreenName.DASHBOARD : ScreenName.ALL_GRIEVANCES),
        );
      
      case ScreenName.PROFILE:
        if (_user == null) return const SizedBox();
        return ProfileScreen(
          user: _user!,
          onLogout: _handleLogout,
          lang: _language,
        );
    }
  }
}
