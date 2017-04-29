//
//  LYSPaywayListItem.h
//  LYSPayWin
//
//  Created by jk on 2017/4/29.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSPaywayListItem : NSObject

@property(nonatomic,copy)NSString *payChannelCode;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *paywayName;

@property(nonatomic,copy)NSString *cardNo;

@property(nonatomic,copy)NSString *cardType;

@property(nonatomic,assign)BOOL selected;

@end
