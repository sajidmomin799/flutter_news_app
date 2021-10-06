
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatefulWidget {

  final String? imageUrl;
  final double width;
  final double height;
  final Color beginColor;
  final Color endColor;

  const BackgroundImageWidget({Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.beginColor =Colors.black54,
    this.endColor = Colors.black,
  }) : super(key: key);

  @override
  _BackgroundImageWidgetState createState() => _BackgroundImageWidgetState();
}


class _BackgroundImageWidgetState extends State<BackgroundImageWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getImage();
  }

  Widget _getImage() {

    if(widget.imageUrl == null){
      return Container(
        color: Colors.black54,
        width: widget.width,
        height:widget.height,
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
          colors: [widget.beginColor, widget.endColor],
          begin: Alignment.center,
          end: Alignment.bottomCenter)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: CachedNetworkImage(
        imageUrl : widget.imageUrl!,
        width: widget.width,
        height:widget.height,
        fit: BoxFit.cover,
        errorWidget: (context, exception, stackTrace) {
          return Container(
            color: Colors.black54,
            width: widget.width,
            height:widget.height,
          );
        },
       placeholder: (context, url){
          return Container(
            color: Colors.black54,
            width: widget.width,
            height:widget.height,
          );
        },
      ),
    );
  }


}
