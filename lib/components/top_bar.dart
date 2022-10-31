import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petty/models/user_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
        color: Color.fromARGB(255, 24, 16, 64),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                ),
                child: user.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.file(
                          user.image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Image.asset(
                          'assets/photo-1588421357574-87938a86fa28.jpeg',
                          fit: BoxFit.cover,
                        ),
                      )),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${DateFormat('d MMM y').format(DateTime.now())}',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Ola, ${user.name}',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
