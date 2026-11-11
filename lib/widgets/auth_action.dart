import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
const _authRedirect = 'gonzaga-techshop://login-callback/';

bool get _hasSupabaseConfig =>
    _supabaseUrl.isNotEmpty && _supabaseAnonKey.isNotEmpty;

class AuthAction extends StatelessWidget {
  const AuthAction({super.key});

  @override
  Widget build(BuildContext context) {
    if (!_hasSupabaseConfig) return const SizedBox.shrink();

    final auth = Supabase.instance.client.auth;
    return StreamBuilder<AuthState>(
      stream: auth.onAuthStateChange,
      initialData: AuthState(
        AuthChangeEvent.initialSession,
        auth.currentSession,
      ),
      builder: (context, snapshot) {
        final user = snapshot.data?.session?.user;
        return IconButton(
          tooltip: user == null
              ? 'Sign in'
              : 'Account: ${user.email ?? 'Google user'}',
          onPressed: () => _showAccountDialog(context, user),
          icon: Icon(
            user == null ? Icons.account_circle_outlined : Icons.account_circle,
          ),
        );
      },
    );
  }

  Future<void> _showAccountDialog(BuildContext context, User? user) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(user == null ? 'Sign in to Tech Shop' : 'Your account'),
        content: user == null
            ? const Text('Use your Google account to sign in.')
            : Text(user.email ?? 'Signed in with Google'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
          if (user == null)
            FilledButton.icon(
              onPressed: () => _signIn(context, dialogContext),
              icon: const Icon(Icons.login),
              label: const Text('Continue with Google'),
            )
          else
            FilledButton.tonal(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                try {
                  await Supabase.instance.client.auth.signOut();
                } on AuthException catch (error) {
                  if (context.mounted) _showError(context, error.message);
                }
              },
              child: const Text('Sign out'),
            ),
        ],
      ),
    );
  }

  Future<void> _signIn(BuildContext context, BuildContext dialogContext) async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : _authRedirect,
      );
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
    } on AuthException catch (error) {
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
      if (context.mounted) _showError(context, error.message);
    } catch (_) {
      if (dialogContext.mounted) Navigator.of(dialogContext).pop();
      if (context.mounted) {
        _showError(
          context,
          'Google sign-in could not be started. Please try again.',
        );
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sign-in error: $message')));
  }
}
