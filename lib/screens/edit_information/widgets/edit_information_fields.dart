import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../common/api/userController.dart';
import 'edit_information_name.dart';
import 'edit_information_password.dart';
import 'package:image_picker/image_picker.dart';

class EditInformationFields extends StatefulWidget {
  const EditInformationFields({Key? key}) : super(key: key);

  @override
  State<EditInformationFields> createState() => _EditInformationFieldsState();
}

class _EditInformationFieldsState extends State<EditInformationFields> {
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserController.getUser(),
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Container(
                height: 30,
              ),
              CircularProgressIndicator(),
              const Padding(
                padding:
                EdgeInsets.only(left: 35, top: 30, bottom: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(6),
                color: Colors.black38,
                dashPattern: [8, 4],
                strokeWidth: 0.5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: Container(
                    height: 300,
                    width: 340,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Container(
              height: 30,
            ),
            EditInformationName(data: futureResult.data!.userName),
            Container(
              height: 10,
            ),
            EditInformationPassword(),
            const Padding(
              padding:
              EdgeInsets.only(left: 31, top: 30, bottom: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(6),
              color: Colors.black38,
              dashPattern: [8, 4],
              strokeWidth: 0.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                child: Container(
                  height: 300,
                  width: 340,
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        await UserController.setUserImage();
                      },
                      icon: Icon(
                          Icons.add_photo_alternate_outlined
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
