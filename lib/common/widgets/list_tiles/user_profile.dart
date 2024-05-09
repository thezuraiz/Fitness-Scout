import 'package:fitness_scout/common/widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/image_string.dart';

class ZUserProfileTile extends StatelessWidget {
  const ZUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ZCircularImage(
        image: ZImages.userProfile,
        height: 50,
        width: 50,
        padding: 0,
      ),
      title: Text(
        "Coding With Z",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.white),
      ),
      subtitle: Text(
        "support@codingwithZ.com",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
      trailing: IconButton(
        icon: const Icon(Iconsax.edit,color: Colors.white,),
        onPressed: onPressed,
      ),
    );
  }
}