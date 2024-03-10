// ignore_for_file: must_be_immutable

import 'package:final_project/providers/appbar_provider.dart';
import 'package:final_project/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';

class GeneralAppText extends ConsumerStatefulWidget {
  final String text;
  final Color? color;
  double size;
  FontWeight? weight;
  TextAlign? alignment;

  GeneralAppText({
    super.key,
    required this.text,
    this.color,
    this.size = 24,
    this.weight,
    this.alignment,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GeneralAppTextState();
}

class _GeneralAppTextState extends ConsumerState<GeneralAppText> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(settingsProvider);
    final langCode = ref.watch(settingsProvider).langCode;

    return FutureBuilder<Translation>(
      future: GoogleTranslator().translate(widget.text, to: langCode),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.text,
            style: GoogleFonts.lato(
              color: theme.isLightMode == true ? textColor1 : textColor2,
              fontSize: widget.size,
              fontWeight: widget.weight,
            ),
            textAlign: widget.alignment,
          );
        } else {
          return Text(
            widget.text,
            style: GoogleFonts.lato(
              color: theme.isLightMode == true ? textColor1 : textColor2,
              fontSize: widget.size,
              fontWeight: widget.weight,
            ),
            textAlign: widget.alignment,
          );
        }
      },
    );
  }
}

class PrimaryAppText extends ConsumerStatefulWidget {
  final String text;
  final Color? color;
  double size;
  FontWeight? weight;
  TextAlign? alignment;

  PrimaryAppText({
    super.key,
    required this.text,
    this.color,
    this.size = 24,
    this.weight,
    this.alignment,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrimaryAppTextState();
}

class _PrimaryAppTextState extends ConsumerState<PrimaryAppText> {
  @override
  Widget build(BuildContext context) {
    final langCode = ref.watch(settingsProvider).langCode;

    return FutureBuilder<Translation>(
      future: GoogleTranslator().translate(widget.text, to: langCode),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.text,
            style: GoogleFonts.lato(
              color: widget.color,
              fontSize: widget.size,
              fontWeight: widget.weight,
            ),
            textAlign: widget.alignment,
          );
        } else {
          return Text(
            widget.text,
            style: GoogleFonts.lato(
              color: widget.color,
              fontSize: widget.size,
              fontWeight: widget.weight,
            ),
            textAlign: widget.alignment,
          );
        }
      },
    );
  }
}

class SecondaryAppText extends ConsumerStatefulWidget {
  final String text;
  final Color? color;
  double size;
  FontWeight? weight;
  TextAlign? alignment;

  SecondaryAppText({
    super.key,
    required this.text,
    this.color,
    this.size = 24,
    this.weight,
    this.alignment,
  });

  @override
  ConsumerState<SecondaryAppText> createState() => _SecondaryAppTextState();
}

class _SecondaryAppTextState extends ConsumerState<SecondaryAppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.lato(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: widget.weight,
      ),
      textAlign: widget.alignment,
    );
  }
}

class DropdownText extends StatelessWidget {
  final String text;
  final Color? color;
  double size;
  FontWeight? weight;
  TextAlign? alignment;

  DropdownText({
    super.key,
    required this.text,
    this.color,
    this.size = 24,
    this.weight,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
      textAlign: alignment,
    );
  }
}
