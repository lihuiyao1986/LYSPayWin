//
//  LYSPaywayListItemCell.m
//  LYSPayWin
//
//  Created by jk on 2017/4/29.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPaywayListItemCell.h"
#import "UIColor+image.h"
#import "NSString+autoSize.h"

@interface LYSPaywayListItemCell ()

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UILabel *paywayName;

@property(nonatomic,strong)UILabel *cardNo;

@property(nonatomic,strong)UILabel *cardType;

@property(nonatomic,strong)UIImageView *checkIcon;

@property(nonatomic,strong)UIView *line;

@end

@implementation LYSPaywayListItemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initConfig];
    }
    return self;
}


-(void)initConfig{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.paywayName];
    [self.contentView addSubview:self.cardNo];
    [self.contentView addSubview:self.cardType];
    [self.contentView addSubview:self.checkIcon];
    [self.contentView addSubview:self.line];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.icon.frame = CGRectMake(10.f, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    self.paywayName.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 10.f , 0, [self.item.paywayName widthForFont:self.paywayName.font], CGRectGetHeight(self.frame));
    self.cardNo.frame = CGRectMake(CGRectGetMaxX(self.paywayName.frame), 0, [self.item.cardNo widthForFont:self.cardNo.font], CGRectGetHeight(self.frame));
    self.cardType.frame = CGRectMake(CGRectGetMaxX(self.cardNo.frame) + 4.f, 0, [self.item.cardType widthForFont:self.cardType.font], CGRectGetHeight(self.frame));
    self.checkIcon.frame = CGRectMake(CGRectGetWidth(self.frame) - self.checkIcon.image.size.width - 10.f, 0, self.checkIcon.image.size.width, CGRectGetHeight(self.frame));
    self.line.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
}

#pragma mark - 图标
-(UIImageView*)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeLeft;
    }
    return _icon;
}

#pragma mark - 设置item
-(void)setItem:(LYSPaywayListItem *)item{
    _item = item;
    if (self.item) {
        self.icon.image = [UIImage imageNamed:self.item.icon];
        self.paywayName.text = self.item.paywayName;
        self.cardNo.text = self.item.cardNo;
        self.cardType.text = self.item.cardType;
        self.checkIcon.hidden = !self.item.selected;
    }
    [self setNeedsLayout];
}

#pragma mark - 支付方式名称
-(UILabel*)paywayName{
    if (!_paywayName) {
        _paywayName = [UILabel new];
        _paywayName.textColor = [UIColor hexString:@"414141"];
        _paywayName.lineBreakMode = NSLineBreakByWordWrapping;
        _paywayName.font = [UIFont systemFontOfSize:14];
        _paywayName.numberOfLines = 0;
    }
    return _paywayName;
}

#pragma mark - 卡号
-(UILabel*)cardNo{
    if (!_cardNo) {
        _cardNo = [UILabel new];
        _cardNo.textColor = [UIColor hexString:@"414141"];
        _cardNo.font = [UIFont systemFontOfSize:14];
        _cardNo.numberOfLines = 0;
        _cardNo.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _cardNo;
}

#pragma mark - 卡类型
-(UILabel*)cardType{
    if (!_cardType) {
        _cardType = [UILabel new];
        _cardType.textColor = [UIColor hexString:@"999999"];
        _cardType.font = [UIFont systemFontOfSize:12];
        _cardType.numberOfLines = 0;
        _cardType.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _cardType;
}

#pragma mark - 选择图标
-(UIImageView*)checkIcon{
    if (!_checkIcon) {
        _checkIcon = [UIImageView new];
        _checkIcon.contentMode = UIViewContentModeRight;
        _checkIcon.image = [UIImage imageNamed:@"LYSPayWin.bundle/selected"];
    }
    return _checkIcon;
}

#pragma mark - 分割线
-(UIView*)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor hexString:@"e3e2e2"];
    }
    return _line;
}

@end
