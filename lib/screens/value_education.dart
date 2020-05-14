import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class ValueEducationScreen extends StatefulWidget {
  const ValueEducationScreen({Key key}) : super(key: key);

  @override
  _ValueEducationScreenState createState() => _ValueEducationScreenState();
}

class _ValueEducationScreenState extends State<ValueEducationScreen> {
  VideoPlayerController _playerController;
  List<String> title = [
    'Care and Compassion',
    'Honesty',
    'Understanding',
    'Tolerance',
    'Inclusion',
    'Peace and Harmony',
    'Integrity, Respect and Responsibility',
    'Hardwork and Success'
  ];
  String videoTitle;
  // bool isVideoPlaying;
  List<double> _height = [75.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0, 50.0];
  int videoIndex;
  @override
  void initState() {
    videoTitle = title.first;
    _playerController =
        VideoPlayerController.asset('assets/videos/smartschool.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _playerController.play();
            });
          });
    // for (videoIndex = 0; videoIndex < title.length; videoIndex++)
    //   _height[videoIndex] = 50.0;
    // _height[0] = 60.0;
    super.initState();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      DigiCampusAppbar(
        icon: Icons.close,
        onDrawerTapped: () {
          Navigator.of(context).pop();
        },
      ),
      Container(
        height: 250,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Center(
              child: _playerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _playerController.value.aspectRatio,
                      child: VideoPlayer(_playerController),
                    )
                  : Container(),
            ),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _playerController.value.isPlaying
                        ? _playerController.pause()
                        : _playerController.play();
                  });
                },
                child: Icon(
                  _playerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              ),
            )
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(title.length - 1, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  for (videoIndex = 0; videoIndex < title.length; videoIndex++)
                    _height[videoIndex] = 50;
                  _height[index] = 75;
                });
                _playerController.seekTo(Duration(minutes: 0));
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  height: _height[index],
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _height[index] == 75
                            ? [
                                Theme.of(context).primaryColor.withOpacity(0.2),
                                Theme.of(context).primaryColor.withOpacity(0.9),
                                Theme.of(context).primaryColor.withOpacity(0.9),
                                Theme.of(context).primaryColor.withOpacity(0.2),
                              ]
                            : [
                                Theme.of(context).primaryColor.withOpacity(0.8),
                                Theme.of(context).primaryColor.withOpacity(0.5),
                              ]),
                    // borderRadius: BorderRadius.circular(12)
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        title.elementAt(index),
                        // style: TextStyle(),
                      ))),
            );
          })),
        ),
      ),
    ]));
  }
}
