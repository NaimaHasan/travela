import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../common/api/userController.dart';
import 'edit_information_name.dart';
import 'edit_information_password.dart';

//A stateless widget for edit information screen
class EditInformationFields extends StatefulWidget {
  //Constructor
  const EditInformationFields({Key? key}) : super(key: key);

  @override
  State<EditInformationFields> createState() => _EditInformationFieldsState();
}

class _EditInformationFieldsState extends State<EditInformationFields> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Future builder for edit information field data
    //Checks the relevant conditions and displays messages on screen accordingly
    return FutureBuilder(
      future: UserController.getUser(),
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          //If waiting shows separate circular progress indicators for top part and image part
          return Column(
            children: [
              Container(
                height: 30,
              ),
              const Center(child: CircularProgressIndicator()),
              const Padding(
                padding: EdgeInsets.only(left: 35, top: 30, bottom: 30),
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
                radius: const Radius.circular(6),
                color: Colors.black38,
                dashPattern: const [8, 4],
                strokeWidth: 0.5,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  child: SizedBox(
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
            //Calls the edit information name class
            EditInformationName(data: futureResult.data!.userName),
            Container(
              height: 10,
            ),
            //Calls the edit information password class
            const EditInformationPassword(),
            const Padding(
              padding: EdgeInsets.only(left: 31, top: 30, bottom: 30),
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
            //if user does not have an image, shows the default dotted border with an icon
            //else shows the user image
            //if tapped on either of them calls setUserImage function to set a new user image
            futureResult.data!.userImageUrl == null
                ? DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(6),
                    color: Colors.black38,
                    dashPattern: const [8, 4],
                    strokeWidth: 0.5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      child: SizedBox(
                        height: 300,
                        width: 340,
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              await UserController.setUserImage();
                            },
                            icon: const Icon(Icons.add_photo_alternate_outlined),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await UserController.setUserImage();
                    },
                    child: SizedBox(
                      height: 340,
                      width: 340,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}"),
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
