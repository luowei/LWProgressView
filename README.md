# LWProgressView

[![CI Status](https://img.shields.io/travis/luowei/LWProgressView.svg?style=flat)](https://travis-ci.org/luowei/LWProgressView)
[![Version](https://img.shields.io/cocoapods/v/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![License](https://img.shields.io/cocoapods/l/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![Platform](https://img.shields.io/cocoapods/p/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)

[English](./README.md) | [中文版](./README_ZH.md)

A lightweight and customizable circular progress view with mask overlay for iOS applications. LWProgressView provides an elegant way to display progress with a circular progress bar and an optional dismiss button.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Reference](#api-reference)
- [Customization](#customization)
- [Example Project](#example-project)
- [Best Practices](#best-practices)
- [Author](#author)
- [License](#license)

## Overview

LWProgressView is a lightweight iOS component that displays a circular progress indicator with a semi-transparent mask overlay. It's designed for scenarios where you need to show task progress (downloads, uploads, data synchronization, etc.) while blocking user interaction with the underlying interface. The component features a customizable cancel button and smooth progress updates, making it ideal for long-running operations that users may want to interrupt.

## Features

- **Circular Progress Display**: Beautiful circular progress bar with customizable colors
- **Mask Overlay**: Semi-transparent mask background to block user interaction during loading
- **Customizable Button**: Built-in dismiss button with customizable text and styling
- **Easy Integration**: Simple class methods for showing and dismissing progress views
- **Auto Layout Support**: Uses Masonry for flexible and responsive layout
- **Smooth Updates**: Optimized progress updates without animation for fluid display
- **Callback Support**: Dismiss block callback for handling user cancellation
- **Memory Efficient**: Automatic view management with singleton pattern
- **Thread Safe**: Designed for safe UI updates on the main thread
- **Lightweight**: Minimal dependencies and small footprint
- **iOS 8.0+**: Compatible with iOS 8.0 and later

## Requirements

- iOS 8.0 or later
- Xcode 9.0 or later
- Objective-C

## Dependencies

- [CircleProgressBar](https://github.com/MrMage/CircleProgressBar) - Circular progress bar component
- [Masonry](https://github.com/SnapKit/Masonry) - Auto Layout framework

These dependencies are automatically handled when installing via CocoaPods or Carthage.

## Installation

### CocoaPods

LWProgressView is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'LWProgressView'
```

Then run:

```bash
pod install
```

### Carthage

Add the following line to your Cartfile:

```ruby
github "luowei/LWProgressView"
```

Then run:

```bash
carthage update
```

### Manual Installation

If you prefer manual installation:

1. Clone the repository:
   ```bash
   git clone https://github.com/luowei/LWProgressView.git
   ```
2. Drag the `LWProgressView/Classes` folder into your project
3. Install dependencies: [CircleProgressBar](https://github.com/MrMage/CircleProgressBar) and [Masonry](https://github.com/SnapKit/Masonry)

## Usage

### Quick Start

Import the header file in your view controller:

```Objective-C
#import <LWProgressView/LWMaskProgressView.h>
```

### Show Progress View

Display a progress view with text and progress value:

```Objective-C
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"Cancel"
                                  progress:0.5
                              dismissBlock:^{
    // Handle dismiss action
    NSLog(@"User tapped the dismiss button");
}];
```

### Update Progress

To update the progress, simply call the show method again with a new progress value:

```Objective-C
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"Loading..."
                                  progress:0.75
                              dismissBlock:^{
    // Handle dismiss
}];
```

### Dismiss Progress View

Remove the progress view when task is completed:

```Objective-C
[LWMaskProgressView dismissMaskProgressViewin:self.view];
```

### Complete Example

Here's a complete example showing progress from 0 to 100%:

```Objective-C
@interface ViewController ()
@property (nonatomic) int counter;
@end

@implementation ViewController

- (IBAction)startProgress:(UIButton *)sender {
    self.counter = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(updateProgress:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)updateProgress:(NSTimer *)timer {
    // Show progress with current value
    [LWMaskProgressView showMaskProgressViewin:self.view
                                      withText:@"Cancel"
                                      progress:(CGFloat)(self.counter / 100.0)
                                  dismissBlock:^{
        [timer invalidate];
        NSLog(@"Progress cancelled by user");
    }];

    // Check if complete
    if (self.counter == 100) {
        [LWMaskProgressView dismissMaskProgressViewin:self.view];
        [timer invalidate];
        return;
    }

    self.counter++;
}

@end
```

### Use Cases

LWProgressView is perfect for:

- File upload/download progress
- Data synchronization
- Video/audio loading
- Batch image processing
- Any long-running task that needs user feedback
- Operations that should be cancellable

## API Reference

### Class Methods

#### Show Progress View

```Objective-C
+ (void)showMaskProgressViewin:(UIView *)view
                      withText:(NSString *)text
                      progress:(CGFloat)progress
                  dismissBlock:(void (^)())dismissBlock;
```

**Parameters:**
- `view`: The parent view to display the progress view in
- `text`: Text to display on the dismiss button
- `progress`: Progress value from 0.0 to 1.0
- `dismissBlock`: Block to execute when the dismiss button is tapped

#### Dismiss Progress View

```Objective-C
+ (void)dismissMaskProgressViewin:(UIView *)view;
```

**Parameters:**
- `view`: The parent view containing the progress view

### Instance Methods

#### Initialize with Text and Progress

```Objective-C
- (id)initWithText:(NSString *)text progress:(CGFloat)progress;
```

#### Update Progress

```Objective-C
- (void)showWithText:(NSString *)text progress:(CGFloat)progress;
```

### Properties

```Objective-C
@property (nonatomic, strong) UIButton *textBtn;
```
The dismiss/cancel button displayed below the progress bar.

```Objective-C
@property (nonatomic, strong) CircleProgressBar *circleProgressBar;
```
The circular progress bar component that displays the visual progress.

```Objective-C
@property (nonatomic) CGFloat progress;
```
Current progress value (0.0 to 1.0).

## Customization

### Progress Bar Colors

You can customize the progress bar colors by accessing the `circleProgressBar` property:

```Objective-C
LWMaskProgressView *progressView = [[LWMaskProgressView alloc] initWithText:@"Loading" progress:0.0];
progressView.circleProgressBar.progressBarProgressColor = [UIColor blueColor];
progressView.circleProgressBar.progressBarTrackColor = [UIColor lightGrayColor];
// Add to view hierarchy
[self.view addSubview:progressView];
```

### Button Appearance

Customize the dismiss button text and styling:

```Objective-C
LWMaskProgressView *progressView = [[LWMaskProgressView alloc] initWithText:@"Cancel" progress:0.0];
[progressView.textBtn setTitle:@"Stop" forState:UIControlStateNormal];
[progressView.textBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
progressView.textBtn.backgroundColor = [UIColor redColor];
progressView.textBtn.layer.cornerRadius = 5;
progressView.textBtn.layer.masksToBounds = YES;
```

### Mask Background

The mask background uses a semi-transparent black overlay (50% opacity) by default. Customize the background:

```Objective-C
LWMaskProgressView *progressView = [[LWMaskProgressView alloc] initWithText:@"Cancel" progress:0.0];
progressView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7]; // 70% opacity
```

### Progress Bar Size

The circular progress bar is 50x50 points by default. To customize the size, you'll need to subclass and override the layout constraints.

### Default Style Configuration

- **Background**: Semi-transparent black (alpha 0.5)
- **Progress Color**: White
- **Track Color**: Gray
- **Button Background**: #C8C8C8
- **Button Text Color**: White
- **Progress Bar Size**: 50x50 points
- **Button Font**: System font 12pt

## Example Project

To run the example project and see LWProgressView in action:

1. Clone the repository:
   ```bash
   git clone https://github.com/luowei/LWProgressView.git
   cd LWProgressView
   ```

2. Install dependencies:
   ```bash
   cd Example
   pod install
   ```

3. Open the workspace:
   ```bash
   open LWProgressView.xcworkspace
   ```

4. Build and run the project (Cmd+R)

The example project demonstrates various use cases including progress updates, cancellation handling, and customization options.

## Best Practices

### 1. Always Dismiss When Complete

Make sure to call `dismissMaskProgressViewin:` when your task is complete to remove the progress view:

```Objective-C
// When task completes
[LWMaskProgressView dismissMaskProgressViewin:self.view];
```

### 2. Use Correct Progress Range

Progress values must be between 0.0 and 1.0:

```Objective-C
// Correct
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"Cancel"
                                  progress:0.75  // 75%
                              dismissBlock:nil];

// Incorrect - values outside range may cause unexpected behavior
progress:1.5  // Wrong!
progress:-0.1 // Wrong!
```

### 3. Thread Safety

Always call UI methods on the main thread:

```Objective-C
dispatch_async(dispatch_get_main_queue(), ^{
    [LWMaskProgressView showMaskProgressViewin:self.view
                                      withText:@"Cancel"
                                      progress:progress
                                  dismissBlock:nil];
});
```

### 4. Avoid Retain Cycles

The dismiss block is retained, so use weak references to avoid retain cycles:

```Objective-C
__weak typeof(self) weakSelf = self;
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"Cancel"
                                  progress:0.5
                              dismissBlock:^{
    __strong typeof(weakSelf) strongSelf = weakSelf;
    if (strongSelf) {
        [strongSelf handleDismiss];
    }
}];
```

### 5. Update Progress Efficiently

The component automatically manages view updates, so you can call the show method repeatedly without worrying about creating multiple instances:

```Objective-C
// This will update the existing progress view, not create a new one
for (int i = 0; i <= 100; i++) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [LWMaskProgressView showMaskProgressViewin:self.view
                                          withText:@"Cancel"
                                          progress:i / 100.0
                                      dismissBlock:nil];
    });
}
```

### 6. Handle User Cancellation

Always provide meaningful feedback when users cancel an operation:

```Objective-C
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"Cancel"
                                  progress:0.5
                              dismissBlock:^{
    // Stop the ongoing operation
    [self.downloadTask cancel];

    // Clean up resources
    [self cleanup];

    // Notify user
    NSLog(@"Operation cancelled by user");
}];
```

## FAQ

### How do I change the progress bar colors?

You can customize colors by accessing the `circleProgressBar` property after initialization:

```Objective-C
LWMaskProgressView *progressView = [[LWMaskProgressView alloc] initWithText:@"Cancel" progress:0.0];
progressView.circleProgressBar.progressBarProgressColor = [UIColor blueColor];
progressView.circleProgressBar.progressBarTrackColor = [UIColor lightGrayColor];
```

### How do I change the background opacity?

Modify the background color alpha value after initialization:

```Objective-C
progressView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
```

### Can I hide the cancel button?

Yes, you can hide the button after getting the progress view instance:

```Objective-C
progressView.textBtn.hidden = YES;
```

### How do I use this in Swift projects?

Create a bridging header and import the framework:

```Objective-C
#import <LWProgressView/LWMaskProgressView.h>
```

Then use it in Swift:

```Swift
LWMaskProgressView.showMaskProgressViewin(self.view,
                                         withText: "Cancel",
                                         progress: 0.5) {
    print("User cancelled operation")
}
```

### Does it support multiple simultaneous progress views?

Each view can only have one LWMaskProgressView instance. If you call `showMaskProgressViewin:` multiple times on the same view, it will update the existing progress view rather than creating new ones.

### How do I handle rotation and different screen sizes?

The component uses Masonry for Auto Layout, so it automatically adapts to screen rotation and different device sizes.

## Technical Details

### View Architecture

```
LWMaskProgressView (extends UIView)
├── CircleProgressBar (circular progress indicator)
└── UIButton (dismiss/cancel button)
```

### Layout System

- Uses **Masonry** for Auto Layout constraints
- Progress bar is centered in the view
- Button is positioned 60 points below the progress bar
- Full-screen mask overlay covers the parent view

### Animation Behavior

- Progress updates use `animated:NO` for smooth, continuous progress display
- No animation on view appearance/dismissal for instant feedback

### Memory Management

- Uses singleton pattern for automatic view management
- Automatically reuses existing instances when called on the same parent view
- Dismiss block is retained until view is dismissed or updated

## Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/AmazingFeature`
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`
4. Push to the branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

Please ensure your code follows the existing style and includes appropriate documentation.

## Author

**luowei**
- Email: luowei@wodedata.com
- GitHub: [@luowei](https://github.com/luowei)

## License

LWProgressView is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

```
MIT License

Copyright (c) 2019 luowei

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Acknowledgements

Special thanks to the following open-source projects:

- [CircleProgressBar](https://github.com/MrMage/CircleProgressBar) - Excellent circular progress bar implementation
- [Masonry](https://github.com/SnapKit/Masonry) - Simplified Auto Layout

## Links

- [GitHub Repository](https://github.com/luowei/LWProgressView)
- [CocoaPods](https://cocoapods.org/pods/LWProgressView)
- [Issue Tracker](https://github.com/luowei/LWProgressView/issues)

---

If this project helps you, please give it a star on GitHub!
