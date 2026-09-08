# Sāmwaad (संवाद) — Support & Help Centre

Welcome to the **Sāmwaad Support Centre**. Sāmwaad is an accessibility-first iOS application engineered for real-time speech captioning, on-device AI speaker diarization, and smart meeting summaries.

---

## 🚀 Getting Started

1. **Create your account.** Sign in with email, Apple, or Google, then complete the guided voice calibration — three short sentences, read out loud in a quiet room.
2. **Start or join a conversation.** Tap *New Conversation* for quick live captioning on your own, or *Join Conversation* to enter a 6-digit room code shared by someone else.
3. **Follow along.** Captions appear as they're spoken — your own speech in blue, other speakers in grey, labelled once Sāmwaad recognises the voice.
4. **Review the summary.** After a session, open the summary screen for key takeaways, action items, and per-participant notes. Export it as a PDF to share.

> **Note:** You can re-calibrate or delete your voice profile any time from **Profile > Vocal Profile**, and clear saved conversations from **View Conversations > Clear All History**.

---

## 🛠️ Frequently Asked Questions (FAQ) & Troubleshooting

### 1. Captions aren't appearing (Why does Sāmwaad need Mic/Speech permissions?)
Check that Microphone and Speech Recognition are both allowed for Sāmwaad in iOS Settings → Privacy & Security. Sāmwaad can't transcribe audio without both permissions granted. Sāmwaad uses Apple's **Speech** framework to convert spoken conversation into text on screen in real time and utilizes audio buffers to identify distinct speakers using our on-device CoreML model (`VL1004`). Audio is never stored as raw recordings or uploaded to third-party servers.

### 2. Speaker labels look wrong / How do I calibrate my voice?
Recalibrate your voice profile in a quiet room with minimal background noise — a clean sample makes it easier for Sāmwaad to tell speakers apart. Labels are a best-effort match, not a verified identity, so treat them as context rather than fact when confidence is low.
To calibrate:
1. Open Sāmwaad and navigate to **Profile > Vocal Profile**.
2. Tap **Voice Calibration**.
3. Follow the 3-sentence calibration prompt in a quiet environment.
4. Once completed, your voice profile will show **"Calibrated"** and Sāmwaad will tag your utterances in blue bubbles.

### 3. How do Group Sessions work? / A group session won't sync
* **Creating a Room:** Tap **Group Sessions > Create Session**. Share the 6-digit room code with other participants.
* **Joining a Room:** Tap **Group Sessions > Join Session** and enter the host's 6-digit room code.
* **Syncing issues:** Group sessions rely on a live connection to sync captions between participants — confirm you have an active internet connection and that everyone is using the same room code.
* All group session data is protected via client-side AES-256 encryption.

### 4. Which devices support Apple Intelligence Summaries?
On-device summaries need an iPhone 15 Pro, iPhone 15 Pro Max, and all iPhone 16 models running iOS 18+. On other devices running iOS 17+, Sāmwaad uses built-in localized summarization routines.

### 5. How can I delete my data or account?
* To delete your voice profile: **Profile > Vocal Profile > Delete Profile**.
* To delete your full account and cloud data: **Profile > Delete Account**.
* To clear all conversation logs: Open **View Conversations** and select **Clear All History**.

---

## 📞 Contact & Support Channels

If you encounter any issues, bugs, or have feature suggestions:

* **Support Email:** support.samwaad@gmail.com
* **Issue Tracker:** [GitHub Issues](https://github.com/MITWPU-Group04/issues)
* **Website / Documentation:** [samwaad-app.netlify.app](https://samwaad-app.netlify.app/)
* **GitHub Repository:** [Sāmwaad GitHub Repository](https://github.com/MITWPU-Group04)
* **Organization:** MIT-WPU Faculty of Engineering & Technology (Group 4)
