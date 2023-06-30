import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_netflix/assets.dart';
import 'package:flutter_netflix/widgets/widgets.dart';

class CustomeAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomeAppBar({super.key, this.scrollOffset = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black
          .withOpacity((scrollOffset / 1000).clamp(0, 1).toDouble()),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Responsive(
        mobile: _CustomAppBarMobile(),
        desktop: _CustomAppBarDesktop(),
      ),
    );
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: "TV Shows",
                  onTap: () => print("TV Shows"),
                ),
                _AppBarButton(
                  title: "Movies",
                  onTap: () => print("Movies"),
                ),
                _AppBarButton(
                  title: "My List",
                  onTap: () => print("My List"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  title: "Home",
                  onTap: () => print("Home"),
                ),
                _AppBarButton(
                  title: "TV Shows",
                  onTap: () => print("TV Shows"),
                ),
                _AppBarButton(
                  title: "Movies",
                  onTap: () => print("Movies"),
                ),
                _AppBarButton(
                  title: "Latest",
                  onTap: () => print("Latest"),
                ),
                _AppBarButton(
                  title: "My List",
                  onTap: () => print("My List"),
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () => print("Search"),
                  icon: const Icon(Icons.search),
                ),
                _AppBarButton(
                  title: "KIDS",
                  onTap: () => print("KIDS"),
                ),
                _AppBarButton(
                  title: "DVD",
                  onTap: () => print("DVD"),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () => print("gift"),
                  icon: const Icon(Icons.card_giftcard),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  color: Colors.white,
                  onPressed: () => print("notifications"),
                  icon: const Icon(Icons.notifications),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
