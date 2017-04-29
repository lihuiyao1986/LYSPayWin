//
//  ViewController.m
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "ViewController.h"
#import "LYSPayWin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 120, self.view.frame.size.width, 44);
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnclick{
    LYSPayWin *payWin = [LYSPayWin new];
    payWin.contentViewH = 300.f;
    __weak typeof (self)MyWeakSelf = self;
    payWin.enabledLog = YES;
    payWin.PayWayItemSelected = ^(LYSPayWin *window){
        [window titleStartLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [window titleStopLoading];
            window.paywayList = [MyWeakSelf paywayList];
            [window scrollToPaywayList];
        });
    };
    payWin.LoadingBtnClickBlock = ^(LYSPayWin *window){
        [window loadingBtnStartLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [window loadingBtnEndLoading];
            [window dismiss:^{}];
        });
    };
    [payWin show:^{
        payWin.orderDetail = [[LYSPayDetailItem alloc]initWithOrderDetail:@"物联网表充值" payway:@"微信支付" orderAmt:@"100元" payChannelCode:@"10002"];
    }];
}

-(NSArray*)paywayList{
    LYSPaywayListItem *webchat = [[LYSPaywayListItem alloc]init];
    webchat.paywayName = @"微信支付";
    webchat.icon = @"LYSPayIcon.bundle/webchat_pay_icon";
    webchat.selected = YES;
    webchat.payChannelCode = @"10002";
    LYSPaywayListItem *alipay = [[LYSPaywayListItem alloc]init];
    alipay.paywayName = @"支付宝";
    alipay.icon = @"LYSPayIcon.bundle/alipay_pay_icon";
    alipay.selected = NO;
    alipay.payChannelCode = @"10006";
    return @[webchat,alipay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
