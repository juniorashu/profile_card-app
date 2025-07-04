import 'package:flutter/material.dart';

class ProfileImageUploader extends StatelessWidget {
  final String? imageUrl;

  const ProfileImageUploader({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Show image picker here
        showModalBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
            height: 100,
            child: Center(child: Text("Choose Camera or Gallery")),
          ),
        );
      },
      child: Stack(
        children: [
          // Circle Avatar with placeholder or network image
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
            backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!)
                : const AssetImage('assets/images/profile.png'),
          ),

          // Positioned camera icon
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
