import '../flutter_flow/flutter_flow_youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PocaVideoPlayWidget extends StatefulWidget {
  const PocaVideoPlayWidget({required this.youtubeID, Key? key})
      : super(key: key);

  final String youtubeID;

  @override
  State<PocaVideoPlayWidget> createState() => _PocaVideoPlayWidgetState();
}

class _PocaVideoPlayWidgetState extends State<PocaVideoPlayWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: pocaVideoPlayAppbar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              pocaYouTubeVideoPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar pocaVideoPlayAppbar() {
    return AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 8),
          child: Image.asset(
            'assets/images/logo_p.png',
            width: 100,
            height: 100,
            fit: BoxFit.none,
          ),
        ),
      ),
      centerTitle: false,
      elevation: 2,
    );
  }

  Widget pocaYouTubeVideoPlayer() {
    return FlutterFlowYoutubePlayer(
      url: widget.youtubeID,
      autoPlay: false,
      looping: true,
      mute: false,
      showControls: true,
      showFullScreen: false,
    );
  }
}
