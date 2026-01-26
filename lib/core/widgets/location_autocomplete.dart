import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Location model for autocomplete
class LocationSuggestion {
  final String name;
  final String? description;
  final double latitude;
  final double longitude;

  LocationSuggestion({
    required this.name,
    this.description,
    required this.latitude,
    required this.longitude,
  });
}

/// Senegal cities database for autocomplete (offline-first)
class SenegalCities {
  static final List<LocationSuggestion> cities = [
    LocationSuggestion(
      name: 'Dakar',
      description: 'Région de Dakar',
      latitude: 14.6928,
      longitude: -17.4467,
    ),
    LocationSuggestion(
      name: 'Pikine',
      description: 'Banlieue de Dakar',
      latitude: 14.7504,
      longitude: -17.3974,
    ),
    LocationSuggestion(
      name: 'Guédiawaye',
      description: 'Banlieue de Dakar',
      latitude: 14.7724,
      longitude: -17.3932,
    ),
    LocationSuggestion(
      name: 'Rufisque',
      description: 'Banlieue de Dakar',
      latitude: 14.7167,
      longitude: -17.2667,
    ),
    LocationSuggestion(
      name: 'Thiès',
      description: 'Région de Thiès',
      latitude: 14.7886,
      longitude: -16.9260,
    ),
    LocationSuggestion(
      name: 'Saint-Louis',
      description: 'Région de Saint-Louis',
      latitude: 16.0200,
      longitude: -16.5000,
    ),
    LocationSuggestion(
      name: 'Touba',
      description: 'Région de Diourbel',
      latitude: 14.8500,
      longitude: -15.8833,
    ),
    LocationSuggestion(
      name: 'Kaolack',
      description: 'Région de Kaolack',
      latitude: 14.1333,
      longitude: -16.0667,
    ),
    LocationSuggestion(
      name: 'Mbour',
      description: 'Région de Thiès',
      latitude: 14.4167,
      longitude: -16.9667,
    ),
    LocationSuggestion(
      name: 'Ziguinchor',
      description: 'Région de Ziguinchor',
      latitude: 12.5500,
      longitude: -16.2667,
    ),
    LocationSuggestion(
      name: 'Diourbel',
      description: 'Région de Diourbel',
      latitude: 14.6500,
      longitude: -16.2333,
    ),
    LocationSuggestion(
      name: 'Louga',
      description: 'Région de Louga',
      latitude: 15.6167,
      longitude: -16.2167,
    ),
    LocationSuggestion(
      name: 'Tambacounda',
      description: 'Région de Tambacounda',
      latitude: 13.7667,
      longitude: -13.6667,
    ),
    LocationSuggestion(
      name: 'Richard-Toll',
      description: 'Région de Saint-Louis',
      latitude: 16.4600,
      longitude: -15.7000,
    ),
    LocationSuggestion(
      name: 'Kolda',
      description: 'Région de Kolda',
      latitude: 12.8833,
      longitude: -14.9500,
    ),
    LocationSuggestion(
      name: 'Fatick',
      description: 'Région de Fatick',
      latitude: 14.3333,
      longitude: -16.4000,
    ),
    LocationSuggestion(
      name: 'Kaffrine',
      description: 'Région de Kaffrine',
      latitude: 14.1000,
      longitude: -15.5500,
    ),
    LocationSuggestion(
      name: 'Matam',
      description: 'Région de Matam',
      latitude: 15.6500,
      longitude: -13.2500,
    ),
    LocationSuggestion(
      name: 'Saly',
      description: 'Station balnéaire',
      latitude: 14.4500,
      longitude: -17.0167,
    ),
    LocationSuggestion(
      name: 'Cap Skirring',
      description: 'Station balnéaire',
      latitude: 12.3833,
      longitude: -16.7500,
    ),
  ];

  static List<LocationSuggestion> search(String query) {
    if (query.isEmpty) return [];
    final lowerQuery = query.toLowerCase();
    return cities
        .where(
          (c) =>
              c.name.toLowerCase().contains(lowerQuery) ||
              (c.description?.toLowerCase().contains(lowerQuery) ?? false),
        )
        .toList();
  }
}

/// Location autocomplete text field with Senegalese cities
class LocationAutocomplete extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Function(LocationSuggestion) onSelected;
  final IconData? prefixIcon;

  const LocationAutocomplete({
    super.key,
    required this.label,
    this.hint = 'Entrez une ville',
    this.controller,
    required this.onSelected,
    this.prefixIcon,
  });

  @override
  State<LocationAutocomplete> createState() => _LocationAutocompleteState();
}

class _LocationAutocompleteState extends State<LocationAutocomplete> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  List<LocationSuggestion> _suggestions = [];
  bool _showSuggestions = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _hideSuggestions();
    }
  }

  void _onChanged(String value) {
    final results = SenegalCities.search(value);
    setState(() {
      _suggestions = results;
      _showSuggestions = results.isNotEmpty && _focusNode.hasFocus;
    });
    if (_showSuggestions) {
      _showOverlay();
    } else {
      _hideSuggestions();
    }
  }

  void _showOverlay() {
    _hideSuggestions();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: context.findRenderObject() != null
            ? (context.findRenderObject() as RenderBox).size.width
            : 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 56.h),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              constraints: BoxConstraints(maxHeight: 200.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
                    title: Text(
                      suggestion.name,
                      style: AppTextStyles.bodyLarge,
                    ),
                    subtitle: suggestion.description != null
                        ? Text(
                            suggestion.description!,
                            style: AppTextStyles.bodyMedium,
                          )
                        : null,
                    onTap: () {
                      _controller.text = suggestion.name;
                      widget.onSelected(suggestion);
                      _hideSuggestions();
                      _focusNode.unfocus();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideSuggestions() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _showSuggestions = false);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _overlayEntry?.remove();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: AppColors.primary)
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
