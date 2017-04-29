//
//  LYSPayDetailCell.m
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPayDetailCell.h"
#import "LYSLoadButton.h"

@implementation LYSPayDetailCellItem

- (instancetype)initWithLabel:(NSString*)label value:(NSString*)value selectable:(BOOL)selectable type:(PayDetailItemType)type
{
    self = [super init];
    if (self) {
        self.label = label;
        self.value = value;
        self.selectable = selectable;
        self.type = type;
    }
    return self;
}

@end

@implementation LYSPayDetailItem

- (instancetype)initWithOrderDetail:(NSString*)orderDetail payway:(NSString*)payway orderAmt:(NSString*)orderAmt payChannelCode:(NSString*)payChannelCode
{
    self = [super init];
    if (self) {
        self.orderDetail = orderDetail;
        self.payway = payway;
        self.orderAmt = orderAmt;
        self.payChannelCode = payChannelCode;
    }
    return self;
}

@end


@interface LYSPayDetailItemCell ()

@property(nonatomic,strong)UILabel *labelLb;

@property(nonatomic,strong)UILabel *valueLb;

@property(nonatomic,strong)UIImageView *selectIcon;

@property(nonatomic,strong)UIView *line;

@end

@implementation LYSPayDetailItemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(UIView*)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor hexString:@"e3e2e2"];
    }
    return _line;
}


-(void)initConfig{
    [self.contentView addSubview:self.labelLb];
    [self.contentView addSubview:self.valueLb];
    [self.contentView addSubview:self.selectIcon];
    [self.contentView addSubview:self.line];
}

-(UILabel*)labelLb{
    if (!_labelLb) {
        _labelLb = [UILabel new];
        _labelLb.textColor = [UIColor hexString:@"666666"];
        _labelLb.numberOfLines = 1;
        _labelLb.font = [UIFont systemFontOfSize:14];
        _labelLb.textAlignment = NSTextAlignmentLeft;
        _labelLb.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _labelLb;
}

-(UILabel*)valueLb{
    if (!_valueLb) {
        _valueLb = [UILabel new];
        _valueLb.textColor = [UIColor hexString:@"414141"];
        _valueLb.numberOfLines = 1;
        _valueLb.font = [UIFont systemFontOfSize:14];
        _valueLb.textAlignment = NSTextAlignmentRight;
        _valueLb.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _valueLb;
}

-(UIImageView*)selectIcon{
    if (!_selectIcon) {
        _selectIcon = [UIImageView new];
        _selectIcon.contentMode = UIViewContentModeRight;
        _selectIcon.image = [UIImage imageNamed:@"LYSPayWin.bundle/arrow_right"];
    }
    return _selectIcon;
}

-(void)setItem:(LYSPayDetailCellItem *)item{
    _item = item;
    if (self.item) {
        self.labelLb.text = self.item.label;
        self.valueLb.text = self.item.value;
        self.selectIcon.hidden = !self.item.selectable;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.labelLb.frame = CGRectMake(20, 0, CGRectGetWidth(self.frame) * 0.3, CGRectGetHeight(self.frame));
    self.selectIcon.frame = CGRectMake(CGRectGetWidth(self.frame) - self.selectIcon.image.size.width - 20, 0, self.selectIcon.image.size.width, CGRectGetHeight(self.frame));
    self.valueLb.frame = CGRectMake(CGRectGetMaxX(self.labelLb.frame), 0, CGRectGetMinX(self.selectIcon.frame) - CGRectGetMaxX(self.labelLb.frame) - 10.f, CGRectGetHeight(self.frame));
    self.line.frame = CGRectMake(20, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame) - 40, 0.5);
}

@end


@interface LYSPayDetailCell ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *listView;

@property(nonatomic,strong)LYSLoadButton *loadBtn;

@property(nonatomic,strong)LYSLoadButton *titleLb;

@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,copy)NSArray<LYSPayDetailCellItem*> *items;

@end

@implementation LYSPayDetailCell

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
    [self addSubview:self.titleLb];
    [self addSubview:self.listView];
    [self addSubview:self.loadBtn];
    [self.titleLb addSubview:self.closeBtn];
    [self updateOrderDetailInfo];
}

#pragma mark - 设置支付信息
-(void)setItem:(LYSPayDetailItem *)item{
    _item = item;
    [self updateOrderDetailInfo];
}

#pragma mark - 更新支付信息
-(void)updateOrderDetailInfo{
    if (self.item) {
        __weak typeof (self)MyWeakSelf = self;
        self.loadBtn.enabled = self.item.payway.length > 0;
        [self.items enumerateObjectsUsingBlock:^(LYSPayDetailCellItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.type ==  OrderDetailInfo) {
                obj.value = MyWeakSelf.item.orderDetail;
            }else if(obj.type == OrderAmt){
                obj.value = MyWeakSelf.item.orderAmt;
            }else if(obj.type == Payway){
                obj.value = MyWeakSelf.item.payway.length > 0 ? MyWeakSelf.item.payway : @"请选择付款方式";
            }
        }];
        [self.listView reloadData];
    }else{
        self.loadBtn.enabled = NO;
    }
    [self titleStopLoading];
    
}

#pragma mark - 标题开始加载
-(void)titleStartLoading{
    [self.titleLb startLoading:@"正在查询..."];
}

#pragma mark - 标题停止加载
-(void)titleStopLoading{
    [self.titleLb stopLoading];
}

#pragma mark - 设置默认值
-(void)setDefaults{
    
    LYSPayDetailCellItem *orderDetail = [[LYSPayDetailCellItem alloc]initWithLabel:@"订单信息" value:@"" selectable:NO type:OrderDetailInfo];
    LYSPayDetailCellItem *payway = [[LYSPayDetailCellItem alloc]initWithLabel:@"付款方式" value:@"" selectable:YES type:Payway];
    LYSPayDetailCellItem *orderAmt = [[LYSPayDetailCellItem alloc]initWithLabel:@"应缴金额" value:@"" selectable:NO type:OrderAmt];

    _items = @[orderDetail,payway,orderAmt];
    
    _loadBtnBgDisableColor = [UIColor hexString:@"e4e4e4"];
    _loadBtnDisableTextColor  = [UIColor hexString:@"c3c3c3"];
    
    _loadBtnBgNormalColor = [UIColor hexString:@"65c5e9"];
    _loadBtnTextColor = [UIColor whiteColor];
    
    _loadBtnTitle = @"确认付款";
    _loadBtnType = TYPE_ONE;
    
    _loadingBtnLoadingTitle = @"正在付款...";

}

#pragma mark - 关闭按钮
-(UIButton*)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"LYSPayWin.bundle/arrow_close"] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:@"LYSPayWin.bundle/arrow_close"] forState:UIControlStateHighlighted];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

#pragma mark - 关闭按钮点击
-(void)closeBtnClicked:(UIButton*)sender{
    if (self.CloseBtnClickBlock) {
        self.CloseBtnClickBlock();
    }
}

#pragma mark - 标题
-(LYSLoadButton*)titleLb{
    if (!_titleLb) {
        _titleLb = [LYSLoadButton buttonWithType:UIButtonTypeCustom];
        _titleLb.normalTextColor = [UIColor hexString:@"414141"];
        _titleLb.hightLightTextColor = [UIColor hexString:@"414141"];
        _titleLb.disabledTextColor = [UIColor hexString:@"414141"];
        _titleLb.normalText= _titleLb.disabledText = _titleLb.hightLightText = @"付款详情";
        _titleLb.addMask = NO;
        _titleLb.titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLb.indicatorStyle = UIActivityIndicatorViewStyleGray;
        _titleLb.layer.borderWidth = 0.5;
        _titleLb.layer.borderColor = [UIColor hexString:@"e3e2e2"].CGColor;
    }
    return _titleLb;
}

#pragma mark - 列表视图
-(UITableView *)listView{
    if (!_listView) {
        _listView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        [_listView registerClass:[LYSPayDetailItemCell class] forCellReuseIdentifier:NSStringFromClass([LYSPayDetailItemCell class])];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.delegate = self;
        _listView.dataSource = self;
    }
    return _listView;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LYSPayDetailCellItem *cellItem = [self.items objectAtIndex:indexPath.row];
    if (cellItem.type == Payway) {
        if (self.PayWayItemSelected) {
            self.PayWayItemSelected();
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYSPayDetailItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYSPayDetailItemCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.item = self.items[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark - 重写layoutSubviews方法
-(void)layoutSubviews{
    [super layoutSubviews];
    self.loadBtn.frame = CGRectMake(30, CGRectGetHeight(self.frame) - 64.f, CGRectGetWidth(self.frame) - 60.f, 44.f);
    self.titleLb.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44.f);
    self.closeBtn.frame = CGRectMake(0, 0, CGRectGetHeight(self.titleLb.frame), CGRectGetHeight(self.titleLb.frame));
    self.listView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLb.frame), CGRectGetWidth(self.frame), CGRectGetMinY(self.loadBtn.frame) - CGRectGetMaxY(self.titleLb.frame));
}

#pragma mark - 加载按钮
-(LYSLoadButton*)loadBtn{
    if (!_loadBtn) {
        
        _loadBtn = [LYSLoadButton buttonWithType:UIButtonTypeCustom];
        [_loadBtn addTarget:self action:@selector(loadingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _loadBtn.layer.cornerRadius = 8.f;
        _loadBtn.layer.masksToBounds = YES;
        _loadBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _loadBtn.enabled = NO;
        
        _loadBtn.normalTextColor = self.loadBtnTextColor;
        _loadBtn.normalText = self.loadBtnTitle;
        _loadBtn.normalImageBgColor = [self.loadBtnBgNormalColor toImage];
        
        _loadBtn.hightLightText = self.loadBtnTitle;
        _loadBtn.hightLightTextColor = self.loadBtnTextColor;
        _loadBtn.hightLightImageBgColor = [self.loadBtnBgNormalColor toImage];
        
        _loadBtn.disabledText = self.loadBtnTitle;
        _loadBtn.disabledBgImage = [self.loadBtnBgDisableColor toImage];
        _loadBtn.disabledTextColor = self.loadBtnDisableTextColor;
        
        _loadBtn.loadingBgImage = [self.loadBtnBgNormalColor toImage];
        _loadBtn.loadingTextColor = self.loadBtnTextColor;
        
        _loadBtn.type = self.loadBtnType;
    }
    return _loadBtn;
}

#pragma mark - 加载按钮被点击时的回调
-(void)loadingBtnClicked:(LYSLoadButton*)sender{
    if (self.LoadingBtnClickedBlock) {
        self.LoadingBtnClickedBlock();
    }
}

-(void)dealloc{
    if (self.enabledLog) {
        NSLog(@"%@ was dealloc",NSStringFromClass([self class]));
    }
}


#pragma mark - 加载按钮开始加载
-(void)loadingBtnStartLoading{
    if (!self.loadBtn.isLoading) {
        [self.loadBtn startLoading:self.loadingBtnLoadingTitle];
    }
}

#pragma mark - 加载按钮结束加载
-(void)loadingBtnEndLoading{
    if (self.loadBtn.isLoading) {
        [self.loadBtn stopLoading];
    }
}

@end
