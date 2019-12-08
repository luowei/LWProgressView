//
// Created by Luo Wei on 2017/11/24.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色及主题设置
#define LWMP_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define LWMP_RGBAHexColor(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
#define LWMP_RGBHexColor(hexValue) LWMP_RGBAHexColor(hexValue, 1)

@class CircleProgressBar;


@interface LWMaskProgressView : UIView

@property(nonatomic, strong) UIButton *textBtn;
@property(nonatomic, strong) CircleProgressBar *circleProgressBar;

@property(nonatomic) CGFloat progress;

+ (void)showMaskProgressViewin:(UIView *)view withText:(NSString *)text progress:(CGFloat)progress dismissBlock:(void (^)())dismissBlock;

+(void)dismissMaskProgressViewin:(UIView *)view;

- (id)initWithText:(NSString *)text progress:(CGFloat)progress;

- (void)showWithText:(NSString *)text progress:(CGFloat)progress;

@end