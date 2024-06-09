import 'package:fitness_scout/features/personalization/screen/packages/package_detail_page.dart';
import 'package:fitness_scout/utils/constants/image_string.dart';
import 'package:get/get.dart';

class PackageDetailController extends GetxController {
  static PackageDetailController get instance => Get.find();

  basicPlan() {
    Get.to(
      () => const PackageDetailPage(
        title: 'Basic Package',
        price: 'Rs-/ 2,000',
        illustration: ZImages.basic_plain_illustration,
        description: '''
  ## Features:
  - **Unlimited Gym Access**: Enjoy full access to all gym equipment and basic amenities anytime.
  - **Group Fitness Classes**: Join any of our energizing group fitness classes like yoga, Zumba, and spin.
  - **Locker Room Access**: Convenient locker rooms with showers for your use.

  ## Pricing:
  - **Monthly**: Rs-/ 2,000
  - **Annual**: Rs-/ 2,000

  ## Additional Benefits:
  - **Welcome Kit**: Kickstart your journey with a complimentary water bottle and gym bag.
  ''',
      ),
    );
  }

  silverPlan() {
    Get.to(
      () => const PackageDetailPage(
        title: 'Silver Package',
        price: 'Rs-/ 4,000',
        illustration: ZImages.medium_plain_illustration,
        description: '''
  ## Features:
- **Unlimited Gym Access**: Enjoy full access to all gym equipment and basic amenities anytime.
- **Group Fitness Classes**: Join any of our energizing group fitness classes like yoga, Zumba, and spin.
- **Locker Room Access**: Convenient locker rooms with showers for your use.
- **Personal Training Sessions**: Four 30-minute sessions with a certified personal trainer per month.
- **Advanced Fitness Classes**: Access to specialized classes (e.g., HIIT, pilates, advanced strength training).
- **Nutritional Guidance**: Monthly consultation with a nutritionist.

## Pricing:
- **Monthly**: Rs-/ 3,000

## Additional Benefits:
- **Premium App Content**: Access to premium video content and workout plans on the app.
- **Priority Booking**: Early access to class bookings and events.
  ''',
      ),
    );
  }

  premiumPlan() {
    Get.to(
      () => const PackageDetailPage(
        title: 'Diamond Package',
        price: 'Rs-/ 6,000',
        illustration: ZImages.premium_plain_illustration,
        description: '''
  ## Features:
- **Unlimited Gym Access**: Enjoy full access to all gym equipment and basic amenities anytime.
- **Group Fitness Classes**: Join any of our energizing group fitness classes like yoga, Zumba, and spin.
- **Locker Room Access**: Convenient locker rooms with showers for your use.
- **Personal Training Sessions**: Four 30-minute sessions with a certified personal trainer per month.
- **Advanced Fitness Classes**: Access to specialized classes (e.g., HIIT, pilates, advanced strength training).
- **Nutritional Guidance**: Monthly consultation with a nutritionist.

## Pricing:
- **Monthly**: Rs-/ 6,000

## Additional Benefits:
- **Premium App Content**: Access to premium video content and workout plans on the app.
- **Priority Booking**: Early access to class bookings and events.\n\n\n
  ''',
      ),
    );
  }
}
