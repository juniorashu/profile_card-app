import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:profile_card_app/profileimageuploader.dart';



Future <void> main() async   {
   
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {


  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Card'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ProfileImageUploader(),
            const SizedBox(height: 10),
            Text(
              "cloud name ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 216, 255),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.circle, color: Colors.green, size: 12),
                  SizedBox(width: 6),
                  Text(
                    'open to work',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 400,
              child: Text(
                'Passionate about creating beautiful and functional user interfaces with Flutter. Experienced in building responsive and scalable applications for both iOS and Android platforms.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(), // 👈 soft black shadow
                    blurRadius: 3, // 👈 how blurry the shadow is
                    offset: Offset(0, 0), // 👈 shadow appears 4px below
                  ),
                ],
              ),

              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const Text(
                        '4+',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const Text(
                        'Year Exp',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        '23',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const Text(
                        'Project',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        '19',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const Text(
                        'client',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ContactInformation(
                  icon: Icons.email,
                  label: 'Email:',
                  text: 'juniorashu36@gmail.com',
                  licon: Icons.copy,
                ),
                const SizedBox(height: 20),
                ContactInformation(
                  icon: Icons.call,
                  label: 'Phone',
                  text: '+237 658707773',
                  licon: Icons.copy,
                ),
                const SizedBox(height: 20),
                ContactInformation(
                  icon: Icons.linked_camera,
                  label: 'LinkedIn:',
                  text: 'https://www.linkedin.com/in/david-mitchel-123456789/',
                  licon: Icons.link,
                ),
                const SizedBox(height: 20),
                ContactInformation(
                  icon: Icons.gite,
                  label: 'GitHub:',
                  text: 'juniorashu36',
                  licon: Icons.link,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Skills',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const SKILLS(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple, // Background color
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ), // Border
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ), // White for contrast
                          SizedBox(width: 8), // Spacing between icon and text
                          Text(
                            'Download CV',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20), // Spacing between buttons
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.deepPurple, // Background color
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ), // Border
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ), // White for contrast
                          SizedBox(width: 8), // Spacing between icon and text
                          Text(
                            'Share Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Spacing between buttons
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  final IconData licon;
  const ContactInformation({
    super.key,
    required this.icon,
    required this.label,
    required this.text,
    required this.licon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,

      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(), // 👈 soft black shadow
            blurRadius: 3, // 👈 how blurry the shadow is
            offset: Offset(0, 0), // 👈 shadow appears 4px below
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(icon, color: Colors.deepPurple),
              ),

              SizedBox(width: 10),

              /// Make this part responsive:
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      text,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8), // Add spacing before trailing icon
              Icon(licon, color: Colors.deepPurple, size: 17),
            ],
          ),
        ],
      ),
    );
  }
}

class SKILLS extends StatelessWidget {
  const SKILLS({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,

      child: Column(
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              skillChip('Flutter'),
              skillChip('Dart'),
              skillChip('Firebase'),
              skillChip('REST APIs'),
              skillChip('Git'),
              skillChip('Bloc'),
              skillChip('Provider'),
              skillChip('mongoDB'),
              skillChip('PostgreSQL'),
              skillChip('SQLite'),
            ],
          ),
        ],
      ),
    );
  }
}

Chip skillChip(String label) {
  return Chip(
    label: Text(label, style: TextStyle(color: Colors.deepPurple)),
    backgroundColor: const Color.fromRGBO(128, 0, 128, 0.1),
    shape: const StadiumBorder(side: BorderSide(color: Colors.purple)),
  );
}
