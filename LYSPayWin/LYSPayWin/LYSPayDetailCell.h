//
//  LYSPayDetailCell.h
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSLoadButton.h"
#import "UIColor+image.h"

typedef NS_ENUM(NSUInteger,PayDetailItemType){
    OrderDetailInfo,
    Payway,
    OrderAmt
};

@interface LYSPayDetailCellItem : NSObject

@property(nonatomic,copy)NSString* label;

@property(nonatomic,copy)NSString* value;

@property(nonatomic,assign)BOOL selectable;

@property(nonatomic,assign)PayDetailItemType type;

- (instancetype)initWithLabel:(NSString*)label value:(NSString*)value selectable:(BOOL)selectable type:(PayDetailItemType)type;

@end

@interface LYSPayDetailItem : NSObject

@property(nonatomic,copy)NSString *orderDetail;

@property(nonatomic,copy)NSString *payway;

@property(nonatomic,copy)NSString *orderAmt;

@property(nonatomic,copy)NSString *payChannelCode;

- (instancetype)initWithOrderDetail:(NSString*)orderDetail payway:(NSString*)payway orderAmt:(NSString*)orderAmt payChannelCode:(NSString*)payChannelCode;


@end

@interface LYSPayDetailItemCell : UITableViewCell

@property(nonatomic,strong)LYSPayDetailCellItem *item;

@end

@interface LYSPayDetailCell : UIView

#pragma mark - 加载按钮可点时的背景颜色
@property(nonatomic,strong)UIColor *loadBtnBgNormalColor;

#pragma mark - 加载按钮不可用时的背景颜色
@property(nonatomic,strong)UIColor *loadBtnBgDisableColor;

#pragma mark - 加载按钮的字体颜色
@property(nonatomic,strong)UIColor *loadBtnTextColor;

#pragma mark - 按钮不可点时的文字颜色
@property(nonatomic,strong)UIColor *loadBtnDisableTextColor;

#pragma mark - 加载按钮的标题
@property(nonatomic,copy)NSString *loadBtnTitle;

#pragma mark - 加载按钮正在加载时的标题
@property(nonatomic,copy)NSString *loadingBtnLoadingTitle;

#pragma mark - 加载按钮的类型
@property(nonatomic,assign)LYSLoadButtonType loadBtnType;

#pragma mark - 关闭按钮点击回调
@property(nonatomic,copy)void(^CloseBtnClickBlock)();

#pragma mark - 支付方式选择时的回调
@property(nonatomic,copy)void(^PayWayItemSelected)();

#pragma mark - 加载按钮被点击时回调
@property(nonatomic,copy)void(^LoadingBtnClickedBlock)();

#pragma mark - 订单详情信息
@property(nonatomic,strong)LYSPayDetailItem *item;

#pragma mark - 是否可以打印日志
@property(nonatomic,assign)BOOL enabledLog;

#pragma mark - 按钮停止加载
-(void)titleStopLoading;

#pragma mark - 标题开始加载
-(void)titleStartLoading;

#pragma mark - 加载按钮开始加载
-(void)loadingBtnStartLoading;

#pragma mark - 加载按钮结束加载
-(void)loadingBtnEndLoading;

@end
