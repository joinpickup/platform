import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      endDrawer: const Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // feed
              Column(
                // header bar
                children: [
                  Row(
                    children: [
                      // title
                      Text(
                        "Following",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      const Spacer(),
                      // button
                      const NewBoardButton(),
                    ],
                  ),
                ],
              ),
              // search bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(-1, 1),
                        blurRadius: 8,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // left button
                      SearchBarButton(
                        icon: Icons.menu,
                        click: (context) {
                          Scaffold.of(context).openDrawer();
                        },
                      ),

                      // search bar
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Search...",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),

                      // right button
                      SearchBarButton(
                        icon: Icons.person,
                        click: (context) {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewBoardButton extends StatelessWidget {
  const NewBoardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-1, 1),
            blurRadius: 8,
            color: Colors.black,
          ),
        ],
      ),
      child: Text(
        "New Board",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class SearchBarButton extends StatelessWidget {
  const SearchBarButton({
    super.key,
    required this.icon,
    required this.click,
  });

  final IconData icon;
  final Function click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click(context);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
              offset: Offset(-1, 1),
              blurRadius: 8,
              color: Colors.black,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
