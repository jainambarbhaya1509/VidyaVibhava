import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/home/student/student_home_screen_pages/search_screen.dart';

final searchTypeProvider = StateProvider<bool>((ref) => _videoSelected);

class FilterDialog extends ConsumerStatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

bool _videoSelected = false;

class _FilterDialogState extends ConsumerState<FilterDialog> {
  bool _courseSelected = false;
  String _searchBy = '';
  String _duration = '';

  @override
  Widget build(BuildContext context) {
    final filterDialogState = ref.watch(filterDialogStateProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      child: SizedBox(
        height: screenHeight * 0.75,
        child: SingleChildScrollView(
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
                      _courseSelected = !_videoSelected;
                    });
                  }),
                  _buildOption('Course', _courseSelected, () {
                    setState(() {
                      _courseSelected = !_courseSelected;
                      _videoSelected = !_courseSelected;
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
                  _buildOption('Instructor Name', _searchBy == 'instructorName', () {
                    setState(() {
                      _searchBy = 'instructorName';
                    });
                  }),
                ]),
                SizedBox(height: 16),
                _buildCategory('Duration', [
                  _buildOption('Small', _duration == 'Small', () {
                    setState(() {
                      _duration = 'Small';
                    });
                  }),
                  _buildOption('Medium', _duration == 'Medium', () {
                    setState(() {
                      _duration = 'Medium';
                    });
                  }),
                  _buildOption('Large', _duration == 'Large', () {
                    setState(() {
                      _duration = 'Large';
                    });
                  }),
                ]),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: (){
                    filterDialogState.videoSelected = _videoSelected;
                    filterDialogState.duration = _duration;
                    filterDialogState.searchBy = _searchBy;
                    Navigator.pop(context);
                  },
                  child: Text('Update Filter'),
                ),
              ],
            ),
          ),
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

  // Function to get the selected resource type
  String getResourceType() {
    return _videoSelected ? 'Video' : 'Course';
  }

  // Function to get the selected search by option
  String getSearchBy() {
    return _searchBy;
  }

  // Function to get the selected duration
  String getDuration() {
    return _duration;
  }
}