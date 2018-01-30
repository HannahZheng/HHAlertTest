//
//  HHAlertView.h
//  GlobalTimes
//
//  Created by MXTH on 2018/1/30.
//  Copyright © 2018年 Hannah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define HHWeakSelf(weakSelf) __weak typeof(&*self) weakSelf = self;
#define HHStrongSelf(strongSelf) __strong typeof(&*weakSelf) strongSelf = weakSelf;
// 设置颜色
#define HHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define HHRandomColor HHColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//可设置透明度及颜色
#define HHAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define HHIsStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])

typedef enum : NSUInteger {
    HHAlertButtonTypeDefault = 0,
    HHAlertButtonTypeCancle,
} HHAlertButtonType;

@interface HHAlertView : UIView

@property (nonatomic, weak) UIViewController *withVC;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancleBtn;

@property (nonatomic, copy) void(^mySureBlock)(void);


- (void)addBtnWithType:(HHAlertButtonType)btnType btnTitle:(NSString *)btnTitle block:(void(^)(void))btnHandle;

- (void)show;
- (void)dismiss;

@end
