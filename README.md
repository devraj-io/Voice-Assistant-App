First of all, the main.dart file is in **lib** branch. If you want to see the code you can visit there.

# Voice Assistant App

A simple voice assistant app built using Flutter. The app uses **speech_to_text** for voice recognition and **flutter_tts** for text-to-speech functionalities. This app serves as a starting point for building a voice-controlled assistant.

---

## 🚀 **Features**
- 🎤 **Voice Recognition:** Converts speech to text using `speech_to_text`.
- 🔊 **Text-to-Speech:** Reads text aloud using `flutter_tts`.
- 🧠 **AI Integration (Optional):** Easily extendable with Dialogflow or OpenAI for natural language processing.

---

## 📦 **Dependencies**
```yaml
name: projectsub
description: "A new Flutter project."
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ^3.7.0

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  speech_to_text: ^7.0.0
  provider: ^6.1.2
  dart_openai: ^5.1.0
  googleapis: ^13.2.0
  googleapis_auth: ^1.6.0
  permission_handler: ^11.4.0

  date_time_format: ^2.0.1
  intl: ^0.20.2


dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
```

---

## 🛠 **Setup Instructions**

### 1. **Clone the Repository**
```bash
git clone https://github.com/devraj-io/Voice-Assistant-App.git
cd voice_assistant_app
```

### 2. **Install Dependencies**
```bash
flutter pub get
```

### 3. **Run the App**
```bash
flutter run
```

### 4. **Set Up Android Emulator (Optional)**
```bash
flutter emulators
flutter emulators --launch <emulator_id>
```

---

## 🎨 **App Preview**
Add screenshots or GIFs showing the app in action.

---

## ⚙️ **Permissions**
For Android, add this permission to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

---

## 💡 **Future Enhancements**
- 🌐 Integrate with Dialogflow or GPT API for smart responses.
- 🕹 Add custom voice commands to control device features.
- 📈 Enhance UI with advanced Flutter widgets.

---

## 🆘 **Troubleshooting**
- **Microphone Not Working:** Check app permissions.
- **Emulator Issues:** Ensure Android SDK is installed correctly.

---

---

## ✨ **Contributions**
Feel free to open issues or submit pull requests to enhance the app!

