import 'package:flutter/material.dart';

///A dialog with a picture at the top (used for logging into another user)
class ImageDialog extends StatelessWidget {
  ///The title of the dialog
  final String title,

      ///the small text underneath the title
      description,

      ///the text you press to confirm the dialog
      confirmText,

      ///the text you press to cancel the dialog
      cancelText;

  ///the image to be displayed on the top
  final FileImage image;

  ///the code to run every time the confirm button is pressed
  final VoidCallback buttonClicked;

  ImageDialog({
    @required this.title,
    @required this.description,
    this.confirmText,
    this.cancelText,
    this.image,
    this.buttonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  static const double padding = 16;
  static const double avatarRadius = 66.0;

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: avatarRadius + padding,
            bottom: padding,
            left: padding,
            right: padding,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              title != null
                  ? Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Container(),
              title != null ? SizedBox(height: padding) : Container(),
              description != null
                  ? Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: padding,
                      ),
                    )
                  : Container(),
              description != null ? SizedBox(height: 24.0) : Container(),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(cancelText ?? "Cancel"),
                    ),
                    FlatButton(
                      onPressed: () {
                        buttonClicked();
                      },
                      child: Text(confirmText ?? "OK"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding * 7,
          right: padding * 7,
          top: padding,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
              image: image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: image,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
