import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';

class SuperSlider extends StatefulWidget {
  SuperSlider({
    @required this.items,
    this.height,
    this.aspectRatio: 16 / 9,
    this.viewportFraction: 1.5,
    this.initialPage: 0,
    int realPage: 10000,
    this.enableInfiniteScroll: true,
    this.reverse: false,
    this.autoPlay: false,
    this.autoPlayInterval: const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve: Curves.fastOutSlowIn,
    this.pauseAutoPlayOnTouch,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.scrollDirection: Axis.horizontal,
    this.compact: false,
    this.circlePagination: true,
    this.rectanglePaginationFactor = 5.0,
    this.expand: false,
    this.fullwidth: false,
    this.selectedColor: Colors.grey,
    this.unselectedColor: const Color(0xffe2e2e2),
    this.selectedColorDark: Colors.grey,
    this.unselectedColorDark: const Color(0xff535353),
    this.roundedBorders: 0.0,
    this.paginationHeight = 30.0,
    this.paginationHeightCompact = 20.0,
    this.paginationSize = 10.0,
    this.paginationColorMode,
    this.paginationTopOnly = false,
    this.keys,
  })  : this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
        this.pageController = PageController(
          viewportFraction: viewportFraction,
          initialPage: enableInfiniteScroll ? realPage + initialPage : initialPage,
        );

  ///Test keys
  final List<Key> keys;

  ///Whether to split the pagination height padding to both top and bottom or just top
  final bool paginationTopOnly;

  ///whether to round the borders where the items are clipped.
  final double roundedBorders;

  ///Whether or not to take the maximum available space
  final bool expand;

  ///enable disable compact mode (reduces the distance between the dots on the bottom and the slider).
  final bool compact;

  ///should the slider take the width of the screen?
  final bool fullwidth;

  /// The widgets to be shown in the carousel.
  final List<Widget> items;

  /// Set carousel height and overrides any existing [aspectRatio].
  final double height;

  ///whether to use rectangular or circular pagination
  final bool circlePagination;

  ///how much wider the width of the rectangular pagination needs to be (doesn't affect circle pagination)
  final double rectanglePaginationFactor;

  /// Aspect ratio is used if no height have been declared.
  ///
  /// Defaults to 16:9 aspect ratio.
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final num viewportFraction;

  /// The initial page to show when first creating the [SuperSlider].
  ///
  /// Defaults to 0.
  final num initialPage;

  /// The actual index of the [PageView].
  ///
  /// This value can be ignored unless you know the carousel will be scrolled
  /// backwards more then 10000 pages.
  /// Defaults to 10000 to simulate infinite backwards scrolling.
  final num realPage;

  ///Determines if carousel should loop infinitely or be limited to item length.
  ///
  ///Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Reverse the order of items if set to true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve autoPlayCurve;

  /// Sets a timer on touch detected that pause the auto play with
  /// the given [Duration].
  ///
  /// Touch Detection is only active if [autoPlay] is true.
  final Duration pauseAutoPlayOnTouch;

  /// Determines if current page should be larger then the side images,
  /// creating a feeling of depth in the carousel.
  ///
  /// Defaults to false.
  final bool enlargeCenterPage;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Called whenever the page in the center of the viewport changes.
  final Function(int index) onPageChanged;

  /// [pageController] is created using the properties passed to the constructor
  /// and can be used to control the [PageView] it is passed to.
  final PageController pageController;

  ///the distance between the bottom circles and the actual slider.
  final double paginationHeight;
  final double paginationHeightCompact;

  ///the size of the pagination circles (the height of the rectangle if [circlePagination] is false).
  final double paginationSize;

  ///whether the active slider in the pagination should be darker or brighter than the rest (and the general colors of
  ///the circles).
  final Brightness paginationColorMode;

  ///pagination colors
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedColorDark;
  final Color unselectedColorDark;

  /// Animates the controlled [SuperSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> nextPage({Duration duration, Curve curve}) {
    return pageController.nextPage(duration: duration, curve: curve);
  }

  /// Animates the controlled [SuperSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> previousPage({Duration duration, Curve curve}) {
    return pageController.previousPage(duration: duration, curve: curve);
  }

  /// Changes which page is displayed in the controlled [SuperSlider].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  void jumpToPage(int page) {
    final index = _getRealIndex(pageController.page.toInt(), realPage, items.length);
    return pageController.jumpToPage(pageController.page.toInt() + page - index);
  }

  /// Animates the controlled [SuperSlider] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> animateToPage(int page, {Duration duration, Curve curve}) {
    final index = _getRealIndex(pageController.page.toInt(), realPage, items.length);
    return pageController.animateToPage(pageController.page.toInt() + page - index, duration: duration, curve: curve);
  }

  @override
  _SuperSliderState createState() => _SuperSliderState();
}

class _SuperSliderState extends State<SuperSlider> with TickerProviderStateMixin {
  Timer timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    timer = getTimer();
  }

  Timer getTimer() {
    return Timer.periodic(widget.autoPlayInterval, (_) {
      if (widget.autoPlay) {
        widget.pageController.nextPage(duration: widget.autoPlayAnimationDuration, curve: widget.autoPlayCurve);
      }
    });
  }

  void pauseOnTouch() {
    timer.cancel();
    timer = Timer(widget.pauseAutoPlayOnTouch, () {
      timer = getTimer();
    });
  }

  Widget getWrapper(Widget child) {
    if (widget.height != null) {
      final Widget wrapper = Container(
          key: widget.keys != null ? widget.keys[0] : null,
          height: widget.height - (widget.compact ? widget.paginationHeightCompact : widget.paginationHeight),
          child: widget.roundedBorders != 0.0
              ? ClipRRect(
                  key: widget.keys != null ? widget.keys[1] : null,
                  borderRadius: BorderRadius.circular(widget.roundedBorders),
                  child: child,
                )
              : child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    } else {
      final Widget wrapper = AspectRatio(aspectRatio: widget.aspectRatio, child: child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    }
  }

  Widget addGestureDetection(Widget child) => GestureDetector(
        onPanDown: (_) => pauseOnTouch(),
        child: child,
        key: widget.keys != null ? widget.keys[2] : null,
      );

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.keys != null ? widget.keys[3] : null,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        getWrapper(
          PageView.builder(
            scrollDirection: widget.scrollDirection,
            controller: widget.pageController,
            reverse: widget.reverse,
            itemCount: widget.enableInfiniteScroll ? null : widget.items.length,
            onPageChanged: (int index) {
              int currentPage = _getRealIndex(index, widget.realPage, widget.items.length);
              if (widget.onPageChanged != null) {
                widget.onPageChanged(currentPage);
              }
              setState(() {
                _currentIndex = currentPage;
              });
            },
            itemBuilder: (BuildContext context, int i) {
              ///
              /// prevent divideByZeroException in [_remainder] method.
              ///
              if (widget.items.isEmpty) {
                return Container(
                  key: widget.keys != null ? widget.keys[4] : null,
                );
              }

              final int index = _getRealIndex(i + widget.initialPage, widget.realPage, widget.items.length);
              return AnimatedBuilder(
                animation: widget.pageController,
                child: widget.items[index],
                builder: (BuildContext context, child) {
                  // on the first render, the pageController.page is null,
                  // this is a dirty hack
                  if (widget.pageController.position.minScrollExtent == null ||
                      widget.pageController.position.maxScrollExtent == null) {
                    Future.delayed(Duration(microseconds: 1), () {
                      setState(() {});
                    });
                    return Container();
                  }
                  double value = widget.pageController.page - i;
                  value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);

                  final double height = widget.height != null
                      ? widget.height - (widget.compact ? 20.0 : 30.0)
                      : MediaQuery.of(context).size.width * (1 / widget.aspectRatio);
                  final double distortionValue = widget.enlargeCenterPage ? Curves.easeOut.transform(value) : 1.0;

                  if (widget.scrollDirection == Axis.horizontal) {
                    return Center(
                        child: !widget.expand
                            ? widget.fullwidth
                                ? SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: widget.compact ? (distortionValue * height) : (distortionValue * height),
                                    child: child)
                                : SizedBox(
                                    height: widget.compact ? (distortionValue * height) : (distortionValue * height),
                                    child: child)
                            : Container(
                                child: child,
                              ));
                  } else {
                    return Center(
                        child: SizedBox(width: distortionValue * MediaQuery.of(context).size.width, child: child));
                  }
                },
              );
            },
          ),
        ),
        _sliderPagination(),
      ],
    );
  }

  Widget _sliderPagination() {
    return getSliderPagination(_currentIndex, widget.items.length);
  }

  Widget getSliderPagination(int currentIndex, int length) {
    return Padding(
      key: widget.keys != null ? widget.keys[5] : null,
      padding: widget.paginationTopOnly
          ? EdgeInsets.only(
              top: widget.compact
                  ? (widget.paginationHeightCompact - widget.paginationSize)
                  : (widget.paginationHeight - widget.paginationSize))
          : EdgeInsets.all(widget.compact
              ? ((widget.paginationHeightCompact - widget.paginationSize) / 2)
              : ((widget.paginationHeight - widget.paginationSize) / 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Padding>.generate(length, (i) {
          return Padding(
            padding: widget.circlePagination
                ? EdgeInsets.only(right: widget.paginationSize * 0.15, left: widget.paginationSize * 0.15)
                : EdgeInsets.only(right: widget.paginationSize * 0.5, left: widget.paginationSize * 0.5),
            child: Container(
              height: widget.paginationSize,
              width: widget.circlePagination
                  ? widget.paginationSize
                  : widget.paginationSize * widget.rectanglePaginationFactor,
              decoration: new BoxDecoration(
                shape: widget.circlePagination == true ? BoxShape.circle : BoxShape.rectangle,
                color: widget.paginationColorMode ?? Theme.of(context).brightness == Brightness.light
                    ? (currentIndex == i ? widget.selectedColor : widget.unselectedColor)
                    : (currentIndex == i ? widget.selectedColorDark : widget.unselectedColorDark),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Converts an index of a set size to the corresponding index of a collection of another size
/// as if they were circular.
///
/// Takes a [position] from collection Foo, a [base] from where Foo's index originated
/// and the [length] of a second collection Baa, for which the correlating index is sought.
///
/// For example; We have a Carousel of 10000(simulating infinity) but only 6 images.
/// We need to repeat the images to give the illusion of a never ending stream.
/// By calling _getRealIndex with position and base we get an offset.
/// This offset modulo our length, 6, will return a number between 0 and 5, which represent the image
/// to be placed in the given position.
int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _remainder(offset, length);
}

/// Returns the remainder of the modulo operation [input] % [source], and adjust it for
/// negative values.
int _remainder(int input, int source) {
  final int result = input % source;
  return result < 0 ? source + result : result;
}
