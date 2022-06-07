import 'package:car_part/app_buttom.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/example/screen_two/screen_two_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SecondPage extends View {
  const SecondPage({Key? key}) : super.model(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends ViewState<SecondPage, SecondPageViewModel> {
  _SecondPageState() : super(Modular.get<SecondPageViewModel>());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SecondPageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final state = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Second Page'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''You have pushed the button this many times ${state.count} in the previous page''',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      onTap: viewModel.thirdPageButtonTapped,
                      child: Text(
                        'Go to third page',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
