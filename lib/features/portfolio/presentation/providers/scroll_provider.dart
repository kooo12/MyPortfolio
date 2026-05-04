import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollProvider = StateNotifierProvider<ScrollNotifier, ScrollState>((
  ref,
) {
  return ScrollNotifier();
});

class ScrollState {
  final ScrollController controller;
  final int activeIndex;
  final Map<int, GlobalKey> sectionKeys;

  ScrollState({
    required this.controller,
    this.activeIndex = 0,
    required this.sectionKeys,
  });

  ScrollState copyWith({int? activeIndex, Map<int, GlobalKey>? sectionKeys}) {
    return ScrollState(
      controller: controller,
      activeIndex: activeIndex ?? this.activeIndex,
      sectionKeys: sectionKeys ?? this.sectionKeys,
    );
  }
}

class ScrollNotifier extends StateNotifier<ScrollState> {
  Timer? _throttleTimer;

  ScrollNotifier()
    : super(
        ScrollState(
          controller: ScrollController(),
          sectionKeys: {
            0: GlobalKey(), // Home / Hero
            1: GlobalKey(), // About
            2: GlobalKey(), // Projects
            3: GlobalKey(), // Experience (Skills + Experience)
            4: GlobalKey(), // Contact
          },
        ),
      ) {
    state.controller.addListener(_onScroll);
  }

  void _onScroll() {
    _throttleTimer ??= Timer(const Duration(milliseconds: 150), () {
      _throttleTimer = null;
      _detectActiveSection();
    });
  }

  void _detectActiveSection() {
    if (!mounted) return;

    int newIndex = state.activeIndex;
    double minDistance = double.infinity;

    state.sectionKeys.forEach((index, key) {
      final context = key.currentContext;
      if (context != null) {
        final renderObject = context.findRenderObject();
        if (renderObject != null) {
          double distance = 0;
          if (renderObject is RenderBox) {
            final RenderAbstractViewport? viewport = RenderAbstractViewport.of(
              renderObject,
            );
            if (viewport != null) {
              final RevealedOffset offsetToReveal = viewport.getOffsetToReveal(
                renderObject,
                0.0,
              );
              distance = (offsetToReveal.offset - state.controller.offset)
                  .abs();
            } else {
              distance = renderObject.localToGlobal(Offset.zero).dy.abs();
            }
          } else if (renderObject is RenderSliver) {
            final viewport = context
                .findAncestorRenderObjectOfType<RenderViewportBase>();
            if (viewport != null) {
              final revealOffset = viewport.getOffsetToReveal(
                renderObject,
                0.0,
              );
              distance = (revealOffset.offset - state.controller.offset).abs();
            }
          }

          if (distance < minDistance) {
            minDistance = distance;
            newIndex = index;
          }
        }
      }
    });

    if (newIndex != state.activeIndex) {
      state = state.copyWith(activeIndex: newIndex);
    }
  }

  void scrollToSection(int index) {
    final key = state.sectionKeys[index];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _throttleTimer?.cancel();
    state.controller.removeListener(_onScroll);
    state.controller.dispose();
    super.dispose();
  }
}
