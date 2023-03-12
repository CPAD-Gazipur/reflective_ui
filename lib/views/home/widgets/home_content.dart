import 'package:flutter/material.dart';
import 'package:reflective_ui/data/data.dart';
import 'package:reflective_ui/views/views.dart';

class HomeContent extends StatefulWidget {
  final Function onThemeChange;

  const HomeContent({
    Key? key,
    required this.onThemeChange,
  }) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Contacts',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 36.0,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              widget.onThemeChange();
                              setState(() {});
                            },
                            child: Icon(
                              Theme.of(context).brightness == Brightness.light
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: userDetails.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 24);
                        },
                        itemBuilder: (context, index) {
                          return UserListTile(
                            user: userDetails[index],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Opacity(
                    opacity: 0.4,
                    child: Icon(
                      Icons.house_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: Icon(
                      Icons.chat_bubble_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Opacity(
                    opacity: 1,
                    child: Icon(
                      Icons.people_alt_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
