//
//  ViewController.m
//  HHAlertViewTest
//
//  Created by MXTH on 2018/1/30.
//  Copyright © 2018年 Hannah. All rights reserved.
//

#import "ViewController.h"
#import "HHAlertView.h"

@interface ViewController ()

@property (nonatomic, strong) HHAlertView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
}
- (IBAction)show:(id)sender {
    
    [self.alertView show];
}



- (HHAlertView *)alertView{
    if (_alertView == nil) {
        _alertView = [[HHAlertView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_alertView];
        _alertView.message = @"只有升级成正式店主可以提现";
        _alertView.detailLabel.textAlignment = NSTextAlignmentCenter;
        _alertView.detailLabel.font = [UIFont boldSystemFontOfSize:15];

        [_alertView addBtnWithType:HHAlertButtonTypeDefault btnTitle:@"去升级" block:^{
            
        }];
        [_alertView addBtnWithType:HHAlertButtonTypeCancle btnTitle:@"再等等" block:nil];
    }
    return _alertView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
