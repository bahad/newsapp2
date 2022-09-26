// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AnimatedFab extends StatefulWidget {
  final VoidCallback? onPressedShare;
  final VoidCallback? onPressedComment;
  final VoidCallback? onPressedAddFavorites;
  final String? tooltip;
  final IconData? icon;

  const AnimatedFab(
      {super.key,
      this.onPressedShare,
      this.onPressedComment,
      this.onPressedAddFavorites,
      this.tooltip,
      this.icon});

  @override
  _AnimatedFabState createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget commentFab() {
    return SizedBox(
      child: FloatingActionButton(
        heroTag: 'detail1',
        onPressed: widget.onPressedComment,
        tooltip: 'Yorum',
        backgroundColor: Colors.white,
        child: const Icon(Icons.comment, color: Colors.black),
      ),
    );
  }

  Widget shareFab() {
    return SizedBox(
      child: FloatingActionButton(
        heroTag: 'detail2',
        onPressed: widget.onPressedShare,
        tooltip: 'Paylaş',
        backgroundColor: Colors.white,
        child: const Icon(Icons.share, color: Colors.black),
      ),
    );
  }

  Widget favoritesFab() {
    return SizedBox(
      child: FloatingActionButton(
        heroTag: 'detail3',
        onPressed: widget.onPressedAddFavorites,
        tooltip: 'Favorilere Ekle',
        backgroundColor: Colors.white,
        child: const Icon(Icons.favorite_border, color: Colors.black),
      ),
    );
  }

  Widget toggle() {
    return SizedBox(
      child: FloatingActionButton(
        heroTag: 'detail4',
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Fab',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: commentFab(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: shareFab(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: favoritesFab(),
        ),
        toggle(),
      ],
    );
  }
}
