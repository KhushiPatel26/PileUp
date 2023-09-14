import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class noteView extends StatefulWidget {
  const noteView({Key? key}) : super(key: key);

  @override
  State<noteView> createState() => _noteViewState();
}

class _noteViewState extends State<noteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Stateful Widget Example'),
    ),
    body: Container(
    child: masonryLayout(context),
    ));
  }
//...
  Widget masonryLayout(BuildContext context) {
    return MasonryGridView.builder(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 8,
      mainAxisSpacing: 6,
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network("https://source.unsplash.com/random?sig=$index"),
        );
      },
    );
  }

  Widget alignedLayout(BuildContext context) {
    return AlignedGridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      mainAxisSpacing: 6,
      crossAxisSpacing: 8,
      itemCount: 20,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network("https://source.unsplash.com/random?sig=$index",
              fit: BoxFit.cover),
        );
      },
    );

  }

  Widget quiltedLayout(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
              (context, index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:  Image.network("https://source.unsplash.com/random?sig=$index",
                  fit: BoxFit.cover),
            );
          }

      ),
    );
  }

  Widget stairedLayout(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 24,
        mainAxisSpacing: 12,
        startCrossAxisDirectionReversed: true,
        pattern: [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:  Image.network("https://source.unsplash.com/random?sig=$index",
                fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
