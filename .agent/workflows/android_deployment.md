---
description: How to run the app on an Android device
---

# Run on Android Device

To run the app on your physical Android device, follow these steps:

1.  **Enable Developer Mode**:
    *   Go to **Settings** > **About Phone**.
    *   Tap **Build Number** 7 times until you see "You are now a developer".

2.  **Enable USB Debugging**:
    *   Go to **Settings** > **System** > **Developer Options**.
    *   Turn on **USB Debugging**.

3.  **Connect your Device**:
    *   Connect your phone to the PC via USB.
    *   On your phone, check for a popup "Allow USB debugging?" and click **Allow**.

4.  **Run the App**:
    *   Run the command below to check if your device is connected:
        ```powershell
        flutter devices
        ```
    *   If your device is listed (e.g., `RMX2001 (mobile)`), run:
        ```powershell
        flutter run
        ```
    *   If you have multiple devices, specify the device ID:
        ```powershell
        flutter run -d <DeviceId>
        ```

5.  **Build APK (Optional)**:
    *   If you just want the APK file to install manually:
        ```powershell
        flutter build apk --release
        ```
    *   The file will be at: `build/app/outputs/flutter-apk/app-release.apk`
