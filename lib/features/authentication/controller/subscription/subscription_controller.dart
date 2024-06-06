import 'package:fitness_scout/features/authentication/screen/success_screen/successScreens.dart';
import 'package:fitness_scout/utils/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find();


  /// --- VARIABLES
  late XFile? photo = null;
  final orderFormKey = GlobalKey<FormState>();

  /// Functions

  copyIban() {
    // Todo: Remove Keyboard
    FocusManager.instance.primaryFocus!.unfocus();

    // Todo: Copy Text
    Clipboard.setData(const ClipboardData(text: ZText.fitnessScoutBankIBAN));

    // Todo: Send Snackbar
    ZLoaders.successSnackBar(title: "Copied", message: "IBAN Copied");
  }


  bankScreenshotTransfer()async{
    // Capture a photo.
    final ImagePicker picker = ImagePicker();
    photo = await picker.pickImage(source: ImageSource.gallery);
  }

  submitForm(){
    /// Remove Keyboard
    FocusManager.instance.primaryFocus!.unfocus();
    /// Form Validation
    if(orderFormKey.currentState!.validate()){
      // Start Loader
      ZFullScreenLoader.openLoadingDialogy(
          'Working on your request', ZImages.fileAnimation);

      // Submit Form

      // Remove Loader
      ZFullScreenLoader.stopLoading();

      // Switch Screen

      Get.to(SuccessScreen(
        image: ZImages.successScreenAnimation,
        title: "Verification Check",
        subTitle: "Please wait. Our team will check your transaction and get approved you soon.",
        onPressed: () => Get.offAll(const NavigationMenu()),
      ),);
    }
  }

}
