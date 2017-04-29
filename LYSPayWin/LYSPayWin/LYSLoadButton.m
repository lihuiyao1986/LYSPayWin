//
//  LYSLoadButton.m
//  LYSLoadingButton
//
//  Created by jk on 2017/4/20.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSLoadButton.h"
#import "MMMaterialDesignSpinner.h"


@interface LYSLoadButton (){
    UIView *_maskView;
    UIView *_indicatorView;
}

@end

@implementation LYSLoadButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

#pragma mark - 初始化配置
-(void)initConfig{
    [self setDefaults];
    [self setupUI];
}

#pragma mark - 设置默认值
-(void)setDefaults{
    _type = TYPE_ONE;
    _padding = 5.f;
    _addMask = YES;
    _isLoading = NO;
    _indicatorStyle = UIActivityIndicatorViewStyleWhite;
}

-(void)setNormalImageBgColor:(UIImage *)normalImageBgColor{
    _normalImageBgColor = normalImageBgColor;
    [self setBackgroundImage:normalImageBgColor forState:UIControlStateNormal];
    [self setBackgroundImage:normalImageBgColor forState:UIControlStateSelected];
}

-(void)setNormalText:(NSString *)normalText{
    _normalText = normalText;
    [self setTitle:normalText forState:UIControlStateNormal];
}

-(void)setNormalTextColor:(UIColor *)normalTextColor{
    _normalTextColor = normalTextColor;
    [self setTitleColor:normalTextColor forState:UIControlStateNormal];
}

-(void)setHightLightImageBgColor:(UIImage *)hightLightImageBgColor{
    _hightLightImageBgColor = hightLightImageBgColor;
    [self setBackgroundImage:hightLightImageBgColor forState:UIControlStateHighlighted];
}

-(void)setHightLightText:(NSString *)hightLightText{
    _hightLightText = hightLightText;
    [self setTitle:hightLightText forState:UIControlStateHighlighted];
}

-(void)setHightLightTextColor:(UIColor *)hightLightTextColor{
    _hightLightTextColor = hightLightTextColor;
    [self setTitleColor:hightLightTextColor forState:UIControlStateHighlighted];
}


#pragma mark - 更新
-(void)setupUI{
    [self addLoadingViewByType];
}

#pragma mark - 设置类型
-(void)setType:(LYSLoadButtonType)type{
    _type = type;
    [self addLoadingViewByType];
}

-(void)setIndicatorStyle:(UIActivityIndicatorViewStyle)indicatorStyle{
    _indicatorStyle = indicatorStyle;
    [self addLoadingViewByType];
}

#pragma mark - 根据类型添加 loading视图
-(void)addLoadingViewByType{
    [_maskView removeFromSuperview];
    [_indicatorView removeFromSuperview];
    switch (self.type) {
        case TYPE_ONE:
            _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.indicatorStyle];
            ((UIActivityIndicatorView*)_indicatorView).hidesWhenStopped = YES;
            break;
        case TYPE_TWO:
            _indicatorView = [MMMaterialDesignSpinner new];
            ((MMMaterialDesignSpinner*)_indicatorView).lineWidth = 3.f;
            ((MMMaterialDesignSpinner*)_indicatorView).hidesWhenStopped = YES;
            ((MMMaterialDesignSpinner*)_indicatorView).tintColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    [self addSubview:_indicatorView];
    [self setNeedsDisplay];
}

#pragma mark - 重写 layoutSubviews
-(void)layoutSubviews{
    [super layoutSubviews];
    switch (self.type) {
        case TYPE_ONE:
            _indicatorView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame) - self.padding - 20, (CGRectGetHeight(self.frame) - 20) * 0.5, 20, 20);
            break;
        case TYPE_TWO:
            _indicatorView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame) - self.padding - CGRectGetHeight(self.frame) - 20, 10, CGRectGetHeight(self.frame) - 20, CGRectGetHeight(self.frame) - 20);
            break;
        default:
            break;
    }
}

#pragma mark - 颜色转图片
-(UIImage*)colorToImage:(UIColor*)color{
    CGRect newRect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(newRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, newRect);
    UIImage* theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)setDisabledBgImage:(UIImage *)disabledBgImage{
    _disabledBgImage = disabledBgImage;
    [self setBackgroundImage:disabledBgImage forState:UIControlStateDisabled];
}

-(void)setDisabledText:(NSString *)disabledText{
    _disabledText = disabledText;
    [self setTitle:disabledText forState:UIControlStateDisabled];
}

-(void)setDisabledTextColor:(UIColor *)disabledTextColor{
    _disabledTextColor = disabledTextColor;
    [self setTitleColor:disabledTextColor forState:UIControlStateDisabled];
}

#pragma mark - 开始加载
-(void)startLoading:(NSString*)loadingTxt{
    if (!self.isLoading) {
        self.enabled = NO;
        self.isLoading = YES;
        [self setTitle:loadingTxt forState:UIControlStateDisabled];
        if (self.loadingBgImage) {
            [self setBackgroundImage:self.loadingBgImage forState:UIControlStateDisabled];
        }
        if (self.loadingTextColor) {
            [self setTitleColor:self.loadingTextColor forState:UIControlStateDisabled];
        }
        if (self.addMask) {
            [self addMaskView];
        }
        switch (self.type) {
            case TYPE_ONE:
                [((UIActivityIndicatorView*)_indicatorView) startAnimating];
                break;
            case TYPE_TWO:
                [((MMMaterialDesignSpinner*)_indicatorView) startAnimating];
                break;
            default:
                break;
        }
    }
}

#pragma mark - 添加遮罩视图
-(void)addMaskView{
    [self removeMaskView];
    _maskView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _maskView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_maskView];
}

#pragma mark - 去除遮罩按钮
-(void)removeMaskView{
    [_maskView removeFromSuperview];
    _maskView = nil;
}

#pragma mark - 停止加载
-(void)stopLoading{
    if (self.isLoading) {
        self.enabled = YES;
        self.isLoading = NO;
        [self setTitle:self.disabledText forState:UIControlStateDisabled];
        [self setBackgroundImage:self.disabledBgImage forState:UIControlStateDisabled];
        [self setTitleColor:self.disabledTextColor forState:UIControlStateDisabled];
        switch (self.type) {
            case TYPE_ONE:
                [((UIActivityIndicatorView*)_indicatorView) stopAnimating];
                break;
            case TYPE_TWO:
                [((MMMaterialDesignSpinner*)_indicatorView) stopAnimating];
                break;
            default:
                break;
        }
        [self removeMaskView];
    }
}

@end
