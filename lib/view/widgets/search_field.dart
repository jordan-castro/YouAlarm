import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String query) onSubmit;

  const SearchField({Key? key, this.controller, required this.onSubmit}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController con;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: con,
      decoration: const InputDecoration(
        hintText: "Search",
        border: OutlineInputBorder(),
      ),
      autocorrect: true,
      maxLength: 100,
      maxLines: 1,
      onSubmitted: widget.onSubmit,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      con = TextEditingController();
    } else {
      con = widget.controller!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      con.dispose();
    }
    super.dispose();
  }
}
