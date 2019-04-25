//
// Created by Luo Wei on 2017/11/24.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "LWMaskProgressView.h"
#import "CircleProgressBar.h"
#import "Masonry.h"


@interface LWMaskProgressView ()
@property(nonatomic, copy) void (^dismissBlock)();
@end

@implementation LWMaskProgressView {
}

+ (void)showMaskProgressViewin:(UIView *)view withText:(NSString *)text
                      progress:(CGFloat)progress  dismissBlock:(void (^)())dismissBlock {
    if(!view){
        return;
    }
    __block LWMaskProgressView *maskProgressView = nil;
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[LWMaskProgressView class]]){
            maskProgressView = subView;
            [view bringSubviewToFront:maskProgressView];
            *stop = true;
        }
    }];
    if(!maskProgressView){
        maskProgressView = [[LWMaskProgressView alloc] initWithText:text progress:progress];
        [view addSubview:maskProgressView];
        [view bringSubviewToFront:maskProgressView];
    }else{
        [maskProgressView showWithText:text progress:progress];
    }
    maskProgressView.dismissBlock = dismissBlock;
}

+(void)dismissMaskProgressViewin:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[LWMaskProgressView class]]){
            [subView removeFromSuperview];
            *stop = true;
        }
    }];
}

- (id)initWithText:(NSString *)text progress:(CGFloat)progress {
    self = [super init];
    if (self) {
        self.backgroundColor = LWMP_RGBAHexColor(0x000000,0.5);
        self.progress = progress;
        //self.userInteractionEnabled = NO;
        [self showWithText:text progress:self.progress];

    }
    return self;
}

- (UIButton *)textBtn {
    if (!_textBtn) {
        _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _textBtn.clipsToBounds = YES;
        _textBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_textBtn setContentEdgeInsets:UIEdgeInsetsMake(4, 10, 4, 10)];
        [_textBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _textBtn.backgroundColor = LWMP_RGBHexColor(0xC8C8C8);
        _textBtn.layer.cornerRadius = 2;
        _textBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_textBtn];
        [_textBtn addTarget:self action:@selector(textBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _textBtn;
}

-(CircleProgressBar *)circleProgressBar {
    if(!_circleProgressBar){
        _circleProgressBar = [[CircleProgressBar alloc] init];
        [self addSubview:_circleProgressBar];
        _circleProgressBar.backgroundColor = [UIColor clearColor];
        _circleProgressBar.progressBarProgressColor = [UIColor whiteColor];
        _circleProgressBar.progressBarTrackColor = [UIColor grayColor];
    }
    return _circleProgressBar;
}

- (void)showWithText:(NSString *)text progress:(CGFloat)progress {
    [self.textBtn setTitle:text forState:UIControlStateNormal];

    self.circleProgressBar.hidden = NO;
    [self bringSubviewToFront:self.circleProgressBar];
    [self.circleProgressBar setProgress:(CGFloat) progress animated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = self.superview.bounds;
}


- (void)updateConstraints {
    [super updateConstraints];

    [self.circleProgressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(50);
    }];

    [self.textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(60);
    }];
}



#pragma mark - Touch Events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //[self removeFromSuperview];
}

- (void)textBtnAction:(UIButton *)btn {
    if(self.dismissBlock){
        self.dismissBlock();
    }
    [self removeFromSuperview];
}


@end
