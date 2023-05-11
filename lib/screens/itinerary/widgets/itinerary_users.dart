import 'package:flutter/material.dart';

import '../../../common/api/userController.dart';
import '../../../widgets/common/spacing.dart';

class ItineraryUsers extends StatelessWidget {
  const ItineraryUsers({Key? key, required this.userList, required this.name})
      : super(key: key);
  final List<String> userList;
  final String name;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10, top: 15),
          child: Text(
            name + ' users:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        userList.length == 0
            ? Text(
                'No ' + name.toLowerCase() + ' users',
                style: TextStyle(fontSize: 12),
              )
            : Container(
                width: 0.16 * screenSize.width,
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width < 600
                          ? marginHorizontalMobile
                          : marginHorizontal,
                      child: Center(
                        child: FutureBuilder(
                          future:
                              UserController.getUserFromEmail(userList[index]),
                          builder: (ctx, futureResult) {
                            if (futureResult.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            return InkWell(
                              child: Tooltip(
                                message: futureResult.data!.userName,
                                verticalOffset: 5,
                                child: Column(
                                  children: [
                                    if (futureResult.data!.userImageUrl == null)
                                      Icon(
                                        Icons.account_circle,
                                        size: 30,
                                      )
                                    else
                                      ClipOval(
                                        child: Image.network(
                                            "http://127.0.0.1:8000${futureResult.data!.userImageUrl!}"),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
