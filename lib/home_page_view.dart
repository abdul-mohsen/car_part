import 'package:car_part/app_buttom.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends View {
  const HomePage({Key? key}) : super.model(key: key);

  @override
  HomePageView createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomePageViewModel> {
  HomePageView() : super(Modular.get<HomePageViewModel>());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HomePageState>(
      stream: viewModel.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        final state = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '${state.count}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          isEnabled: state.isMinusEnabled,
                          onTap: viewModel.minusButtonTapped,
                          child: Text(
                            '-',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 32),
                        AppButton(
                          isEnabled: state.isPlusEnabled,
                          onTap: viewModel.plusButtonTapped,
                          child: Text(
                            '+',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      onTap: viewModel.secondPageButtonTapped,
                      child: Text(
                        'Go to second page',
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
