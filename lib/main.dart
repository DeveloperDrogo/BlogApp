import 'package:clean/core/secrets/app_secrets.dart';
import 'package:clean/core/theme/theme.dart';
import 'package:clean/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_up.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthoRepositoryImpl(
              AuthRemoateDataSourceImpl(supabaseClient: supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Apptheme.darkModeTheme,
        home: const LoginPage());
  }
}
