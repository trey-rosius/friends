
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends/posts/create_post.dart';

import 'package:friends/utils/app_theme.dart';




class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconName, required this.text});
  String iconName;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    required this.items,
    required  this.centerItemText,
     this.height: 60.0,
     this.iconSize: 24.0,
    required this.color,
    required this.selectedColor,

    required this.onTabSelected,
    required this.userId,

  }) {
  //  assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;

  final Color color;
  final Color selectedColor;

  final ValueChanged<int> onTabSelected;
  final String userId;



  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;


  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
    elevation: 0.0,
      color: Colors.black,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),

    );
  }

  Widget _buildMiddleTabItem() {
    return
      Expanded(
        child: InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return  CreatePostScreen( userId: widget.userId,);
            }));
          },
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 60,
                    width: 60,

                  padding:EdgeInsets.all(20),

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [ThemeColor.primary, ThemeColor.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),

                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/add.svg',

                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: Colors.white,

                  ),
                ),

              ],
            ),
          ),
        ),

    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[




                    Container(
                      height: 30,
                      width: 30,


                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment:Alignment.center,
                            child: SvgPicture.asset(
                              item!.iconName,

                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                              color: color,

                            ),
                          ),



                        ],
                      ),
                    ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}