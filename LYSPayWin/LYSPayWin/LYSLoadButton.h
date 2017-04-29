//
//  LYSLoadButton.h
//  LYSLoadingButton
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,LYSLoadButtonType){
    TYPE_ONE,
    TYPE_TWO
};

@interface LYSLoadButton : UIButton

@property(nonatomic,assign)LYSLoadButtonType type;

@property(nonatomic,assign)UIActivityIndicatorViewStyle indicatorStyle;

@property(nonatomic,assign)CGFloat padding;

@property(nonatomic,copy)NSString *disabledText;
@property(nonatomic,strong)UIImage *disabledBgImage;
@property(nonatomic,copy)UIColor *disabledTextColor;

@property(nonatomic,strong)UIImage *normalImageBgColor;
@property(nonatomic,strong)UIColor *normalTextColor;
@property(nonatomic,copy)NSString *normalText;


@property(nonatomic,strong)UIImage *hightLightImageBgColor;
@property(nonatomic,strong)UIColor *hightLightTextColor;
@property(nonatomic,copy)NSString *hightLightText;

@property(nonatomic,assign)BOOL addMask;

@property(nonatomic,strong)UIImage *loadingBgImage;

@property(nonatomic,strong)UIColor *loadingTextColor;

@property(nonatomic,assign)BOOL isLoading;

#pragma mark - 开始加载
-(void)startLoading:(NSString*)loadingTxt;

#pragma mark - 停止加载
-(void)stopLoading;

@end
