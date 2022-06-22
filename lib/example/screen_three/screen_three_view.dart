import 'package:car_part/app_buttom.dart';
import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/example/screen_three/screen_three_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ThirdPage extends View {
  const ThirdPage({Key? key}) : super.model(key: key);

  @override
  ThirdPageViwe createState() => ThirdPageViwe();
}

class ThirdPageViwe extends ViewState<ThirdPage, ThirdPageViewModel> {
  ThirdPageViwe() : super(Modular.get<ThirdPageViewModel>());

  final appPref = Modular.get<AppPref>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popUntilRootButtonTapped,
                  child: Text(
                    'Pop until root',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: viewModel.popUntilHomeButtonTapped,
                  child: Text(
                    'Pop until home page',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('/billsTaps'),
                  child: const Text('Navigate to Bills'),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: () => appPref.setString(AppPref.locale, "ar"),
                  child: Text(
                    'عربي',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 32),
                AppButton(
                  onTap: () => appPref.setString(AppPref.locale, "en"),
                  child: Text(
                    'English',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('/bills'),
                  child: const Text('Navigate to Second Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
