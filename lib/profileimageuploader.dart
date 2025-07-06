import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileImageUploader extends StatefulWidget {
  final String? imageUrl;

  const ProfileImageUploader({super.key, this.imageUrl});

  @override
  State<ProfileImageUploader> createState() => _ProfileImageUploaderState();
}

class _ProfileImageUploaderState extends State<ProfileImageUploader> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Show image picker here
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return SizedBox(
              height: 160,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt,
                      color: Colors.deepPurple,
                    ),
                    title: const Text('Take Photo'),
                    onTap: () {
                      Navigator.pop(context);
                      print('Camera selected'); // For now, just debug
                      // TODO: call pickImageFromCamera()
                      _pickImage(ImageSource.camera, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: Colors.deepPurple,
                    ),
                    title: const Text('Choose from Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      print('Gallery selected'); // For now, just debug
                      // TODO: call pickImageFromGallery()

                      _pickImage(ImageSource.gallery, context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Stack(
        children: [
          // Circle Avatar with placeholder or network image
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? NetworkImage(widget.imageUrl!)
                    : const AssetImage('assets/images/profile.jpg'),
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

//image_picker logic and upload trigger

Future<void> _pickImage(ImageSource source, BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);

    // Proceed to upload
    await _uploadToCloudinary(imageFile, context);
  } else {
    // User canceled
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No image selected.')));
    }
    Navigator.of(context).pop();
  }
}
Future<void> _uploadToCloudinary(File imageFile, BuildContext context) async {
  const cloudName = 'dmtialpjh';
  const uploadPreset = 'flutter_unsigned';

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

  try {
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final result = jsonDecode(responseBody);
      final imageUrl = result['secure_url'];

      // ✅ Save to Firebase Firestore
      await FirebaseFirestore.instance.collection('images').add({
        'url': imageUrl,
        'uploaded_at': Timestamp.now(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Image uploaded and saved!')),
        );
      }

    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Upload failed: ${response.statusCode}')),
        );
      }
    }
  } catch (e) {
    print('Exception: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error during upload.')),
      );
    }
  }
}


//code to display images after upload

class ProfileImageViewer extends StatelessWidget {
  final String? imageUrl; // The last uploaded image

  const ProfileImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Column(
          children: [
            const Text('Your Profile Picture:'),
            const SizedBox(height: 10),
            ClipOval(
              child: Image.network(
                imageUrl!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            ),
          ],
        )
        : const Text('No profile picture uploaded yet.');
  }
}

//uploaded images pages which displays all images uploaded


class UploadedImagesPage extends StatelessWidget {
  const UploadedImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Uploaded Images')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('images').orderBy('uploaded_at', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text('No images uploaded yet.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final imageUrl = docs[index]['url'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(imageUrl),
              );
            },
          );
        },
      ),
    );
  }
}
