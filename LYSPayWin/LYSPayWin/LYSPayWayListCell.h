//
//  LYSPayWayListCell.h
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+image.h"
#import "LYSPaywayListItem.h"


@interface LYSPayWayListCell : UIView

@property(nonatomic,copy)NSArray<LYSPaywayListItem*> *items;

@property(nonatomic,copy)NSString *titleText;

@property(nonatomic,copy)void(^BackBtnClicked)();

@property(nonatomic,copy)void(^ItemSelectedBlock)(LYSPaywayListItem* item);

#pragma mark - 是否可以打印日志
@property(nonatomic,assign)BOOL enabledLog;

@end
