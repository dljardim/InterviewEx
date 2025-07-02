# 📝 Notes App (SwiftUI + SwiftData)

A lightweight, Apple Notes-style iOS app built using **SwiftUI** and **SwiftData**. This project showcases a modern iOS UI and native persistence with a focus on clean design and real-world SwiftUI architecture.

---

## 📱 Overview

This Notes app allows users to quickly write, view, and manage notes on their iOS device. Designed as a functional clone of Apple’s Notes app, it uses Swift’s newest tools to demonstrate local data storage, declarative UI, and dynamic features like live search and scroll tracking.

---

## ✨ Features

- ✅ Create, edit, and delete notes
- 🔍 Search notes by title or content
- 🕒 View timestamps for created and updated notes
- 🧽 Empty notes auto-delete when you navigate away
- 🧠 Pull-down to reveal last modified date
- 🖤 Full dark mode support
- 💡 Clean, native iOS UI using SwiftUI

---

## 🛠️ Tech Stack

| Tool           | Purpose                                      |
|----------------|----------------------------------------------|
| **SwiftUI**    | Declarative UI for building iOS interfaces   |
| **SwiftData**  | Native persistence using `@Model` and `@Query` |
| `@State` / `@Bindable` / `@Environment` | Data flow & binding |
| `NavigationStack` | iOS 16+ navigation with value-based routing |
| `Searchable`   | Built-in live search for SwiftUI views       |
| `PreferenceKey` + `GeometryReader` | Track scroll offset & UI position |

---

## 📦 File Structure

📁 NotesApp/
├── NotesApp.swift # App entry point
├── Note.swift # @Model definition
├── NotesListView.swift # Main list view with search and add
├── NotesDetailView.swift # Editor view with dynamic fields
├── ScrollOffsetKey.swift # Scroll position tracking logic
└── README.md # This file

## 🚀 Getting Started

### Prerequisites

- Xcode 15 or later
- iOS 17 SDK or higher (for SwiftData support)

### Installation

1. **Clone this repo**:
   ```bash
   git clone https://github.com/your-username/notes-app.git
   cd notes-app
Open in Xcode:
Double-click NotesApp.xcodeproj or NotesApp.xcworkspace
Build and run:
Select a simulator or device and press ⌘R

📌 Limitations
No cloud sync — notes are stored locally
No text formatting — currently plain text only
No support for folders or attachments

🔮 Roadmap / Future Features
 Rich text editing with AttributedString
 Folders or tagging for organization
 CloudKit/iCloud syncing
 Media attachments (images, audio)
 Share/export notes as text or PDF
 
🧪 Dev Notes
ScrollOffsetKey uses PreferenceKey to detect user scroll
Empty notes (no title or content) are deleted automatically on exit
Debug helpers like debugPrintClean() make it easier to inspect SwiftData models during development

📄 License
This project is released under the MIT License.
Feel free to use, modify, and share it for personal or educational projects.
