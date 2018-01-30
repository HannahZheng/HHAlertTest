//
//  HHAlertView.m
//  GlobalTimes
//
//  Created by MXTH on 2018/1/30.
//  Copyright © 2018年 Hannah. All rights reserved.
//

#import "HHAlertView.h"

@interface HHAlertView()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *verLine;

@property (nonatomic, copy) void(^blockHandle)(void);
@property (nonatomic, strong) NSMutableArray *btnArr;

@end

@implementation HHAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = HHAlphaColor(0, 0, 0, 0.5);
    self.hidden = YES;
    self.btnArr = [NSMutableArray array];
    
    [self bgView];
    [self detailLabel];
    [self sureBtn];
    //    [self cancleBtn];
    
    UIView *line = [UIView new];
    line.backgroundColor = HHColor(209, 209, 209);
    [self.bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView).offset(-42);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(0.5);
    }];
    
    _verLine = [UIView new];
    _verLine.hidden = YES;
    _verLine.backgroundColor = HHColor(209, 209, 209);
    [self.bgView addSubview:_verLine];
    [_verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(0.5, 42));
    }];
}

#pragma mark load lazy
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 7;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(285);
        }];
    }
    
    return _bgView;
}

- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
        _sureBtn.hidden = YES;
        [_sureBtn setTitleColor:HHColor(229, 0, 17) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_sureBtn addTarget:self action:@selector(didClickedSureBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.left.right.bottom.equalTo(self.bgView);
        }];
        
        
    }
    
    return _sureBtn;
}

- (UIButton *)cancleBtn{
    if (_cancleBtn == nil) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.hidden = YES;
        [_cancleBtn setTitleColor:HHColor(51, 51, 51) forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_cancleBtn];
        [_cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.left.right.equalTo(self.bgView);
        }];
    }
    
    return _cancleBtn;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = HHColor(51, 51, 51);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        [self.bgView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(14);
            make.top.equalTo(self.bgView).offset(28); make.width.mas_equalTo(257);
        }];
    }
    
    return _detailLabel;
}

#pragma mark set

- (void)setMessage:(NSString *)message{
    if (HHIsStrValid(message)) {
        _message = message;
        self.detailLabel.text = message;
        NSMutableParagraphStyle *paraSty = [[NSMutableParagraphStyle alloc] init];
        paraSty.lineSpacing = 5;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:message attributes:@{NSParagraphStyleAttributeName: paraSty}];
        self.detailLabel.attributedText = attrStr;
        
    }
}

#pragma mark event
- (void)addBtnWithType:(HHAlertButtonType)btnType btnTitle:(NSString *)btnTitle block:(void(^)(void))btnHandle{
    
    if (btnType == HHAlertButtonTypeDefault) {
        self.sureBtn.hidden = NO;
        [self.sureBtn setTitle:btnTitle forState:UIControlStateNormal];
        [self.btnArr addObject:self.sureBtn];
        if (btnHandle) {
            self.mySureBlock = btnHandle;
        }
        
    }else{
        self.cancleBtn.hidden = NO;
         [self.cancleBtn setTitle:btnTitle forState:UIControlStateNormal];
        [self.btnArr insertObject:self.cancleBtn atIndex:0];
    }
    
}

- (void)didClickedSureBtn:(UIButton *)sender{
    if (self.mySureBlock) {
        self.mySureBlock();
    }
    if (self.blockHandle) {
        self.blockHandle();
    }
    [self dismiss];
}

#pragma mark 布局调整
- (void)layout{
    if (self.btnArr.count == 0) {
        [self addBtnWithType:HHAlertButtonTypeDefault btnTitle:@"知道了" block:nil];
    }
    if (self.btnArr.count == 1) {
    
        UIButton *btn = self.btnArr[0];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.left.right.bottom.equalTo(self.bgView);
        }];
    }else{
        self.verLine.hidden = NO;
        [_cancleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.left.bottom.equalTo(self.bgView);
            make.right.mas_equalTo(self.verLine.mas_left);
        }];
        [_sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(42);
            make.right.bottom.equalTo(self.bgView);
             make.left.mas_equalTo(self.verLine.mas_right);
        }];
    }
    
    CGFloat height = [self.detailLabel sizeThatFits:CGSizeMake(257, CGFLOAT_MAX)].height;
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height+1+42+28+24);
    }];
    
//    [self layoutIfNeeded];
//    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(CGRectGetMaxY(self.cancleBtn.frame));
//    }];
}

#pragma mark 出现与消失
- (void)show{
    [self layout];
    //    关键帧 动画 设置关键帧的属性
    self.hidden = NO;
    CAKeyframeAnimation *keyAnimtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyAnimtion.values = @[@(0.0),@(0.8), @(1.15), @(0.9), @(1.0)];
    keyAnimtion.duration = 0.4;
    [self.bgView.layer addAnimation:keyAnimtion forKey:@"key"];
    
}

- (void)dismiss{
    //    关键帧 动画 设置关键帧的属性
    CAKeyframeAnimation *keyAnimtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyAnimtion.values = @[@(0.9),@(1.0), @(1.15), @(0.5),@(0.0)];
    keyAnimtion.duration = 0.4;
    [self.bgView.layer addAnimation:keyAnimtion forKey:@"key"];
    
    //    延时函数
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.2f];
}
- (void)delayMethod{
    self.hidden = YES;
}

@end
