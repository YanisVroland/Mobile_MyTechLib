/*
  This file contains a custom icon button widget with various customization options.
*/

import 'package:flutter/material.dart';

class IconCustom extends StatefulWidget {
  const IconCustom({
    Key? key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.hoverColor,
    this.hoverIconColor,
    this.onPressed,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? hoverColor;
  final Color? hoverIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;

  @override
  State<IconCustom> createState() => _IconCustomState();
}

class _IconCustomState extends State<IconCustom> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;
  late Widget effectiveIcon;

  @override
  void initState() {
    super.initState();
    _updateIcon();
  }

  @override
  void didUpdateWidget(IconCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateIcon();
  }

  void _updateIcon() {
    // Determine whether the provided icon is a FontAwesome icon or a regular icon
    // if (widget.icon is FaIcon) {
    //   FaIcon icon = widget.icon as FaIcon;
    //   effectiveIcon = FaIcon(
    //     icon.icon,
    //     size: icon.size,
    //   );
    //   iconSize = icon.size;
    //   iconColor = icon.color;
    // } else {
    Icon icon = widget.icon as Icon;
    effectiveIcon = Icon(
      icon.icon,
      size: icon.size,
    );
    iconSize = icon.size;
    iconColor = icon.color;
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Define button style based on different states
    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
            (states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0,
            ),
          );
        },
      ),
      iconColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.disabledIconColor != null) {
            return widget.disabledIconColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.hoverIconColor != null) {
            return widget.hoverIconColor;
          }
          return iconColor;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.disabledColor != null) {
            return widget.disabledColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.hoverColor != null) {
            return widget.hoverColor;
          }
          return widget.fillColor;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return null;
        }
        return widget.hoverColor == null ? null : Colors.transparent;
      }),
    );

    // Build the icon button widget
    return SizedBox(
      width: widget.buttonSize,
      height: widget.buttonSize,
      child: Theme(
        data: Theme.of(context).copyWith(useMaterial3: true),
        child: IgnorePointer(
          ignoring: (widget.showLoadingIndicator && loading),
          child: IconButton(
            icon: (widget.showLoadingIndicator && loading)
                ? Container(
              width: iconSize,
              height: iconSize,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  iconColor ?? Colors.white,
                ),
              ),
            )
                : effectiveIcon,
            onPressed: widget.onPressed == null
                ? null
                : () async {
              if (loading) {
                return;
              }
              setState(() => loading = true);
              try {
                await widget.onPressed!();
              } finally {
                if (mounted) {
                  setState(() => loading = false);
                }
              }
            },
            splashRadius: widget.buttonSize,
            style: style,
          ),
        ),
      ),
    );
  }
}
