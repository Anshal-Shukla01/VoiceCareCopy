import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const VoiceCareSettings());
}

class VoiceCareSettings extends StatelessWidget {
  const VoiceCareSettings({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFFD54F);
    const backgroundDark = Color(0xFF121212);
    const cardDark = Color(0xFF1E1E1E);
    const cardDarkHover = Color(0xFF2A2A2A);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundDark,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          // 'background' is deprecated. Use 'surface' instead.
          surface: backgroundDark,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'VOICECARE',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // === General Settings ===
                  sectionTitle("General Settings"),
                  const SizedBox(height: 10),

                  SettingTile(
                    icon: Icons.mic,
                    title: "Voice Assistant",
                    hasSwitch: true,
                    primaryColor: primaryColor,
                    cardColor: cardDark,
                    hoverColor: cardDarkHover,
                  ),

                  const SizedBox(height: 30),

                  // === Personalization ===
                  sectionTitle("Personalization"),
                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: cardDark,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          // The 'withOpacity' method on Color is deprecated.
                          // The recommended replacement is 'withAlpha' to set the alpha value directly.
                          color: Colors.black.withAlpha((0.3 * 255).round()), // 0.3 * 255 = 76.5, rounded to 77
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        SettingTile(
                          icon: Icons.palette,
                          title: "Themes & Contrast",
                          showArrow: true,
                          primaryColor: primaryColor,
                          cardColor: Colors.transparent,
                          hoverColor: cardDarkHover,
                        ),
                        const Divider(
                          color: Colors.white24,
                          height: 1,
                        ),
                        SettingTile(
                          icon: Icons.text_fields,
                          title: "Font Size & Haptics",
                          showArrow: true,
                          primaryColor: primaryColor,
                          cardColor: Colors.transparent,
                          hoverColor: cardDarkHover,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // === Safety & Support ===
                  sectionTitle("Safety & Support"),
                  const SizedBox(height: 10),

                  SettingTile(
                    icon: Icons.shield,
                    title: "Emergency Contacts",
                    showArrow: true,
                    primaryColor: primaryColor,
                    cardColor: cardDark,
                    hoverColor: cardDarkHover,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white54,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class SettingTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool hasSwitch;
  final bool showArrow;
  final Color primaryColor;
  final Color cardColor;
  final Color hoverColor;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.hasSwitch = false,
    this.showArrow = false,
    required this.primaryColor,
    required this.cardColor,
    required this.hoverColor,
  });

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  bool isSwitched = true;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isPressed ? widget.hoverColor : widget.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // The 'withOpacity' method on Color is deprecated.
            // The recommended replacement is 'withAlpha' to set the alpha value directly.
            color: Colors.black.withAlpha((0.3 * 255).round()), // 0.3 * 255 = 76.5, rounded to 77
            blurRadius: 5,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTapDown: (_) => setState(() => isPressed = true),
        onTapCancel: () => setState(() => isPressed = false),
        onTapUp: (_) => setState(() => isPressed = false),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(widget.icon, color: widget.primaryColor, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (widget.hasSwitch)
                Switch(
                  value: isSwitched,
                  activeThumbColor: widget.primaryColor, // Changed from activeColor to activeThumbColor
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade800,
                  onChanged: (value) => setState(() => isSwitched = value),
                ),
              if (widget.showArrow)
                Icon(
                  Icons.chevron_right,
                  color: Colors.white54,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
