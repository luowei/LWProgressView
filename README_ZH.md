# LWProgressView

[![CI Status](https://img.shields.io/travis/luowei/LWProgressView.svg?style=flat)](https://travis-ci.org/luowei/LWProgressView)
[![Version](https://img.shields.io/cocoapods/v/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![License](https://img.shields.io/cocoapods/l/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)
[![Platform](https://img.shields.io/cocoapods/p/LWProgressView.svg?style=flat)](https://cocoapods.org/pods/LWProgressView)

## 简介

LWProgressView 是一个轻量级的 iOS 饼状进度条组件，提供了美观的环形进度显示和遮罩效果。该组件适用于需要在应用中展示任务进度、下载进度、上传进度等场景。

## 特性

- 🎯 饼状环形进度条显示
- 🎨 半透明遮罩背景
- 🔘 可自定义按钮文本（如"取消"）
- 📱 支持 iOS 8.0 及以上版本
- ⚡️ 轻量级，易于集成
- 🔄 自动管理视图的显示和隐藏
- 💪 支持 CocoaPods 和 Carthage

## 系统要求

- iOS 8.0 或更高版本
- Xcode 9.0 或更高版本
- Objective-C

## 安装

### CocoaPods

LWProgressView 可以通过 [CocoaPods](https://cocoapods.org) 安装。只需在你的 Podfile 中添加以下内容：

```ruby
pod 'LWProgressView'
```

然后运行：

```bash
pod install
```

### Carthage

如果你使用 Carthage，可以在 Cartfile 中添加：

```ruby
github "luowei/LWProgressView"
```

然后运行：

```bash
carthage update
```

## 使用方法

### 基本用法

```objective-c
#import <LWProgressView/LWMaskProgressView.h>

// 显示进度视图
[LWMaskProgressView showMaskProgressViewin:self.view
                                  withText:@"取消"
                                  progress:0.5
                              dismissBlock:^{
    // 用户点击按钮时的回调
    NSLog(@"用户取消了操作");
}];

// 隐藏进度视图
[LWMaskProgressView dismissMaskProgressViewin:self.view];
```

### 完整示例

以下是一个模拟进度更新的完整示例：

```objective-c
@interface LWViewController ()
@property(nonatomic) int counter;
@end

@implementation LWViewController

- (IBAction)btnAction:(UIButton *)sender {
    // 初始化计数器
    self.counter = 0;

    // 创建定时器，每 0.05 秒更新一次进度
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(scheduleTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)scheduleTimer:(NSTimer *)timer {
    // 更新进度视图
    [LWMaskProgressView showMaskProgressViewin:self.view
                                      withText:@"取消"
                                      progress:(CGFloat)(self.counter / 100.0)
                                  dismissBlock:^{
        // 用户点击取消按钮
        [timer invalidate];
        NSLog(@"操作已取消");
    }];

    // 进度完成
    if (self.counter == 100) {
        [LWMaskProgressView dismissMaskProgressViewin:self.view];
        [timer invalidate];
        return;
    }

    NSLog(@"===counter:%d", self.counter);
    self.counter++;
}

@end
```

## API 文档

### LWMaskProgressView

主要类，提供进度视图的显示和管理功能。

#### 类方法

##### showMaskProgressViewin:withText:progress:dismissBlock:

显示或更新进度视图。

```objective-c
+ (void)showMaskProgressViewin:(UIView *)view
                      withText:(NSString *)text
                      progress:(CGFloat)progress
                  dismissBlock:(void (^)())dismissBlock;
```

**参数：**

- `view`: 进度视图要添加到的父视图
- `text`: 按钮上显示的文本（通常为"取消"）
- `progress`: 当前进度值，范围 0.0 到 1.0
- `dismissBlock`: 用户点击按钮时的回调 block

**说明：**

- 如果视图中已存在进度视图，会自动更新进度而不是创建新的视图
- 进度视图会自动置于最上层显示
- 半透明黑色背景会覆盖整个父视图

##### dismissMaskProgressViewin:

隐藏并移除进度视图。

```objective-c
+ (void)dismissMaskProgressViewin:(UIView *)view;
```

**参数：**

- `view`: 包含进度视图的父视图

#### 实例方法

##### initWithText:progress:

初始化进度视图实例。

```objective-c
- (id)initWithText:(NSString *)text
          progress:(CGFloat)progress;
```

**参数：**

- `text`: 按钮上显示的文本
- `progress`: 初始进度值，范围 0.0 到 1.0

##### showWithText:progress:

更新进度视图的显示。

```objective-c
- (void)showWithText:(NSString *)text
            progress:(CGFloat)progress;
```

**参数：**

- `text`: 按钮上显示的文本
- `progress`: 当前进度值，范围 0.0 到 1.0

#### 属性

```objective-c
@property(nonatomic, strong) UIButton *textBtn;              // 取消按钮
@property(nonatomic, strong) CircleProgressBar *circleProgressBar;  // 环形进度条
@property(nonatomic) CGFloat progress;                       // 当前进度值
```

## 自定义配置

### 颜色定制

LWProgressView 在头文件中提供了颜色宏定义，你可以修改这些宏来自定义颜色：

```objective-c
#define LWMP_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define LWMP_RGBAHexColor(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
#define LWMP_RGBHexColor(hexValue) LWMP_RGBAHexColor(hexValue, 1)
```

### 默认样式

- **背景色**：半透明黑色 (alpha 0.5)
- **进度条颜色**：白色
- **进度条轨道颜色**：灰色
- **按钮背景色**：#C8C8C8
- **按钮文字颜色**：白色
- **进度条大小**：50x50 点
- **按钮字体**：系统字体 12pt

## 依赖

LWProgressView 依赖以下第三方库：

- [CircleProgressBar](https://github.com/Eclair/CircleProgressBar) - 提供环形进度条功能
- [Masonry](https://github.com/SnapKit/Masonry) - 用于自动布局

这些依赖会在通过 CocoaPods 或 Carthage 安装时自动处理。

## 运行示例项目

要运行示例项目，请按以下步骤操作：

1. 克隆仓库：
```bash
git clone https://github.com/luowei/LWProgressView.git
cd LWProgressView
```

2. 安装依赖：
```bash
cd Example
pod install
```

3. 打开工作空间：
```bash
open LWProgressView.xcworkspace
```

4. 运行项目即可查看效果

## 使用场景

LWProgressView 适用于以下场景：

- 文件上传/下载进度显示
- 数据同步进度显示
- 任务处理进度显示
- 视频/音频加载进度
- 图片批量处理进度
- 任何需要可取消的进度展示场景

## 注意事项

1. **线程安全**：建议在主线程中调用 UI 更新方法
2. **内存管理**：进度视图会自动管理，无需手动释放
3. **视图层级**：进度视图会自动添加到指定父视图的最上层
4. **重复调用**：多次调用 `showMaskProgressViewin` 不会创建多个视图，而是更新现有视图
5. **dismiss block**：每次调用 `showMaskProgressViewin` 都会更新 dismissBlock

## 技术实现细节

### 视图结构

```
LWMaskProgressView (继承自 UIView)
├── CircleProgressBar (环形进度条)
└── UIButton (取消按钮)
```

### 布局方式

- 使用 Masonry 进行自动布局
- 进度条居中显示
- 按钮位于进度条下方 60 点处

### 动画效果

- 进度更新不带动画（animated:NO），确保流畅的进度展示
- 视图的添加和移除无动画效果

## 版本历史

### 1.0.0
- 初始版本发布
- 支持基本的进度显示功能
- 支持自定义按钮文本
- 支持用户取消操作

## 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目。

### 如何贡献

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 作者

**luowei**
- Email: luowei@wodedata.com
- GitHub: [@luowei](https://github.com/luowei)

## 许可证

LWProgressView 基于 MIT 许可证开源。详见 [LICENSE](LICENSE) 文件。

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

## 相关链接

- [GitHub 仓库](https://github.com/luowei/LWProgressView)
- [CocoaPods](https://cocoapods.org/pods/LWProgressView)
- [问题反馈](https://github.com/luowei/LWProgressView/issues)

## 常见问题

### Q: 如何修改进度条的颜色？

A: 你可以在实例化后直接修改 `circleProgressBar` 的属性：

```objective-c
LWMaskProgressView *progressView = [[LWMaskProgressView alloc] initWithText:@"取消" progress:0.0];
progressView.circleProgressBar.progressBarProgressColor = [UIColor blueColor];
progressView.circleProgressBar.progressBarTrackColor = [UIColor lightGrayColor];
```

### Q: 如何修改背景透明度？

A: 修改 `LWMaskProgressView.m` 文件中的初始化方法，调整背景色的 alpha 值。

### Q: 可以隐藏取消按钮吗？

A: 可以，在获取到进度视图实例后设置：

```objective-c
progressView.textBtn.hidden = YES;
```

### Q: 如何在 Swift 项目中使用？

A: 创建桥接头文件并导入：

```objective-c
#import <LWProgressView/LWMaskProgressView.h>
```

然后在 Swift 中直接使用：

```swift
LWMaskProgressView.showMaskProgressViewin(self.view,
                                         withText: "取消",
                                         progress: 0.5) {
    print("用户取消了操作")
}
```

## 致谢

感谢以下开源项目：

- [CircleProgressBar](https://github.com/Eclair/CircleProgressBar) - 提供优秀的环形进度条实现
- [Masonry](https://github.com/SnapKit/Masonry) - 简化自动布局代码

---

如果这个项目对你有帮助，请给个 Star！⭐️
