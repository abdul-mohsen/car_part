import 'package:car_part/app_buttom.dart';
import 'package:car_part/common/ui/View.dart';
import 'package:car_part/example/screen_two/screen_two_view_model.dart';
import 'package:flutter/material.dart';

class SecondPage extends View<SecondPageViewModel> {
  const SecondPage({required SecondPageViewModel viewModel, Key? key})
      : super.model(viewModel, key: key);

  @override
  _SecondPageState createState() => _SecondPageState(viewModel);
}

class _SecondPageState extends ViewState<SecondPage, SecondPageViewModel> {
  _SecondPageState(SecondPageViewModel viewModel) : super(viewModel);

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
