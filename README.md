# 📰 Vertical News Swipe Animation (Inshorts Style) - UIKit
 
An iOS demo application built with **UIKit** that recreates the Inshorts-style vertical news feed, where users swipe up and down to navigate between full-screen news cards, one card at a time.

This project focuses on production-grade UIKit patterns using `UICollectionView` with custom layout and programmatic Auto Layout.

 

https://github.com/user-attachments/assets/78ea335b-54ef-4f7c-8e0d-dec740f99373


---

## ✨ Features

- 📱 **Full-screen vertical paging**
- 📰 **One news card per swipe** (Inshorts-style)
- 🎯 **Smooth native scrolling & snapping**
- 🧊 **Glass/blur CTA footer** using UIVisualEffectView
- ♻️ **Reusable collection view cells**
- 🏗 **Industry-standard UIKit architecture**
- 📜 **Scrollable content area** within each card
- 🎨 **Programmatic Auto Layout** (no Storyboard constraints)

---

## 🧱 Tech Stack

| Technology | Purpose |
|------------|---------|
| UIKit | Core UI framework |
| UICollectionView | Vertical paging container |
| UICollectionViewFlowLayout | Custom layout engine |
| Auto Layout | Programmatic constraints |
| UIVisualEffectView | Glassmorphism effects |
| UIScrollView | Scrollable content area |

---

## 📁 Project Structure

```
UIKit-VerticalNewsSwipe/
│
├── ViewController.swift           # Main view controller
├── Helper.swift                   # Data model & custom layout
├── Main.storyboard               # Basic setup (collection view outlet)
├── Assets.xcassets/              # Images
│   ├── Dipendar.imageset/
│   ├── Moto.imageset/
│   └── Dance.imageset/
└── Info.plist
```

---

## 🧠 How It Works

### Core Component: UICollectionView

The entire vertical feed is powered by a `UICollectionView` with custom configuration:

```swift
collectionView.isPagingEnabled = true
layout.scrollDirection = .vertical
```

**This ensures:**
- ✅ One card per screen
- ✅ Native iOS swipe physics
- ✅ Automatic snapping
- ✅ Memory-efficient cell reuse

---

## 🎨 Architecture Overview

### 1. Data Model

```swift
struct NewsItem {
    let title: String
    let content: String
    let imageName: String
    let tapToKnow: String
}
```

Simple, lightweight model for news content.

---

### 2. Custom Layout: StackedCardLayout

```swift
class StackedCardLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
```

**Purpose:**
- Ensures zero spacing between cards
- Enables true full-screen experience
- Handles z-index for proper layering

---

### 3. Custom Cell: NewsCollectionViewCell

Each cell contains three main sections:

```
┌─────────────────────────┐
│   Image View (45%)      │
│   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    │
├─────────────────────────┤
│   Scrollable Content    │
│   • Title (Bold)        │
│   • Content (Regular)   │
│                         │
├─────────────────────────┤
│   Blur Footer (10%)     │
│   "Tap to know more"    │
└─────────────────────────┘
```

---

## 📐 Full-Screen Paging Logic

Each cell is sized to exactly match the screen dimensions:

```swift
func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
) -> CGSize {
    return collectionView.bounds.size
}
```

**Result:**
- No partial cards visible
- Perfect Inshorts-style experience
- Consistent behavior across all devices

---

## 🧩 Cell Layout with Auto Layout

```swift
NSLayoutConstraint.activate([
    // Image: Top 45% of card
    newsImageView.heightAnchor.constraint(
        equalTo: contentView.heightAnchor, 
        multiplier: 0.45
    ),
    
    // Scrollable content: Middle section
    textScrollView.topAnchor.constraint(
        equalTo: newsImageView.bottomAnchor, 
        constant: 10
    ),
    textScrollView.bottomAnchor.constraint(
        equalTo: footerView.topAnchor, 
        constant: -10
    ),
    
    // Footer: Bottom 60pt
    footerView.heightAnchor.constraint(equalToConstant: 60)
])
```

---

## 🧊 Glassmorphism Footer

Apple's native blur effect creates a premium look:

```swift
let footerView = UIVisualEffectView(
    effect: UIBlurEffect(style: .systemThinMaterial)
)
```

**Benefits:**
- ✅ Real blur (not fake transparency)
- ✅ Auto-adapts to light/dark mode
- ✅ Native iOS look and feel
- ✅ System performance optimizations

---

## 📜 Scrollable Content Area

Unlike SwiftUI, this UIKit version allows **scrolling within each card**:

```swift
private let textScrollView = UIScrollView()
```

**Why this matters:**
- Long articles don't get cut off
- Users can read full content without leaving the card
- More flexible than fixed-height layouts

---

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/UIKit-VerticalNewsSwipe.git
```

2. Open the project:
```bash
cd UIKit-VerticalNewsSwipe
open NewsSwipeAppUIKit.xcodeproj
```

3. Add your images to Assets.xcassets:
   - `Dipendar.imageset`
   - `Moto.imageset`
   - `Dance.imageset`

4. Build and run (⌘ + R)

---

## 📱 Usage

### Basic Implementation

```swift
class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Apply custom layout
        let layout = StackedCardLayout()
        collectionView.collectionViewLayout = layout
        
        // 2. Enable paging
        collectionView.isPagingEnabled = true
        
        // 3. Register custom cell
        collectionView.register(
            NewsCollectionViewCell.self,
            forCellWithReuseIdentifier: NewsCollectionViewCell.identifier
        )
    }
}
```

---

## 🎯 Key Differences: UIKit vs SwiftUI

| Aspect | UIKit Version | SwiftUI Version |
|--------|---------------|-----------------|
| **Implementation** | UICollectionView | Manual DragGesture |
| **Paging** | Native `.isPagingEnabled` | Custom offset calculations |
| **Cell Reuse** | ✅ Automatic | ❌ Manual management |
| **Scrolling within card** | ✅ UIScrollView | ❌ Fixed layout |
| **Performance** | Better for large lists | Good for small lists |
| **Code Complexity** | More setup code | More gesture logic |

---

## 🧠 Why Choose UIKit for This?

### Advantages:

1. **Native Paging** - Built-in support, no manual calculations
2. **Cell Reuse** - Automatic memory management for infinite feeds
3. **Mature Ecosystem** - Battle-tested in production apps
4. **Scrollable Content** - Each card can have internal scrolling
5. **Performance** - Better for large datasets

### Use UIKit When:

- ✅ Building production apps with large feeds
- ✅ Need optimal memory management
- ✅ Want reliable, tested patterns
- ✅ Targeting older iOS versions

---

## 📊 Performance

- **Smooth 60 FPS** scrolling
- **Memory efficient** - Only 3 cells loaded at a time
- **Instant snapping** - Native UICollectionView behavior
- **Zero lag** on all devices

---
 
