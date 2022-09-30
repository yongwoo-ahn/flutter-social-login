import '../flutter_flow/flutter_flow_theme.dart';
import '../controller/poca_list_page_controller.dart';
import '../view/poca_video_list_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PocaListWidget extends StatefulWidget {
  const PocaListWidget({Key? key}) : super(key: key);

  @override
  State<PocaListWidget> createState() => _PocaListWidgetState();
}

class _PocaListWidgetState extends State<PocaListWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<OwnAlbumListInfoData> ownAlbumListInfo = [];

  bool loadingVisible = false;

  @override
  void initState() {
    super.initState();

    getOwnAlbumListInfo().then((value) {
      setState(() {
        ownAlbumListInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: pocaListPageAppbar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: (ownAlbumListInfo.isEmpty)
              ? loading()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    pocaListSorting(), //포카 이미지 정렬
                    pocaImageListArea(), //포카 이미지 리스트
                  ],
                ),
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.pink,
      ),
    );
  }

  AppBar pocaListPageAppbar() {
    return AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 8),
        child: Image.asset(
          'assets/images/logo_p.png',
          width: 26,
          height: 34,
          fit: BoxFit.none,
        ),
      ),
      centerTitle: false,
      elevation: 2,
    );
  }

  Widget pocaListSorting() {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0x00FFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '전체',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: const Color(0xFFC3C3C3),
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pocaImageListArea() {
    return Expanded(
      child: Stack(
        children: [
          Visibility(
            visible: loadingVisible,
            child: loading(),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemCount: ownAlbumListInfo.length,
              itemBuilder: (context, index) {
                return [
                  for (int i = 0; i < ownAlbumListInfo.length; i++)
                    () => pocaItem(i)
                ][index]();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget pocaItem(int listCount) {
    return InkWell(
      onTap: () async {
        setState(() {
          loadingVisible = true;
        });
        getNfcAlbumVideo(ownAlbumListInfo[listCount].ownAlbumUUID)
            .then((value) {
          setState(() {
            loadingVisible = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PocaVideoListPageWidget(
                      selectedNfcAlbumVidoeInfo: value)));
        });
      },
      child: Container(
        width: 155,
        height: 300,
        decoration: const BoxDecoration(
          color: Color(0x00FFFFFF),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                ownAlbumListInfo[listCount].ownAlbumBoxImageURL,
                width: 155,
                height: 245,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Text(
                ownAlbumListInfo[listCount].ownAlbumTitle,
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
