//
//  UIView+empty.m
//  GisHelper
//
//  Created by jk on 2017/4/25.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "UIView+empty.h"

static NSInteger tag = 1000000;

@implementation UIView (empty)

#pragma mark - 添加空视图
-(void)addEmptyView:(NSDictionary*)options{
    [self removeEmptyView];
    UIView * containerView = [[UIView alloc]initWithFrame:self.bounds];
    BOOL sendToBack = options[@"sendToBack"] ? [options[@"sendToBack"] boolValue] : YES;
    UIColor *bgColor = options[@"bgColor"] ? options[@"bgColor"] : [UIColor clearColor];
    containerView.tag = tag;
    containerView.backgroundColor = bgColor;
    [self addSubview:containerView];
    if (sendToBack) {
        [self sendSubviewToBack:containerView];
    }else{
        [self bringSubviewToFront:containerView];
    }
    UIImageView *imageView = [UIImageView new];
    NSString *imageUrl = options[@"imageUrl"];
    UIImage *image = [UIImage imageNamed:imageUrl];
    imageView.image = image;
    NSString *title = options[@"title"];
    UIColor *textColor = options[@"textColor"] ? options[@"textColor"] : [self colorWithHexString:@"999999" alpha:1.0];
    CGFloat padding = options[@"padding"] ? [options[@"padding"] floatValue] : 10.f;
    CGFloat titleHeight = options[@"titleHeight"] ? [options[@"titleHeight"] floatValue] : 20.f;
    UIFont *textFont = options[@"textFont"] ? options[@"textFont"]  : [UIFont systemFontOfSize:14];
    UILabel *titleLb = [UILabel new];
    titleLb.text = title;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = textColor;
    titleLb.font = textFont;
    imageView.frame = CGRectMake((CGRectGetWidth(self.frame) - image.size.width) * 0.5, (CGRectGetHeight(self.frame) - image.size.height - padding - titleHeight) / 2, image.size.width, image.size.height);
    titleLb.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + padding, CGRectGetWidth(self.frame), titleHeight);
    [containerView addSubview:imageView];
    [containerView addSubview:titleLb];
}


#pragma mark 将16进制字符串转换成UIColor color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 移除空视图
-(void)removeEmptyView{
    UIView *emptyView = [self viewWithTag:tag];
    if (emptyView) {
        [emptyView removeFromSuperview];
        emptyView = nil;
    }
}


@end
