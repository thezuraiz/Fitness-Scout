import 'package:fitness_scout/common/styles/AppbarPadding.dart';
import 'package:fitness_scout/common/widgets/formDivider.dart';
import 'package:fitness_scout/common/widgets/socialButtons.dart';
import 'package:fitness_scout/features/authentication/screen/login_screen/widgets/login_screen_widgets.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ZAppbarPadding.appbarPadding,
          child: Column(
            children: [
              // Todo: Header -> Logo,title, subTitle
              LoginScreenHeader(),

              // Todo: Form
              LoginScreenFormField(),

              // TODO: Divider
              ZFormDivider(
                dividerText: ZText.orSignUpWith,
              ),

              SizedBox(
                height: ZSizes.spaceBtwSections,
              ),

              // TODO: Footer
              ZSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}