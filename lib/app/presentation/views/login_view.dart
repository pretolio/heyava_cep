

import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/custom_textformfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late FlutterGifController gifController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(text: 'gabriel.mattos.web@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '123');
  final TextEditingController _cpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSingIn = true;


  @override
  void initState() {
    gifController = FlutterGifController(vsync: this, duration: Duration(seconds:12));
    gifController.repeat(min: 0, max: 118);
    super.initState();
  }

  @override
  void dispose() {
    gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GifImage(
                    controller: gifController,
                    height: 250,
                    image: const AssetImage("assets/gif/logo.gif"),
                  ),
                  if(!isSingIn)
                    Column(
                      children: [
                        CustomTextFormField.custom(
                            controller: _nameController,
                            hintText: 'Digite seu Nome',
                            title: 'Nome',
                            type: FormType.text,
                            isNext: true
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  CustomTextFormField.custom(
                    controller: _emailController,
                    hintText: 'Digite seu email',
                    title: 'Email',
                    type: FormType.email,
                    isNext: true
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField.custom(
                      controller: _passwordController,
                      hintText: 'Digite sua senha',
                      title: 'Senha',
                      type: FormType.pass
                  ),
                  const SizedBox(height: 16),
                  if(!isSingIn)
                    Column(
                      children: [
                        CustomTextFormField.custom(
                            controller: _cpasswordController,
                            hintText: 'Digite sua senha',
                            title: 'Confirmar Senha',
                            type: FormType.pass,
                            validator: (v){
                              if(v != _passwordController.text){
                                return 'Digite novamente sua senha';
                              }
                            }
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  CustomButtom.custom(
                    expand: true,
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        if(isSingIn){
                          await context.read<UserController>().signIn(_emailController.text, _passwordController.text).then((value) {
                            Routes.home.pushNamedAndRemoveUntil(context);
                          }).catchError((error) {
                            CustomSnackbar.error(text: 'Não foi possivel realizar login, verifique seu email e senha!', context: context);
                          });
                        }else{
                          await context.read<UserController>().signUp(_nameController.text ,_emailController.text, _passwordController.text).then((value) {
                            Routes.home.pushNamedAndRemoveUntil(context);
                          }).catchError((error) {
                            CustomSnackbar.error(text: error.toString(), context: context);
                          });
                        }
                      }
                    },
                    title: !isSingIn ? 'SignUp' : 'SignIn',
                  ),

                  TextButton(
                      onPressed: (){
                        setState(() {
                          isSingIn = !isSingIn;
                        });
                      },
                      child: Text(isSingIn ? 'SignUp' : 'SignIn')
                  ),

                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formEmailPass(){
    return Column(
      children: [

      ],
    );
  }
}
