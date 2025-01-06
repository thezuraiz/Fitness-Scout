import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AccountAndPrivacyScreen extends StatelessWidget {
  const AccountAndPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account and Privacy',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Markdown(
          padding:
              EdgeInsets.symmetric(horizontal: ZSizes.md, vertical: ZSizes.lg),
          data: '''

## Introduction
The "Account and Privacy" section of the Fitness Scout app is designed to give users full control over their personal data and account settings. This guide outlines the features and options available in this section, ensuring a secure and user-friendly experience.

---

## 1. Managing Personal Information

### Profile Details
Users can view and update their personal information, such as:
- Name
- Email
- Phone Number
- Address

### Privacy Preferences
Options to manage how much information is visible to other users or trainers within the app.

### Email Notifications
Toggle settings for receiving:
- Promotional emails
- Workout reminders
- Account alerts

---

## 2. Data Usage

### Data Analytics
Provides insights into how user data is utilized to improve app performance and user experience.

### Download Data
Option for users to download a copy of their personal data for review.

### Delete Account
Step-by-step process for permanently deleting the user account and associated data.

---

## 3. Connected Accounts

### Third-Party Integrations
Manage connections with third-party apps and services, such as:
- Fitness trackers
- Social media platforms

### Login Options
Configure login methods, including:
- Email
- Social logins (Google, Facebook)
- Biometric authentication (fingerprint, face recognition)

### Account Linking
Link multiple fitness accounts to synchronize data across platforms.

---

## 4. Security Settings

### Password Management
Change or reset the account password, with tips for creating strong and secure passwords.

### Two-Factor Authentication (2FA)
Enable 2FA for an added layer of security when logging into the app.

### Session Management
View and manage all active sessions, allowing users to log out from devices remotely if needed.

---

## 5. Privacy Policy

### Policy Overview
A clear and concise summary of the Fitness Scout's privacy policy, detailing how user data is collected, used, and protected.

### User Rights
Information about user rights concerning their data, including:
- Access
- Correction
- Deletion
- Objection to data processing

### Contact Information
Support channels for users to reach out with privacy-related queries or concerns.

---

## Conclusion
The "Account and Privacy" section is a crucial component of the Fitness Scout app, emphasizing user empowerment and data security. By providing comprehensive tools for managing personal information, connected accounts, and privacy settings, Fitness Scout ensures a safe and customizable fitness journey for all users.

''',
        ),
      ),
    );
  }
}
