import 'package:clean/core/theme/app_pallet.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/auth/presentation/pages/login.dart';
import 'package:clean/features/auth/presentation/widgets/auth_field.dart';
import 'package:clean/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                obsecured: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthGradientButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint(
                        '${nameController.text},${emailController.text},${passwordController.text}');
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(AuthSignup(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()));
                },
                child: RichText(
                    text: TextSpan(
                        text: "Already have an account ?  ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                      TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.w500))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
