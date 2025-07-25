#  Quick Start

## Overview

This is a small demonstration app introducing some of the features provided by the SmartSpectra SDK from Presage Technologies. It tracks a subjects pulse rate and breathing rates utilizing the devices camera.

## Things to know

- This was written in XCode version 16.3.
- The minimum deployment target is iOS 16.6.
- This uses the devices front camera which will require a user's permission. It also means that it will not work on a Simulator.
- The SmartSpectra SDK requires an API Key for Presage's Physiology API.

## Get FitPulseDemo

Download or Clone the FitPulseDemo application from GitHub: https://github.com/FStrout/FitPulseDemo

## Add the SmartSpectra SDK

These are the steps I used to install the SmartSpectra SDK to this demo app.
  1. Select the top level FitPulseDemo in the Project navigator.
  2. In the Project/Target pane select FitPulseDemo under the Project heading.
  3. From the tabs that get displayed across the top, select the Project Dependencies tab.
  4. Select the '+' button to add a new package dependency.
  5. Copy this link: https://github.com/Presage-Security/SmartSpectra, and paste it in the Search or enter URL box that is displayed in the upper right corner of the new window that we just opened.
  6. In the Dependency Rule box, make sure 'Branch' is selected and ‘main’ is in the textbox next to it. Select the Add Package button in the lower right.
  7. In the new window, under the Add to Target, select 'FitPulseDemo'. Select the Add Package button.

### Congratulations! You just added the SmartSpectra SDK to the application.

## Get an API Key

  1. Go to [https://physiology.presagetech.com](https://physiology.presagetech.com).
  2. Tap the 'Get Your API Key Now' button.
  3. For demonstration purposes, the Free plan will be sufficient. Tap the 'Register Now' button.
  4. Fill out the form.
  5. Presage will send you a confirmation email which will navigate you to a login screen after you Verify your Email.
  6. After you login, you will be brought to your dashboard which will contain your APY Key.
  7. Copy your API Key and use it as you need.

_Follow your organizations current policies and best practices for storing the API Key for Presage's Physiology API._

It's never a good idea to store API Keys in GitHub. As such, you will not find my API Key here. What I did for the FitPulseDemo application - I created a LocalKeys object to store my keys locally and I made sure that the file was ignored using gitignore AND NOT tracked.

```
struct LocalKeys {
  static let physiologyApiKey: String = "presage_physiology_api_key"
}
```

Then I would set the key by direct reference.
```
sdk.setApiKey(LocalKeys.physiologyApiKey)
```
