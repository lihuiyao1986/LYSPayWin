//
//  LYSPayWin.h
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSPayDetailCell.h"
#import "LYSPayWayListCell.h"

@interface LYSPayWin : UIView

#pragma mark - 内容视图的高度
@property(nonatomic,assign)CGFloat contentViewH;

#pragma mark - 背景视图颜色的透明度
@property(nonatomic,assign)CGFloat bgColorAlpha;

#pragma mark - 点击内容视图外面是否关闭
@property(nonatomic,assign)BOOL dismissTouchOutside;

#pragma mark - 支付列表信息
@property(nonatomic,copy)NSArray<LYSPaywayListItem*> *paywayList;

#pragma mark - 订单详情信息
@property(nonatomic,strong)LYSPayDetailItem *orderDetail;

#pragma mark - 是否可以打印日志
@property(nonatomic,assign)BOOL enabledLog;

#pragma mark - 支付方式选择时的回调
@property(nonatomic,copy)void(^PayWayItemSelected)(LYSPayWin *payWin);

#pragma mark - 付款按钮被点击时回调
@property(nonatomic,copy)void(^LoadingBtnClickBlock)(LYSPayWin *payWin);

#pragma mark - 显示
-(void)show:(void(^)())completion;

#pragma mark - 显示
-(void)showInView:(UIView*)view completion:(void(^)())completion;

#pragma mark - 关闭
-(void)dismiss:(void(^)())completion;

#pragma mark - 滚动到订单详情页面
-(void)scrollToOrderDetail;

#pragma mark - 按钮停止加载
-(void)titleStopLoading;

#pragma mark - 标题开始加载
-(void)titleStartLoading;

#pragma mark - 滚动到选择支付方式页面
-(void)scrollToPaywayList;

#pragma mark - 加载按钮开始加载
-(void)loadingBtnStartLoading;

#pragma mark - 加载按钮结束加载
-(void)loadingBtnEndLoading;

@end
