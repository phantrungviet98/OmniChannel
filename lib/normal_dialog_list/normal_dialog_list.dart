import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:omnichannel_flutter/assets/png-jpg/PngJpg.dart';


class NormalDialogListBank extends StatefulWidget {
  final String title;
  final List<String> listData;
  final String selectedData;
  final Function onSelectedItem;

  NormalDialogListBank({
    this.title,
    @required this.listData,
    this.selectedData,
    @required this.onSelectedItem,
  });

  @override
  State<StatefulWidget> createState() {
    return _NormalDialogListState();
  }
}

class _NormalDialogListState extends State<NormalDialogListBank> {
  List<String> _listDataShow;
  String _selectedData;
  TextEditingController _searchController = new TextEditingController();
  bool _showClearText = false;
  ScrollController _scrollController = ScrollController();
  double _itemHeight = 80.0;

  @override
  void initState() {
    super.initState();
    _listDataShow = widget.listData;
    _selectedData = widget.selectedData;
    _searchController.addListener(_onChangedTextSearch); //android không gọi hàm onChanged nên phải dùng cách này
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double scrollOffset = 0.0;
      if (widget.selectedData != null && widget.listData != null && widget.listData.length > 0) {
        for (int i = 0; i < widget.listData.length; i++) {
          if (widget.selectedData == widget.listData[i]) {
            scrollOffset = i * _itemHeight;
            break;
          }
        }
      }
      _scrollController.animateTo(scrollOffset, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onWillPop() {
    return Future.value(false);
  }

  _onPressItem(String data) {
    print("chien");
    if (widget.onSelectedItem != null) {
      widget.onSelectedItem(data);
    }
    closePopup(context);
  }

  _onChangedTextSearch() {
    String text = _searchController.text;
    if ((text==null||text=="")) {
      if (_showClearText == true) {
        _showClearText = false;
      }
      _listDataShow = widget.listData;
    } else {
      if (_showClearText == false) {
        _showClearText = true;
      }
      _listDataShow = widget.listData
          .where((data) => removeDiacritics(data.trim())
          .toLowerCase()
          .contains(removeDiacritics(text.trim()).toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  Widget buildSearchData() {
    return Container(
      height: 34,
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(
              left: 10,
              bottom: 10,
              top: 0.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(3),
          ),
          suffixIconConstraints: BoxConstraints(maxWidth: 30),
          suffixIcon: _showClearText
              ? InkWell(
              onTap: () {
                Future.delayed(Duration(milliseconds: 50)).then((_) {
                  _searchController.text = '';
                  _onChangedTextSearch();
                });
              },
                child: Container(
            width: 30,
            height: 25,
            padding: EdgeInsets.all(0),
            child: Image.asset(
                PngJpg.ic_clear_text,
                width: 10,
                height: 10,
            ),

          ),
              )
              : SizedBox(),
          prefixIconConstraints: BoxConstraints(maxWidth: 30),
          prefixIcon: Container(
            width: 40,
            height: 25,
            padding: EdgeInsets.all(4),
            child: Image.asset(
              PngJpg.ic_search,
              width: 10,
              height: 10,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemData(String data) {
    bool isSelected = _selectedData != null && _selectedData == data;
    return InkWell(
      onTap: (){
        _onPressItem(data);
      },
      child: Container(
        height: _itemHeight,

        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          child: Text(
            data,
            style: TextStyle(
              fontSize:14,
              color: !isSelected ? Colors.black : Colors.blueAccent,
             fontWeight: !isSelected? FontWeight.w500: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListData() {
    return Expanded(
      flex: 1,
      child: ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        padding: const EdgeInsets.all(0.0),
        separatorBuilder: (context, index) => Divider(color: Colors.grey, thickness: 1, height: 1),
        itemCount: _listDataShow.length,
        itemBuilder: (context, index) {
          String data = _listDataShow[index];
          return buildItemData(data);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.title ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildSearchData(),
                    SizedBox(height: 10),
                    (_listDataShow != null && _listDataShow.length > 0 ? buildListData() : Container()),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap:  () => closePopup(context),
                  child: Container(

                    child: Image.asset(
                      PngJpg.ic_close,
                      width: 10,
                      height: 10,
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
