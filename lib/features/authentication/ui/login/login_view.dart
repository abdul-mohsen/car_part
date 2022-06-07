import 'package:car_part/common/ui/loading_dailog.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/common/widget/edit_text.dart';
import 'package:car_part/features/authentication/ui/login/data/model/login_view_state.dart';
import 'package:car_part/features/authentication/ui/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginView extends View {
  const LoginView({Key? key}) : super.model(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ViewState<LoginView, LoginViewModel> {
  _LoginState() : super(Modular.get<LoginViewModel>());

  bool _isButtonEnable = false;

  @override
  void initState() {
    super.initState();
    viewModel.viewState.listen((event) {
      bool? showloading = event.loading.getContentIfNotHandled();
      if (showloading == true) {
        LoadingScreen().show(
          context: context,
          text: 'Please wait a moment',
        );
      } else if (showloading == false) {
        LoadingScreen().hide();
      }
      _isButtonEnable = event.enableLoginButton;
      if (event.navigate.getContentIfNotHandled() == true) {
        Modular.to.navigate("/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: const Text("login"),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Wrap(
                    direction: Axis.vertical,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      getEditText(
                          label: "Enter Username",
                          onTextChange: viewModel.updateUsername,
                          width: 250),
                      getEditText(
                          label: "Enter Password",
                          onTextChange: viewModel.updatePassword,
                          width: 250),
                      ElevatedButton(
                          onPressed: () => _isButtonEnable
                              ? viewModel.onLoginPressed()
                              : null,
                          child: const Text("Login"))
                    ]),
              ),
            ))));
  }
}
