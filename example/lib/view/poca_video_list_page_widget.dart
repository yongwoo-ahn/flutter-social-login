import '../flutter_flow/flutter_flow_theme.dart';
import '../controller/poca_list_page_controller.dart';
import '../view/poca_video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PocaVideoListPageWidget extends StatefulWidget {
  const PocaVideoListPageWidget(
      {required this.selectedNfcAlbumVidoeInfo, Key? key})
      : super(key: key);

  final List<NfcAlbumVideo> selectedNfcAlbumVidoeInfo;

  @override
  State<PocaVideoListPageWidget> createState() =>
      _PocaVideoListPageWidgetState();
}

class _PocaVideoListPageWidgetState extends State<PocaVideoListPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: pocaVideoListPageAppbar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                pocaVideoListArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar pocaVideoListPageAppbar() {
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

  Widget pocaVideoListArea() {
    return Expanded(
      child: MasonryGridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: widget.selectedNfcAlbumVidoeInfo.length,
        itemBuilder: (context, index) {
          return [
            for (int i = 0; i < widget.selectedNfcAlbumVidoeInfo.length; i++)
              () => pocaVideoItem(i)
          ][index]();
        },
      ),
    );
  }

  Widget pocaVideoItem(int listCount) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PocaVideoPlayWidget(
                      youtubeID:
                          widget.selectedNfcAlbumVidoeInfo[listCount].youtubeID,
                    )));
      },
      child: Container(
        width: 360,
        height: 74,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              widget.selectedNfcAlbumVidoeInfo[listCount].youtubeThumbnailURL,
              width: 132,
              height: 74,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: SizedBox(
                    width: 176,
                    height: 36,
                    child: Text(
                      widget.selectedNfcAlbumVidoeInfo[listCount].youtubeTitle,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
