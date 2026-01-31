import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scrollProvider = StateNotifierProvider<ScrollNotifier, ScrollState>((
  ref,
) {
  return ScrollNotifier();
});

class ScrollState {
  final ScrollController controller;
  final int activeIndex;
  final double scrollOffset;
  final Map<int, GlobalKey> sectionKeys;

  ScrollState({
    required this.controller,
    this.activeIndex = 0,
    this.scrollOffset = 0,
    required this.sectionKeys,
  });

  ScrollState copyWith({
    int? activeIndex,
    double? scrollOffset,
    Map<int, GlobalKey>? sectionKeys,
  }) {
    return ScrollState(
      controller: controller,
      activeIndex: activeIndex ?? this.activeIndex,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      sectionKeys: sectionKeys ?? this.sectionKeys,
    );
  }
}

class ScrollNotifier extends StateNotifier<ScrollState> {
  ScrollNotifier()
    : super(
        ScrollState(
          controller: ScrollController(),
          sectionKeys: {
            0: GlobalKey(),
            1: GlobalKey(),
            2: GlobalKey(),
            3: GlobalKey(),
            4: GlobalKey(),
            5: GlobalKey(),
          },
        ),
      ) {
    state.controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    final offset = state.controller.offset;

    int newIndex = state.activeIndex;
    double minDistance = double.infinity;

    state.sectionKeys.forEach((index, key) {
      final context = key.currentContext;
      if (context != null) {
        final renderObject = context.findRenderObject() as RenderBox;
        final position = renderObject.localToGlobal(Offset.zero);
        final distance = position.dy.abs();
        if (distance < minDistance) {
          minDistance = distance;
          newIndex = index;
        }
      }
    });

    if (newIndex != state.activeIndex || offset != state.scrollOffset) {
      state = state.copyWith(activeIndex: newIndex, scrollOffset: offset);
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
    state.controller.removeListener(_scrollListener);
    state.controller.dispose();
    super.dispose();
  }
}
