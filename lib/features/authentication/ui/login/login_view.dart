import 'package:car_part/common/routing/route.dart';
import 'package:car_part/common/ui/loading_dailog.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/common/widget/edit_text.dart';
import 'package:car_part/features/authentication/ui/login/data/model/login_view_state.dart';
import 'package:car_part/features/authentication/ui/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginView extends View<LoginViewModel> {
  const LoginView({required LoginViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

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
        viewModel.addToNavigation(
          const AppRouteSpec(
            name: '/second',
            arguments: {
              'count': -1,
            },
          ),
        );
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
                      getEditText("Enter Username", viewModel.updateUsername),
                      getEditText("Enter Password", viewModel.updatePassword),
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
