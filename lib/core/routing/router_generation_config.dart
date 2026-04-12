import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/features/about_us/about_us_screen.dart';
import 'package:tranqulity/features/auth/forget_password_screen.dart';
import 'package:tranqulity/features/auth/login_screen.dart';
import 'package:tranqulity/features/auth/otp_screen.dart';
import 'package:tranqulity/features/auth/register_screen.dart';
import 'package:tranqulity/features/auth/reset_password_screen.dart';
import 'package:tranqulity/features/chat/assistant_screen.dart';
import 'package:tranqulity/features/chat/chat_screen.dart';
import 'package:tranqulity/features/home/main_screen.dart';
import 'package:tranqulity/features/onboarding/onboarding_screen.dart';
import 'package:tranqulity/features/profile/change_password_screen.dart';
import 'package:tranqulity/features/splash/splash_screen.dart';
import 'package:tranqulity/features/suggestions/suggestions_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.onboardingScreen,
        path: AppRoutes.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.registerScreen,
        path: AppRoutes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: AppRoutes.forgetPasswordScreen,
        path: AppRoutes.forgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        name: AppRoutes.otpScreen,
        path: AppRoutes.otpScreen,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        name: AppRoutes.resetPasswordScreen,
        path: AppRoutes.resetPasswordScreen,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        name: AppRoutes.mainScreen,
        path: AppRoutes.mainScreen,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: AppRoutes.chatScreen,
        path: AppRoutes.chatScreen,
        builder: (context, state) {
          final title = state.extra as String? ?? 'Chat';
          return ChatScreen(chatTitle: title);
        },
      ),
      GoRoute(
        name: AppRoutes.assistantScreen,
        path: AppRoutes.assistantScreen,
        builder: (context, state) => const AssistantScreen(),
      ),
      GoRoute(
        name: AppRoutes.changePasswordScreen,
        path: AppRoutes.changePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        name: AppRoutes.aboutUsScreen,
        path: AppRoutes.aboutUsScreen,
        builder: (context, state) => const AboutUsScreen(),
      ),
      GoRoute(
        name: AppRoutes.suggestionsScreen,
        path: AppRoutes.suggestionsScreen,
        builder: (context, state) => const SuggestionsScreen(),
      ),
    ],
  );
}
