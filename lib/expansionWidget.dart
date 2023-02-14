import 'dart:math';

import 'package:custom_expansion_tile/expansionGroup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ExpansionWidget extends StatefulWidget {
  const ExpansionWidget({
    super.key,
    required this.primary,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.child,
    this.activeIconColor,
    this.disabledIconColor,
    this.activeTextColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.onExpansionStarted,
    this.onExpansionEnded,
    this.curves,
    this.borderRadius,
    this.childPadding =
        const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    this.trailing = const Icon(Icons.expand_more),
    this.initiallyExpanded = false,
    this.dividerBuilder,
    this.childAlignment = Alignment.center,
    this.expandingAnimationDuration = const Duration(milliseconds: 150),
    this.isIconOnTheRight = true,
    this.childClipBehaviour = Clip.antiAlias,
    this.trailingIconAnimationBuilder,
  });

  /// The title of the widget
  final Widget primary;

  /// The widget displayed after the title.
  final Widget trailing;

  /// The list of widget shown when the user expands the Widget
  final Widget? child;

  /// The title of the padding
  final EdgeInsets tilePadding;

  /// The padding given to the child when the Widget is expanded
  final EdgeInsets childPadding;

  /// The border radius given to the Splash
  final BorderRadius? borderRadius;

  /// The color of the icon when the Widget is expanded
  final Color? activeIconColor;

  /// The color of the icon when the Widget is closed
  final Color? disabledIconColor;

  /// The color of the text when the Widget is expanded
  final Color? activeTextColor;

  /// The color of the text when the Widget is closed
  final Color? disabledTextColor;

  /// The color of the Widget when it is expanded
  final Color? backgroundColor;

  /// The color of the Widget when it is closed
  final Color? collapsedBackgroundColor;

  /// The clip behaviour of the child
  final Clip childClipBehaviour;

  /// The curves given to the animation of the widget
  final Curve? curves;

  /// The alignment of the child widget
  final Alignment childAlignment;

  /// The duration of the expanding animation
  final Duration expandingAnimationDuration;

  /// [initiallyExpanded] if set to true, the Widget will be rendered already expanded.
  ///
  /// By default this value is set to false.
  final bool initiallyExpanded;

  /// [true] if the icon needs to be on the far right of the widget.
  ///
  /// [false] if the icon needs to be on the far left of the widget.
  final bool isIconOnTheRight;

  /// Function that gets triggered when the user clicks on the Widget.
  ///
  /// It takes a boolean value as a parameter that indicates the expanded status
  /// of the widget at the beginning of the animation.
  ///
  /// [isExpanded] is true if the Widget was already expanded when the user clicks on it
  ///
  /// [isExpanded] is false if the Widget was already closed when the user clicks on it
  final void Function(BuildContext context, bool isExpanded)?
      onExpansionStarted;

  /// Function that gets triggered when the animation finishes, whether is closing or opening.
  ///
  /// It takes a boolean value as a parameter that indicates the expanded status
  /// of the widget at the end of the animation.
  ///
  /// [isExpanded] is true if the Widget is opened at the end of the animation
  ///
  /// [isExpanded] is false if the Widget is closed at the end of the animation
  final void Function(BuildContext context, bool isExpanded)? onExpansionEnded;

  /// The builder of the divider that is shown once you expand the widget.
  ///
  /// If not specified, the widget will show a standard Divider that will appear
  /// when the user expands the Widget.
  ///
  /// [isUpperDivider] true if the widget is building the top divider.
  final Widget Function(BuildContext context, bool isUpperDivider)?
      dividerBuilder;

  /// Builder function of the trailing icon that gets triggered when the user expands
  /// the widget.
  ///
  /// [context] the context of the widget.
  ///
  /// [trailingIcon] the trailing icon used in the widget
  ///
  /// [value] the raw value of the animation controller.
  /// The value goes from 0.0 to 1.0 and will change in value once the animation controller
  /// animation gets triggered
  final Widget Function(
          BuildContext context, Widget trailingIcon, double value)?
      trailingIconAnimationBuilder;

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _iconRotation;
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  final ColorTween _iconColorsTween = ColorTween();
  final ColorTween _textColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();
  late Animation<Color?> _iconColor;
  late Animation<Color?> _textColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;
  bool _hasCompletedSetting = false;

  void _handleOnTap({bool withAnimations = true}) {
    setState(() {
      if (widget.onExpansionStarted != null) {
        widget.onExpansionStarted!.call(context, _isExpanded);
      }

      if (ExpansionInheritedWidget.maybeOf(context) != null) {
        if (_isExpanded) {
          ExpansionInheritedWidget.of(context).onStateChanged(null);
        } else {
          ExpansionInheritedWidget.of(context).onStateChanged(widget.key);
        }
      }

      _isExpanded = !_isExpanded;

      if (!withAnimations) {
        if (_isExpanded) {
          _animationController
              .animateTo(1, duration: Duration.zero)
              .whenComplete(() {
            if (widget.onExpansionEnded != null) {
              widget.onExpansionEnded!.call(context, _isExpanded);
            }
          });
        } else {
          _animationController
              .animateBack(0, duration: Duration.zero)
              .whenComplete(() {
            if (widget.onExpansionEnded != null) {
              widget.onExpansionEnded!.call(context, _isExpanded);
            }
          });
        }
      } else {
        if (_isExpanded) {
          openWidget();
        } else {
          closeWidget();
        }
      }
    });
  }

  void setExpandedState(bool value) {
    setState(() {
      _isExpanded = value;
    });
  }

  void openWidget() {
    _animationController.forward().whenComplete(() {
      if (widget.onExpansionEnded != null) {
        widget.onExpansionEnded!.call(context, _isExpanded);
      }
    });
  }

  void closeWidget() {
    _animationController.reverse().whenComplete(() {
      if (widget.onExpansionEnded != null) {
        widget.onExpansionEnded!.call(context, _isExpanded);
      }
    });
  }

  Widget _buildPrimary(ThemeData currentTheme) {
    return Row(
      textDirection:
          widget.isIconOnTheRight ? TextDirection.ltr : TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: DefaultTextStyle(
            style: currentTheme.textTheme.titleMedium!.copyWith(
              color: _textColor.value,
            ),
            child: widget.primary,
          ),
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(_iconColor.value!, BlendMode.srcIn),
          child: widget.trailingIconAnimationBuilder != null
              ? widget.trailingIconAnimationBuilder!
                  .call(context, widget.trailing, _curvedAnimation.value)
              : Transform.rotate(
                  angle: _iconRotation.value, child: widget.trailing),
        )
      ],
    );
  }

  Widget _animatedDivider(BuildContext context, bool isUpperDivider) {
    return Align(
      alignment: Alignment.center,
      heightFactor: _curvedAnimation.value,
      child: Opacity(
        opacity: _curvedAnimation.value,
        child: widget.dividerBuilder != null
            ? widget.dividerBuilder!.call(context, isUpperDivider)
            : const Divider(
                height: 0,
                thickness: 1,
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: widget.expandingAnimationDuration);

    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: widget.curves ?? Curves.linear);

    _iconRotation = Tween<double>(begin: 0, end: pi).animate(_curvedAnimation);
    _iconColor = _curvedAnimation.drive(_iconColorsTween);

    _textColor = _curvedAnimation.drive(_textColorTween);

    _backgroundColor = _curvedAnimation.drive(_backgroundColorTween);
  }

  @override
  void didChangeDependencies() {
    if (ExpansionInheritedWidget.maybeOf(context) != null) {
      assert(widget.key != null,
          'If this widget is inside an ExpansionGroup, it must have a key attached to it.');
    }

    ThemeData theme = Theme.of(context);

    var disabledColor = theme.unselectedWidgetColor;
    var activeColor = theme.colorScheme.primary;

    _iconColorsTween
      ..begin = widget.disabledIconColor ?? disabledColor
      ..end = widget.activeIconColor ?? activeColor;

    _textColorTween
      ..begin = widget.disabledTextColor ?? theme.textTheme.titleMedium!.color
      ..end = widget.activeTextColor ?? activeColor;

    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor ?? Colors.transparent
      ..end = widget.backgroundColor ?? Colors.transparent;

    if (widget.initiallyExpanded && !_hasCompletedSetting) {
      assert(ExpansionInheritedWidget.maybeOf(context) == null,
          'If this widget is inside an ExpansionGroup, it cannot be initially opened.');

      _handleOnTap(withAnimations: false);
      setState(() {
        _hasCompletedSetting = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleStateChange() {
    if (ExpansionInheritedWidget.maybeOf(context) != null) {
      ExpansionInheritedWidget group = ExpansionInheritedWidget.of(context);

      if (group.openedWidgetKey != widget.key) {
        _isExpanded = false;
        closeWidget();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    _handleStateChange();

    return AnimatedBuilder(
        animation: _curvedAnimation,
        builder: (context, _) {
          return Material(
            color: _backgroundColor.value,
            borderRadius: widget.borderRadius,
            child: Column(
              children: [
                _animatedDivider(context, true),
                InkWell(
                  borderRadius: widget.borderRadius,
                  onTap: () {
                    _handleOnTap(withAnimations: true);
                  },
                  child: Padding(
                    padding: widget.tilePadding,
                    child: _buildPrimary(currentTheme),
                  ),
                ),
                ClipRect(
                  clipBehavior: widget.childClipBehaviour,
                  child: Align(
                    alignment: widget.childAlignment,
                    heightFactor: _curvedAnimation.value,
                    child: Opacity(
                      opacity: _curvedAnimation.value,
                      child: Padding(
                        padding: widget.child != null
                            ? widget.childPadding
                            : EdgeInsets.zero,
                        child: SizedBox(
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
                _animatedDivider(context, false),
              ],
            ),
          );
        });
  }
}

class ExpansionInheritedWidget extends InheritedWidget {
  const ExpansionInheritedWidget({
    super.key,
    required this.openedWidgetKey,
    required this.onStateChanged,
    required this.closeCurrentlyOpenedWidget,
    required super.child,
  });

  final Key? openedWidgetKey;
  final void Function(Key? key) onStateChanged;
  final void Function() closeCurrentlyOpenedWidget;

  @override
  bool updateShouldNotify(ExpansionInheritedWidget oldWidget) {
    return openedWidgetKey != oldWidget.openedWidgetKey;
  }

  static ExpansionInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ExpansionInheritedWidget>();
  }

  static ExpansionInheritedWidget of(BuildContext context) {
    final ExpansionInheritedWidget? result = maybeOf(context);
    assert(result != null, 'No ExpansionGroup found in this context');
    return result!;
  }
}
