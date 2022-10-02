import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("HOME BUILD");
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                ImagePicker picker = ImagePicker();
                picker.pickImage(source: ImageSource.gallery);
              },
              child: Text("Flutter Image Picker")),
          ElevatedButton(
              onPressed: () async {
                var result = await MethodChannel("test").invokeMethod("test");
              },
              child: Text("My Image Picker")),
        ],
      ),
    );
  }
}
