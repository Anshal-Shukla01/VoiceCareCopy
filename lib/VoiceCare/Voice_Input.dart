import 'package:flutter/material.dart';

class VoiceInputScreen extends StatefulWidget {
  @override
  _VoiceInputScreenState createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> {
  bool _isListening = false;

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
  }

  void _onMenuSelect(String value) {
    if (value == 'Health Insights') {
      Navigator.pushNamed(context, '/healthinsights');
    } else if (value == 'Settings') {
      Navigator.pushNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text(
          'VOICECARE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        leading: PopupMenuButton<String>(
          color: const Color(0xFF1E1E1E),
          icon: const Icon(Icons.more_vert, size: 30, color: Colors.white70),
          onSelected: _onMenuSelect,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'Health Insights',
              child: Row(
                children: [
                  Icon(Icons.insights, color: Colors.white70),
                  SizedBox(width: 10),
                  Text('Health Insights'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'Settings',
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.white70),
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white70, size: 30),
            onPressed: () {
              // Navigate to Health Log (History) page
              Navigator.pushNamed(context, '/healthlog');
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _toggleListening,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 190,
                width: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow.withOpacity(0.1),
                  boxShadow: _isListening
                      ? [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.3),
                            blurRadius: 40,
                            spreadRadius: 15,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.black87,
                      size: 60,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _isListening ? 'Listening...' : 'Tap anywhere to talk',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      // Optional: Add a floating action button to navigate to Reminder page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/reminder');
        },
        backgroundColor: const Color(0xFFFFD54F),
        child: const Icon(Icons.notifications, color: Colors.black87),
      ),
    );
  }
}