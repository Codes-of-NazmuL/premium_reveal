# Premium Reveal ✨

A serene, calm, high-performance staggered entry reveal animation suite for Flutter with **zero third-party dependencies**.

Designed for apps that need a polished, Apple/Linear-tier feel without the boilerplate of manually managing `AnimationController`s, tickers, and staggered intervals.

[![pub package](https://img.shields.io/badge/pub.dev-1.0.0-blue.svg)](https://github.com/Codes-of-NazmuL/premium_reveal)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)

---

## ✨ Features

- 🌿 **Zero Dependencies:** Pure Flutter SDK (`flutter/material.dart` + `dart:async`). No bloat, no version conflicts.
- 🪄 **Fluid Motion:** Smooth 440ms `Curves.easeOutCubic` motion combining subtle vertical slide, micro-scale, and fade.
- ⚡️ **Staggered Delays:** Automatic or customized delays per order index (default 45ms per step).
- 🧭 **Route-Aware:** Automatically coordinates with `ModalRoute` to begin cascading only after the screen transition finishes.
- ♿️ **Accessibility Ready:** Honors `MediaQuery.disableAnimationsOf` to instantly render content when reduce motion is enabled.
- 🧱 **Drop-in Layouts:** `PremiumStaggeredColumn` and `PremiumStaggeredRow` that automatically stagger child widgets while leaving spacing untouched.

---

## 📦 Installation

Add `premium_reveal` via Git in your `pubspec.yaml`:

```yaml
dependencies:
  premium_reveal:
    git:
      url: https://github.com/Codes-of-NazmuL/premium_reveal.git
      ref: main
```

Or install from terminal:

```bash
flutter pub add 'premium_reveal:{"git":{"url":"https://github.com/Codes-of-NazmuL/premium_reveal.git"}}'
```

---

## 🚀 Quick Usage

### 1. The Extension Method (Simplest)

Just call `.reveal(order: ...)` on any widget:

```dart
import 'package:flutter/material.dart';
import 'package:premium_reveal/premium_reveal.dart';

class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget().reveal(order: 0),
        TitleText('Welcome back').reveal(order: 1),
        SubtitleText('Choose an option below').reveal(order: 2),
        FeatureCard().reveal(order: 3),
        ActionButtons().reveal(order: 4),
      ],
    );
  }
}
```

### 2. Auto-Staggered Column

Wrap children in `PremiumStaggeredColumn`. It automatically indexes each element while ignoring blank `SizedBox` spacers:

```dart
PremiumStaggeredColumn(
  children: [
    Logo(),
    const SizedBox(height: 16),
    TitleText('Sign In'),
    const SizedBox(height: 8),
    EmailField(),
    PasswordField(),
    SubmitButton(),
  ],
)
```

### 3. Coordinated Page Transitions

To give whole routes the same gentle motion profile, set `PremiumPageTransitionsBuilder` in your `ThemeData`:

```dart
ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PremiumPageTransitionsBuilder(),
      TargetPlatform.iOS: PremiumPageTransitionsBuilder(),
    },
  ),
)
```

---

## ⚙️ Customization Options

You can easily adjust offsets, curves, durations, and scales:

```dart
myWidget.reveal(
  order: 2,
  duration: const Duration(milliseconds: 500),
  delayPerOrder: const Duration(milliseconds: 60),
  offset: const Offset(0, 0.08), // Slide in from further down
  initialScale: 0.95,            // More noticeable scale pop
  curve: Curves.easeOutBack,
  waitForRoute: true,            // Wait for route animation to complete
);
```

---

## 👨‍💻 Author & Maintainer

Created with ❤️ by **Nazmul Islam**

- **GitHub:** [@Codes-of-NazmuL](https://github.com/Codes-of-NazmuL)

Feel free to star ⭐️ the repository and contribute!

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
