import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_netflix/widgets/widgets.dart';

import '../models/content_model.dart';

class CustomHeader extends StatelessWidget {
  final Content featuredContent;
  const CustomHeader({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _CustomHeaderMobile(
        featuredContent: featuredContent,
      ),
      desktop: _CustomHeaderDesktop(
        featuredContent: featuredContent,
      ),
    );
  }
}

class _CustomHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _CustomHeaderMobile({super.key, required this.featuredContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -1.0,
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
        ),
        Positioned(
          bottom: 110,
          width: 250,
          child: Image.asset(featuredContent.titleImageUrl!),
        ),
        Positioned(
            left: 0,
            bottom: 40,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: "List",
                  onTap: () => print("My List"),
                ),
                _PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: "Info",
                  onTap: () => print("Info"),
                ),
              ],
            ))
      ],
    );
  }
}

class _CustomHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _CustomHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_CustomHeaderDesktop> createState() => _CustomHeaderDesktopState();
}

class _CustomHeaderDesktopState extends State<_CustomHeaderDesktop> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: _videoPlayerController.value.isInitialized
                  ? VideoPlayer(_videoPlayerController)
                  : Image.asset(
                      widget.featuredContent.imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(widget.featuredContent.titleImageUrl!),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(width: 16.0),
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0)),
                      ),
                      onPressed: () => print('More Info'),
                      icon: const Icon(Icons.info_outline, size: 30.0),
                      label: const Text(
                        'More Info',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        icon: Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
          padding: !Responsive.isDesktop(context)
              ? MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0))
              : MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () => print("Play"),
        icon: const Icon(
          Icons.play_arrow,
          size: 26,
        ),
        label: const Text(
          "Play",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ));
  }
}
