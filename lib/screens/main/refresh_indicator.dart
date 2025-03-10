import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class CheckMarkIndicator extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;

  const CheckMarkIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<CheckMarkIndicator> createState() => _CheckMarkIndicatorState();
}

class _CheckMarkIndicatorState extends State<CheckMarkIndicator>
    with SingleTickerProviderStateMixin {
  bool _renderCompleteState = false;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      offsetToArmed: 150.0,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        widget.onRefresh();
      },
      durations: const RefreshIndicatorDurations(
        completeDuration: Duration(seconds: 1),
      ),
      onStateChanged: (change) {
        if (change.didChange(to: IndicatorState.complete)) {
          _renderCompleteState = true;
        } else if (change.didChange(to: IndicatorState.idle)) {
          _renderCompleteState = false;
        }
      },
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? _) {
                return Container(
                  height: controller.value * 160.0,
                  width: double.infinity,
                  color: const Color.fromARGB(135, 255, 255, 255),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _renderCompleteState
                          ? const Icon(
                            size: 50,
                            Icons.check,
                            color: Colors.black,
                          )
                          : SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 4,
                              value:
                                  controller.isDragging || controller.isArmed
                                      ? controller.value.clamp(0.0, 1.0)
                                      : null,
                            ),
                          ),
                    ],
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * 150.0),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
