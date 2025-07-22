# Take-Home Project: Mobile Solutions Engineer

### Objective

Assess how you:

1. Create a SwiftUI Demo App that uses the SmartSpectra-Swift-SDK
2. Document and teach other developers to repeat the integration.

You’ll work solo - mirroring the independent prep a Developer-Advocate does before showing a prospect.

### Task Overview

You’ll create a small demo app or “customer-starter kit” called FitPulseDemo using SmartSpectra Swift SDK.

You will need to obtain an api key from https://physiology.presagetech.com/ for a working demo.

Link to the SmartSpectra SDK: https://github.com/Presage-Security/SmartSpectra

Additional instructions for authentication: https://github.com/Presage-Security/SmartSpectra/blob/main/docs/authentication.md

## Requirements

### 1. Production-Ready App

_Required_

* Integrate SmartSpectra-Swift-SDK via Swift Package Manager (pin the version).
* Request camera permission, stream Heart Rate (BPM) at ≥ 1 Hz with current minimum, maximum and average for pulse also shown at the same interval. Hints: Use continuous measurement mode, and headless version of the sdk
* Light & Dark-mode layouts, graceful error/permission handling.
* Add at least one SwiftTest that asserts functionalities.

### 2. Performance Note

_Required_

* Record 30 s in Instruments → Time Profiler (real device).
* Paste a screenshot into README.md and describe one optimization you’d ship next.

### 3. Developer-Enablement Docs

_Required_

1. <u>__QuickStart.md__</u> (≤ 1 pages)
    * Step-by-step import & setup (with code snippets).
    * Common “gotchas” (e.g., privacy strings, sim/device issues).
    * How to request an API key.

2. <u>__FAQ.md__</u> (≤ 5 Q/A) – must include answers to:
    * “Does the SDK work offline?”
    * “How do I add a real-time chart?”
    * “How do I reduce CPU usage on older iPhones?” Add any extra questions you think a customer would ask.

### 4. Optional Bonus (extra credit)

If you have other ideas to improve the SDK, app, or automation, feel free to implement them! Creativity and problem-solving are valuable, and we’d love to see how you optimize or extend the project in your own way.

## Evaluation Criteria

* Demo Functionality & UX: Smooth BPM updates, polished UI, error handling, dark-mode.
* Performance Insight: Screenshot + actionable optimization.
* QuickStart Doc: Clear, junior-friendly, zero ambiguity, good code snippets.
* FAQ / Support Mindset: Accurate, empathetic answers, anticipates pain points.
* Code Quality, Security & Tests: Idiomatic Swift, SwiftTest passes, no secrets in repo.
* Stretch / Initiative: Any bonus delivered well & documented.

## Estimated Time

This project should take about 1.5-3 hours. Within that time, we hope to get a clearer sense of your approach to building a production-ready demo app and how you advocate for your work.

We look forward to your submission! Let us know if you have any questions via replying to the email.

## Submission Guidelines

1. GitHub repo (public or private). If private, invite ashraful@presagetech.com
2. Use meaningful commit messages—we value seeing your thought process.
3. Do not embed API key in the repo
4. Email the repo URL.

Good luck, and have fun bringing life to every app!
