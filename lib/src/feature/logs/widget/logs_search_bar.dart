import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/logs_controller.dart';
import 'logs_scope.dart';

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

  void _onEditingComplete(BuildContext context) {
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
            onEditingComplete: () => _onEditingComplete(context),
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
              prefixIcon: const Opacity(opacity: .5, child: Icon(Icons.search)),
              contentPadding: EdgeInsets.zero,
              suffixIconConstraints: BoxConstraints.tight(const Size.square(48)),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _textSearchController,
                builder: (context, value, child) => value.text.isEmpty ? const SizedBox.shrink() : child!,
                child: IconButton(
                  icon: const Icon(Icons.clear),
                  iconSize: 24,
                  padding: EdgeInsets.zero,
                  splashRadius: 18,
                  constraints: BoxConstraints.tight(const Size.square(48)),
                  onPressed: isProcessing
                      ? null
                      : () {
                          _textSearchController.clear();
                          _onEditingComplete(context);
                        },
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
