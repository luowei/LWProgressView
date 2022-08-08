# LWProgressView

[![CI Status](https://img.shields.io/travis/luowei/LWProgressView.svg?style=flat)](https://travis-ci.org/luowei/LWProgressView)
[![Version](https://img.shields.io/cocoapods/v/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![License](https://img.shields.io/cocoapods/l/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![Platform](https://img.shields.io/cocoapods/p/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```Objective-C
- (IBAction)btnAction:(UIButton *)sender {

    self.counter = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self selector:@selector(scheduleTimer:) userInfo:nil repeats:YES];

}


- (void)scheduleTimer:(NSTimer *)timer {

    [LWMaskProgressView showMaskProgressViewin:self.view withText:@"取消" progress:(CGFloat) (self.counter / 100.0) dismissBlock:^{
    }];

    if (self.counter == 100) {
        [LWMaskProgressView dismissMaskProgressViewin:self.view];
        [timer invalidate];
        return;
    }

    NSLog(@"===counter:%d", self.counter);
    self.counter++;

}

```

## Requirements

## Installation

LWProgressView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LWProgressView'
```

**Carthage**
```ruby
github "luowei/LWProgressView"
```

## Author

luowei, luowei@wodedata.com

## License

LWProgressView is available under the MIT license. See the LICENSE file for more info.
