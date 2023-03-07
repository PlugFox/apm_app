import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/util/date_util.dart';
import '../controller/logs_controller.dart';
import '../model/logs_filter.dart';
import 'logs_scope.dart';
import 'positioned_draggable_handle.dart';

/// {@template logs_search_bar}
/// LogsSearchBar widget.
/// {@endtemplate}
class LogsSearchBar extends StatefulWidget implements PreferredSizeWidget {
  /// {@macro logs_search_bar}
  const LogsSearchBar({super.key});

  /// The height of the toolbar.
  static const Size size = Size.fromHeight(kToolbarHeight);

  @override
  Size get preferredSize => LogsSearchBar.size;

  @override
  State<LogsSearchBar> createState() => _LogsSearchBarState();
}

class _LogsSearchBarState extends State<LogsSearchBar> {
  // with _OverlaySearchMixin
  late final ILogsController _controller;
  final TextEditingController _textSearchController = TextEditingController();
  final FocusNode _textSearchFocusNode = FocusNode();
  final ValueNotifier<bool> _isProcessing = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller = LogsScope.controllerOf(context)..addListener(_onStateChanged);
    _isProcessing.value = _controller.state.isProcessing;
  }

  void _onStateChanged() {
    final state = _controller.state;
    _isProcessing.value = state.isProcessing;
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChanged);
    _isProcessing.dispose();
    _textSearchController.dispose();
    _textSearchFocusNode.dispose();
    super.dispose();
  }

  // TODO(plugfox): Expand search bar when focused and show recent searches and filters.

  @override
  Widget build(BuildContext context) => SizedBox.fromSize(
        size: LogsSearchBar.size,
        child: Material(
          color: Theme.of(context).primaryColor,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: _LogsSearchTextField(
              isProcessing: _isProcessing,
              textSearchFocusNode: _textSearchFocusNode,
              textSearchController: _textSearchController,
            ),
          ),
        ),
      );
}

class _LogsSearchTextField extends StatelessWidget {
  const _LogsSearchTextField({
    required ValueNotifier<bool> isProcessing,
    required FocusNode textSearchFocusNode,
    required TextEditingController textSearchController,
  })  : _isProcessing = isProcessing,
        _textSearchFocusNode = textSearchFocusNode,
        _textSearchController = textSearchController;

  final ValueNotifier<bool> _isProcessing;
  final FocusNode _textSearchFocusNode;
  final TextEditingController _textSearchController;

  static final InputBorder _$border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.white54, width: 1),
  );
  static final InputBorder _$errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.red, width: 1),
  );
  static final InputBorder _$disabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.grey, width: 1),
  );

  void _onSubmitted(BuildContext context) {
    //context.findAncestorStateOfType<_LogsSearchBarState>()?.hide();
    _textSearchController.value = _TagsInputFormatter.formatValue(_textSearchController.value, finish: true);
    _textSearchFocusNode.unfocus();
    final controller = LogsScope.controllerOf(context);
    final text = _textSearchController.text;
    if (text == controller.state.filter.search) return;
    controller.changeFilter((filter) => filter.copyWith(search: text));
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: _isProcessing,
        builder: (context, isProcessing, _) => AnimatedOpacity(
          opacity: isProcessing ? .5 : 1,
          duration: const Duration(milliseconds: 350),
          child: TextField(
            enabled: !isProcessing,
            focusNode: _textSearchFocusNode,
            controller: _textSearchController,
            inputFormatters: const <TextInputFormatter>[_TagsInputFormatter()],
            maxLines: 1,
            keyboardType: TextInputType.text,
            onEditingComplete: () => _onSubmitted(context),
            keyboardAppearance: Theme.of(context).brightness,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: _$border,
              errorBorder: _$errorBorder,
              enabledBorder: _$border,
              focusedBorder: _$border,
              focusedErrorBorder: _$errorBorder,
              disabledBorder: _$disabledBorder,
              hintText: 'Search by event, tag, project, etc...',
              prefixIcon: const Opacity(
                opacity: .5,
                child: Icon(
                  Icons.search,
                  size: 22,
                ),
              ),
              prefixIconConstraints: BoxConstraints.tight(const Size.square(48)),
              contentPadding: EdgeInsets.zero,
              suffixIconConstraints: BoxConstraints.loose(const Size(48 * 2, 48)),
              suffixIcon: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Clear search field button.
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _textSearchController,
                      builder: (context, value, child) => value.text.isEmpty ? const SizedBox.shrink() : child!,
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Clear search field',
                        iconSize: 24,
                        padding: EdgeInsets.zero,
                        splashRadius: 18,
                        constraints: BoxConstraints.tight(const Size.square(48)),
                        onPressed: isProcessing
                            ? null
                            : () {
                                _textSearchController.clear();
                                _onSubmitted(context);
                              },
                      ),
                    ),

                    // Advanced search button.
                    IconButton(
                      icon: const Icon(Icons.manage_search),
                      tooltip: 'Advanced search',
                      iconSize: 24,
                      alignment: const Alignment(0, -.15),
                      padding: EdgeInsets.zero,
                      splashRadius: 18,
                      constraints: BoxConstraints.tight(const Size.square(48)),
                      onPressed: isProcessing
                          ? null
                          : () => _AdvancedSearchBottomSheet.show(
                                context,
                                filter: LogsScope.controllerOf(context).state.filter,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _TagsInputFormatter implements TextInputFormatter {
  const _TagsInputFormatter();

  static final _$RegExp = RegExp(r'\W+');

  /// Format the [value] to a valid tags string.
  /// [finish] is true when the user has finished typing.
  /// [finish] is false when the user is still typing.
  static TextEditingValue formatValue(TextEditingValue value, {bool finish = false}) {
    final text = value.text;
    var words = text.split(_$RegExp).map<String>((e) => e.trim().toLowerCase()).toList();
    final last = words.last;
    words = words.toSet().toList();
    var f = finish || text.endsWith(';') || text.endsWith('; ') || last != words.last;
    for (var i = words.length - (f ? 1 : 2); i >= 0; i--) {
      final word = words[i];
      if (word.length < 3) words.removeAt(i);
    }

    final newText = words.isEmpty ? '' : words.join('; ') + (f ? ';' : '');
    if (text == newText) return value;
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue _, TextEditingValue newValue) {
    final formatted = formatValue(newValue);
    if (newValue.text == formatted.text) return newValue;
    return formatted;
  }
}

class _AdvancedSearchBottomSheet extends StatefulWidget {
  const _AdvancedSearchBottomSheet({required this.filter, this.controller});

  final LogsFilter filter;

  /// Show the bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required LogsFilter filter,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          maxChildSize: .95,
          initialChildSize: .75,
          minChildSize: .25,
          builder: (context, controller) => _AdvancedSearchBottomSheet(filter: filter, controller: controller),
        ),
      );

  /// The [ScrollController] to use for the [ListView].
  final ScrollController? controller;

  @override
  State<_AdvancedSearchBottomSheet> createState() => _AdvancedSearchBottomSheetState();
}

class _AdvancedSearchBottomSheetState extends State<_AdvancedSearchBottomSheet> {
  late final ValueNotifier<LogsFilter> filter;

  @override
  void initState() {
    filter = ValueNotifier<LogsFilter>(widget.filter);
    super.initState();
  }

  @override
  void dispose() {
    filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
            child: RepaintBoundary(
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: Theme.of(context).scrollbarTheme.copyWith(
                        mainAxisMargin: 12,
                      ),
                ),
                child: CustomScrollView(
                  controller: widget.controller,
                  slivers: <Widget>[
                    _SearchBottomSheetAppBar(filter),
                    // TODO(plugfox): Recent searches.
                    _SearchBottomSheetBody(filter),
                  ],
                ),
              ),
            ),
          ),
          const PositionedDraggableHandle(),
        ],
      );
}

class _SearchBottomSheetAppBar extends StatelessWidget {
  const _SearchBottomSheetAppBar(this.filter);

  final ValueListenable<LogsFilter> filter;

  @override
  Widget build(BuildContext context) {
    final controller = LogsScope.controllerOf(context);
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      pinned: true,
      centerTitle: true,
      /* title: Text(
          MaterialLocalizations.of(context).searchFieldLabel,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ), */
      leading: IconButton(
        icon: const Icon(Icons.close),
        splashRadius: 24,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        Center(
          child: ValueListenableBuilder(
              valueListenable: filter,
              builder: (context, currentFilter, _) => TextButton.icon(
                    onPressed: controller.state.filter != currentFilter
                        ? () {
                            controller.setFilter(currentFilter);
                            Navigator.of(context).pop();
                          }
                        : null,
                    icon: const Icon(Icons.search),
                    label: Text(MaterialLocalizations.of(context).searchFieldLabel),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      fixedSize: const Size(96, 48),
                    ),
                  )),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _SearchBottomSheetBody extends StatefulWidget {
  const _SearchBottomSheetBody(this.filter);

  final ValueNotifier<LogsFilter> filter;

  @override
  State<_SearchBottomSheetBody> createState() => _SearchBottomSheetBodyState();
}

class _SearchBottomSheetBodyState extends State<_SearchBottomSheetBody> {
  late final ValueNotifier<RangeValues> _levelRange;

  @override
  void initState() {
    _levelRange = ValueNotifier<RangeValues>(
      RangeValues(
        widget.filter.value.levelFrom?.toDouble() ?? .0,
        widget.filter.value.levelTo?.toDouble() ?? 2000.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            const SizedBox(height: 16),
            /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Project',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (var i = 0; i < 10; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  'text',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            const Divider(height: 48),
            */

            // Date range picker.
            ValueListenableBuilder<LogsFilter>(
              valueListenable: widget.filter,
              builder: (context, filter, _) => _SearchSectionLabel(
                'Date',
                clear: filter.dateFrom == null && filter.dateTo == null
                    ? null
                    : () => widget.filter.value = widget.filter.value.clearDateRange(),
              ),
            ),
            ValueListenableBuilder<LogsFilter>(
              valueListenable: widget.filter,
              builder: (context, filter, _) => TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size(192, 64),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                icon: const Icon(Icons.calendar_today),
                onPressed: () => showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                ).then<void>((range) {
                  if (range == null) return;
                  widget.filter.value = widget.filter.value.copyWith(
                    dateFrom: range.start,
                    dateTo: range.end,
                  );
                }),
                label: Text(
                  filter.dateFrom == filter.dateTo
                      ? filter.dateFrom == null
                          ? 'Not selected'
                          : DateUtil.format(filter.dateFrom)
                      : '${filter.dateFrom == null ? '...' : DateUtil.format(filter.dateFrom)}'
                          ' - '
                          '${filter.dateTo == null ? '...' : DateUtil.format(filter.dateTo)}',
                ),
              ),
            ),
            const Divider(height: 48),

            // Level range picker.
            ValueListenableBuilder<RangeValues>(
              valueListenable: _levelRange,
              builder: (context, values, _) => _SearchSectionLabel(
                'Level',
                clear: values.start == .0 && values.end == 2000.0
                    ? null
                    : () {
                        _levelRange.value = const RangeValues(.0, 2000.0);
                        widget.filter.value = widget.filter.value.clearLevelRange();
                      },
              ),
            ),

            const SizedBox(height: 8),
            ValueListenableBuilder<RangeValues>(
              valueListenable: _levelRange,
              builder: (context, values, _) => RangeSlider(
                values: values,
                min: .0,
                max: 2000.0,
                divisions: 20,
                onChangeEnd: (value) {
                  _levelRange.value = value;
                  widget.filter.value = widget.filter.value.copyWith(
                    levelFrom: value.start.round(),
                    levelTo: value.end.round(),
                  );
                },
                onChanged: (value) => _levelRange.value = value,
                labels: RangeLabels(
                  values.start.round().toString(),
                  values.end.round().toString(),
                ),
              ),
            ),
          ],
        ),
      );
}

class _SearchSectionLabel extends StatelessWidget {
  const _SearchSectionLabel(this.label, {this.clear});

  final String label;
  final VoidCallback? clear;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            if (clear != null)
              IconButton(
                onPressed: clear,
                iconSize: 24,
                padding: EdgeInsets.zero,
                splashRadius: 24,
                constraints: BoxConstraints.tight(const Size.square(48)),
                icon: const Icon(Icons.clear),
              ),
            const SizedBox(width: 16),
          ],
        ),
      );
}
