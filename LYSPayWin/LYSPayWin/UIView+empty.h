//
//  UIView+empty.h
//  GisHelper
//
//  Created by jk on 2017/4/25.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (empty)

#pragma mark - 添加空视图
-(void)addEmptyView:(NSDictionary*)options;

#pragma mark - 移除空视图
-(void)removeEmptyView;

@end
