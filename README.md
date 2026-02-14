# 🚑 LifeLens - AR First Aid Application

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)

LifeLens is a cutting-edge AR-powered first aid application that connects users in emergencies with certified first responders, provides real-time medical guidance, and offers comprehensive emergency response coordination.

## 📋 Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [User Roles](#user-roles)
- [Key Features Deep Dive](#key-features-deep-dive)
- [State Management](#state-management)
- [Routing](#routing)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### 🆘 Emergency Response System
- **Real-time Emergency Alerts** - Instant notifications to nearby responders
- **Severity Assessment** - AI-powered emergency type and severity detection
- **Live Tracking** - Real-time location tracking of responders and emergencies
- **Smart Matching** - Algorithm-based responder-to-emergency matching
- **Emergency Card** - Quick access to critical medical information

### 👥 Dual Role System

#### User Features
- Emergency activation with one tap
- Real-time responder tracking
- In-app chat with responding professionals
- Medical profile management
- AED locator with map integration
- Emergency history and ratings
- Community access to nearby responders

#### Responder Features
- Real-time emergency notifications
- Earnings and rewards system
- Treatment logging and documentation
- Professional certification management
- Response history and statistics
- Network coordination with other responders
- Referral program

### 🗺️ Location Services
- **AED Locator** - Find nearest automated external defibrillators
- **Responder Network** - View nearby certified responders
- **Emergency Routing** - Optimized routes to emergency locations
- **Geofencing** - Location-based emergency alerts

### 💬 Communication
- Real-time messaging between users and responders
- Emergency-specific chat channels
- Search and filter conversations
- Message read receipts
- Online status indicators

### 🏥 Medical Management
- Comprehensive medical profile creation
- Allergy and medication tracking
- Emergency contact management
- Medical history documentation
- Health condition tracking

### 🎯 Gamification & Rewards
- Points system for responders
- Achievement badges
- Leaderboards
- Referral bonuses
- Perk redemption system

## 🏗️ Architecture

The application follows **Clean Architecture** principles with clear separation of concerns:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│     (Widgets, Pages, Screens)       │
├─────────────────────────────────────┤
│         Application Layer           │
│    (Providers, State Management)    │
├─────────────────────────────────────┤
│          Domain Layer               │
│      (Models, Entities, Use Cases)  │
├─────────────────────────────────────┤
│            Data Layer               │
│    (Repositories, Data Sources)     │
└─────────────────────────────────────┘
```

### Design Patterns Used
- **Provider Pattern** - State management with Riverpod
- **Repository Pattern** - Data access abstraction
- **Observer Pattern** - Real-time state updates
- **Factory Pattern** - Object creation
- **Singleton Pattern** - Service instances

## 🛠️ Tech Stack

### Core
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Riverpod** - State management solution

### Navigation
- **GoRouter** - Declarative routing with deep linking
- **Go Router Builder** - Type-safe route generation

### UI/UX
- **Flutter Animate** - Smooth animations and transitions
- **Custom Theming** - Dark mode optimized design
- **Responsive Design** - Adaptive layouts for all screen sizes

### Location & Maps
- **Google Maps** - Interactive maps integration
- **Geolocation** - GPS and location services
- **Geocoding** - Address and coordinate conversion

### Real-time Features
- **WebSockets** - Real-time communication
- **Stream Controllers** - Event-driven updates
- **Push Notifications** - Firebase Cloud Messaging (planned)

### Storage
- **Shared Preferences** - Local key-value storage
- **Secure Storage** - Sensitive data encryption
- **Local Database** - SQLite/Hive (planned)

## 🚀 Getting Started

### Prerequisites

```bash
Flutter SDK: >=3.0.0
Dart SDK: >=3.0.0
Android Studio / VS Code
Git
```

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/ar-first-aid.git
cd ar_firstaid_flutter
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure environment**
```bash
# Create a .env file in the root directory
cp .env.example .env

# Add your API keys and configuration
GOOGLE_MAPS_API_KEY=your_api_key_here
API_BASE_URL=your_backend_url
```

4. **Run the application**
```bash
# Development
flutter run

# Production build
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### Configuration

#### Android Setup
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

#### iOS Setup
```xml
<!-- ios/Runner/Info.plist -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location for emergency services</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs location access for emergency response</string>
```

## 📁 Project Structure

```
lib/
├── core/                          # Core functionality
│   ├── constants/                 # App constants
│   ├── providers/                 # Global state providers
│   │   ├── auth_provider.dart
│   │   ├── chat_provider.dart
│   │   ├── emergency_provider.dart
│   │   ├── role_provider.dart
│   │   └── user_provider.dart
│   ├── router/                    # Navigation
│   │   └── app_router.dart
│   ├── services/                  # Services
│   │   ├── emergency_service.dart
│   │   └── notification_service.dart
│   └── theme/                     # App theming
│       └── app_theme.dart
│
├── models/                        # Data models
│   ├── emergency_model.dart
│   ├── medical_profile.dart
│   └── user_model.dart
│
├── screens/                       # UI Screens
│   ├── auth/                      # Authentication
│   │   ├── login_page.dart
│   │   ├── signup_page.dart
│   │   ├── forgot_password.dart
│   │   ├── onboarding_page.dart
│   │   └── splash_screen.dart
│   │
│   ├── user/                      # User role screens
│   │   ├── home_page.dart
│   │   ├── user_profile_page.dart
│   │   ├── emergency/
│   │   │   ├── emergency_type_page.dart
│   │   │   ├── severity_selector_page.dart
│   │   │   ├── emergency_confirmation_page.dart
│   │   │   ├── active_emergency_status_page.dart
│   │   │   ├── emergency_tracking_page.dart
│   │   │   └── rate_emergency_page.dart
│   │   └── map_location/
│   │       └── aed_locator_screen.dart
│   │
│   ├── responder/                 # Responder role screens
│   │   ├── responder_dashboard_page.dart
│   │   ├── profile_screen.dart
│   │   ├── treatment_logging_page.dart
│   │   ├── earnings/
│   │   │   ├── ways_to_earn.dart
│   │   │   ├── referral_program_page.dart
│   │   │   └── my_referrals_page.dart
│   │   ├── notification/
│   │   │   ├── incoming_emergency_page.dart
│   │   │   └── responder_notifications_page.dart
│   │   ├── reward/
│   │   │   └── perks_dashboard_page.dart
│   │   └── responder form/
│   │       ├── become_responder_page.dart
│   │       ├── certification_upload_page.dart
│   │       ├── identity_verification_page.dart
│   │       ├── ethics_agreement_page.dart
│   │       └── application_success_page.dart
│   │
│   ├── messages/                  # Messaging
│   │   ├── messages_page.dart
│   │   ├── messages_inbox.dart
│   │   └── chat_page.dart
│   │
│   ├── community/                 # Community features
│   │   └── responder_community_page.dart
│   │
│   ├── medical_profile/           # Medical profile
│   │   ├── medical_profile_page.dart
│   │   ├── medical_profile_form_page.dart
│   │   ├── medical_profile_onboarding.dart
│   │   └── edit_basic_info_page.dart
│   │
│   ├── emergency_card_page.dart
│   └── settings_screen.dart
│
├── widgets/                       # Reusable widgets
│   ├── main_shell.dart           # User navigation shell
│   ├── responder_shell.dart      # Responder navigation shell
│   ├── new_chat_dialog.dart
│   └── [other widgets]
│
└── main.dart                      # App entry point
```

## 👥 User Roles

### 1. Regular User
**Primary Use Case:** Getting emergency medical help

**Journey:**
```
Sign Up → Medical Profile → Emergency Alert → Track Responder → Rate Experience
```

**Key Screens:**
- Home Dashboard
- Emergency Type Selector
- Severity Assessment
- Real-time Tracking
- Chat with Responder
- Medical Profile
- AED Locator

### 2. Certified Responder
**Primary Use Case:** Providing emergency medical assistance

**Journey:**
```
Application → Verification → Certification → Emergency Response → Treatment Logging
```

**Key Screens:**
- Responder Dashboard
- Incoming Emergencies
- Navigation to Emergency
- Treatment Logging
- Earnings & Rewards
- Network Coordination
- Community

## 🔑 Key Features Deep Dive

### Emergency Flow

```dart
// 1. User initiates emergency
EmergencyTypePage → SeveritySelectorPage → EmergencyConfirmationPage

// 2. System processes
- Determines emergency type (Medical, Trauma, CPR needed, etc.)
- Assesses severity level (Critical, High, Medium, Low)
- Notifies nearby responders within geofenced area
- Creates emergency record

// 3. Responder receives notification
IncomingEmergencyPage → Accept → Navigation → Arrival

// 4. Active emergency tracking
- User sees: ActiveEmergencyStatusPage (responder location, ETA)
- Responder sees: EmergencyTrackingPage (victim location, details)
- Both can chat in real-time

// 5. Resolution
TreatmentLoggingPage → RateEmergencyPage → Complete
```

### Chat System

**Features:**
- Real-time messaging using Riverpod providers
- Support for emergency-specific chats
- Search and filter capabilities
- Unread message badges
- Online status indicators
- Message timestamps

**Implementation:**
```dart
// ChatProvider manages all chat state
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>

// Messages for specific chat
final chatMessagesProvider = Provider.family<List<Message>, String>

// Chats with messages
final chatsWithMessagesProvider = Provider<List<Chat>>
```

### Medical Profile System

**Data Collected:**
- Personal information (name, DOB, blood type)
- Emergency contacts (multiple)
- Allergies and sensitivities
- Current medications
- Medical conditions
- Previous surgeries
- Insurance information

**Privacy:**
- Encrypted storage
- Responder access only during active emergencies
- User-controlled sharing preferences

### Responder Verification

**Multi-step Process:**
1. **Application Form** - Basic information
2. **Certification Upload** - CPR, First Aid, Medical licenses
3. **Identity Verification** - Government ID
4. **Ethics Agreement** - Code of conduct
5. **Background Check** - (External service integration)
6. **Approval** - Manual review process

### Rewards & Gamification

**Point System:**
- Emergency Response: 100-500 points (based on severity)
- Quick Response: +50 bonus (response time < 5 min)
- Positive Rating: +25 points
- Completing Profile: 50 points
- Referral: 200 points per verified responder

**Redemption Options:**
- Gift cards
- Professional certifications
- Equipment discounts
- Charitable donations

## 🔄 State Management

### Riverpod Providers

```dart
// User Authentication State
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>

// User Role Management
final userRoleProvider = StateProvider<UserRole>

// Emergency State
final emergencyProvider = StateNotifierProvider<EmergencyNotifier, EmergencyState>

// Chat Management
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>

// Location Services
final locationProvider = StreamProvider<Position>
```

### State Flow Example

```dart
// Emergency activation flow
ref.read(emergencyProvider.notifier).activateEmergency(
  type: EmergencyType.medical,
  severity: EmergencySeverity.high,
  location: currentLocation,
)

// Listen to emergency state changes
ref.listen(emergencyProvider, (previous, next) {
  if (next.isActive && next.responderAccepted) {
    // Navigate to tracking
    context.push(AppRoutes.emergencyTracking);
  }
});
```

## 🛣️ Routing

### Route Structure

```dart
class AppRoutes {
  // Auth & Onboarding
  static const splash = '/splash'
  static const login = '/login'
  static const signup = '/signup'
  
  // User Routes
  static const home = '/home'
  static const messages = '/chat'
  static const profile = '/profile'
  
  // Responder Routes
  static const responderHome = '/responder-home'
  static const responderMessages = '/responder-messages'
  static const earnings = '/earnings'
  
  // Emergency Routes
  static const emergencySelector = '/emergency-selector'
  static const activeEmergency = '/active-emergency'
  
  // Community
  static const responderCommunity = '/community'
}
```

### Navigation Examples

```dart
// Simple navigation
context.push(AppRoutes.login)

// Navigation with parameters
context.push('${AppRoutes.messages}/$chatId?name=$userName')

// Replace current route
context.go(AppRoutes.home)

// Pop back
context.pop()
```

### Shell Routes

**User Shell:**
- Home
- AED Map
- Messages
- Community

**Responder Shell:**
- Dashboard
- Community
- Messages
- Rewards
- Earnings

## 🎨 Theming

### Color Palette

```dart
// Primary Colors
const primaryRed = Color(0xFFFF3B5C)
const scaffoldBg = Color(0xFF0A0A0B)
const surfaceDark = Color(0xFF15151A)

// Status Colors
const emergencyRed = Color(0xFFFF2D55)
const successGreen = Color(0xFF10B981)
const warningOrange = Color(0xFFFF9500)

// Text Colors
const textPrimary = Colors.white
const textSecondary = Color(0xFF9CA3AF)
```

### Typography

```dart
// Headings
TextStyle.headline1: 32px, Bold
TextStyle.headline2: 24px, Bold
TextStyle.headline3: 20px, SemiBold

// Body
TextStyle.bodyText1: 16px, Regular
TextStyle.bodyText2: 14px, Regular

// Captions
TextStyle.caption: 12px, Regular
```

## 🧪 Testing

### Running Tests

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure

```
test/
├── unit/
│   ├── providers/
│   ├── models/
│   └── services/
├── widget/
│   └── screens/
└── integration/
    └── flows/
```

## 📱 Screenshots

[Add screenshots here showing:]
- Onboarding screens
- Emergency activation
- Responder tracking
- Chat interface
- Medical profile
- Responder dashboard
- Community features

## 🔐 Security

### Implemented Security Measures

- **Data Encryption** - AES-256 encryption for sensitive data
- **Secure Storage** - Flutter Secure Storage for credentials
- **HTTPS Only** - All API communications encrypted
- **Token-based Auth** - JWT authentication
- **Input Validation** - Server-side validation
- **Permission Management** - Granular location/camera permissions

### Privacy Features

- User data anonymization
- GDPR compliance ready
- Data deletion requests
- Privacy policy integration
- Consent management

## 🌐 API Integration

### Backend Requirements

The app expects a REST API with the following endpoints:

```
POST   /auth/login
POST   /auth/signup
POST   /auth/refresh

GET    /user/profile
PUT    /user/profile
POST   /user/medical-profile

POST   /emergency/create
GET    /emergency/:id
PUT    /emergency/:id/accept
PUT    /emergency/:id/complete

GET    /responders/nearby
POST   /responders/apply
GET    /responders/:id/stats

POST   /chat/create
GET    /chat/:id/messages
POST   /chat/:id/send

GET    /aed/nearby
```

## 🚧 Roadmap

### Phase 1 (Current)
- ✅ Core emergency system
- ✅ User and responder roles
- ✅ Real-time chat
- ✅ Medical profiles
- ✅ AED locator

### Phase 2 (Q2 2026)
- [ ] AR guidance integration
- [ ] Video calling during emergencies
- [ ] Offline mode support
- [ ] Multi-language support
- [ ] Advanced analytics dashboard

### Phase 3 (Q3 2026)
- [ ] AI-powered triage
- [ ] Blockchain-based certification
- [ ] IoT device integration (smartwatches, etc.)
- [ ] Community training programs
- [ ] Insurance integration

### Phase 4 (Q4 2026)
- [ ] Global expansion
- [ ] Government partnership features
- [ ] Advanced predictive algorithms
- [ ] Drone integration for AED delivery

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Coding Standards

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Write tests for new features
- Update documentation

### Commit Message Format

```
feat: Add new emergency type selector
fix: Resolve chat message ordering issue
docs: Update README with installation steps
style: Format code according to dart style
refactor: Restructure emergency provider
test: Add tests for medical profile
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community contributors
- Open source libraries used
- Medical professionals consulted

## 📞 Support

### Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

### Contact
- Email: support@lifelens.app
- Issues: [GitHub Issues](https://github.com/yourusername/ar-first-aid/issues)
- Discord: [Join our community](https://discord.gg/lifelens)

## 🔄 Changelog

### Version 1.0.0 (Current)
- Initial release
- Core emergency response system
- User and responder roles
- Real-time messaging
- Medical profile management
- AED locator
- Community features
- Rewards and earnings system

---

**Made with ❤️ and Flutter**

*Saving lives through technology*
