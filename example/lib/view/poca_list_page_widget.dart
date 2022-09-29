import '../flutter_flow/flutter_flow_theme.dart';
import '../controller/poca_list_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PocaListWidget extends StatefulWidget {
  const PocaListWidget({Key? key}) : super(key: key);

  //final List<String> pocaList;

  @override
  State<PocaListWidget> createState() => _PocaListWidgetState();
}

class _PocaListWidgetState extends State<PocaListWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<OwnAlbumListInfoData> ownAlbumListInfo = [];

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
                    //(ownAlbumListInfo.isEmpty) ? Text('dddd', style: TextStyle(color: Colors.white),) : Text(ownAlbumListInfo[0].ownAlbumArtistName, style: TextStyle(color: Colors.white),)
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
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: 2,
          itemBuilder: (context, index) {
            return [
              for (int i = 0; i < ownAlbumListInfo.length; i++)
                () => pocaItem(i)
            ][index]();
          },
        ),
      ),
    );
  }

  Widget pocaItem(int listCount) {
    return InkWell(
      onTap: () async {
        debugPrint(ownAlbumListInfo[listCount].ownAlbumArtistName);
      },
      child: SizedBox(
        width: 155,
        height: 250,
        child: Column(
          children: [
            Image.network(
              ownAlbumListInfo[listCount].ownAlbumBoxImageURL,
              width: 155,
              height: 245,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
