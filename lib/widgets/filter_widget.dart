import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTypeProvider = StateProvider<bool>((ref) => _videoSelected);

class FilterDialog extends ConsumerStatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

  bool _videoSelected = false;
class _FilterDialogState extends ConsumerState<FilterDialog> {
  bool _courseSelected = false;
  String _searchBy = 'Title';
  String _duration = 'Small';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategory('Resource Type', [
              _buildOption('Video', _videoSelected, () {
                setState(() {
                  _videoSelected = !_videoSelected;
                  _courseSelected = false; // Reset other options
                });
              }),
              _buildOption('Course', _courseSelected, () {
                setState(() {
                  _courseSelected = !_courseSelected;
                  _videoSelected = false; // Reset other options
                });
              }),
            ]),
            SizedBox(height: 16),
            _buildCategory('Search By', [
              _buildOption('Title', _searchBy == 'Title', () {
                setState(() {
                  _searchBy = 'Title';
                });
              }),
              _buildOption('Subject', _searchBy == 'Subject', () {
                setState(() {
                  _searchBy = 'Subject';
                });
              }),
              _buildOption('Keyword', _searchBy == 'Keyword', () {
                setState(() {
                  _searchBy = 'Keyword';
                });
              }),
              _buildOption('Difficulty Level', _searchBy == 'Difficulty Level',
                  () {
                setState(() {
                  _searchBy = 'Difficulty Level';
                });
              }),
              _buildOption('Duration', _searchBy == 'Duration', () {
                setState(() {
                  _searchBy = 'Duration';
                });
              }),
            ]),
            SizedBox(height: 16),
            _buildSubOption('Duration', ['Small', 'Medium', 'Large'], _duration,
                (value) {
              setState(() {
                _duration = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String category, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Column(children: options),
      ],
    );
  }

  Widget _buildOption(String option, bool selected, VoidCallback onTap) {
    return ListTile(
      title: Text(option),
      leading: Checkbox(
        value: selected,
        onChanged: (_) => onTap(),
      ),
      onTap: onTap,
    );
  }

  void _handleDurationChanged(String? value) {
    if (value != null) {
      setState(() {
        _duration = value;
      });
    }
  }

  Widget _buildSubOption(String category, List<String> options,
      String selectedOption, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        DropdownButtonFormField(
          value: _duration,
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: _handleDurationChanged,
        )
      ],
    );
  }
}
