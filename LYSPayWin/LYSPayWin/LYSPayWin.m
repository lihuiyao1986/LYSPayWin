//
//  LYSPayWin.m
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPayWin.h"


@interface LYSPayWin ()

@property(nonatomic,strong)UIScrollView *containerView;

@property(nonatomic,strong)LYSPayDetailCell *payDetailView;

@property(nonatomic,strong)LYSPayWayListCell *paywayListView;

@property(nonatomic,assign)NSTimeInterval duration;

@end

@implementation LYSPayWin

#pragma mark - 初始化
- (instancetype)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initConfig];
    }
    return self;
}

#pragma mark - 滚动到订单详情页面
-(void)scrollToOrderDetail{
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
        [MyWeakSelf.containerView setContentOffset:CGPointZero animated:NO];
    }];
}

#pragma mark - 滚动到选择支付方式页面
-(void)scrollToPaywayList{
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
        [MyWeakSelf.containerView setContentOffset:CGPointMake(CGRectGetWidth(MyWeakSelf.frame), 0) animated:NO];
    }];
}

#pragma mark - 设置内容视图的高度
-(void)setContentViewH:(CGFloat)contentViewH{
    _contentViewH = contentViewH;
    [self setNeedsLayout];
}

#pragma mark - 初始化配置
-(void)initConfig{
    [self setDefaults];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.payDetailView];
    [self.containerView addSubview:self.paywayListView];
}

-(void)setDefaults{
    _bgColorAlpha = 0.8;
    _duration = 0.35;
    _contentViewH = 300.f;
    _dismissTouchOutside = NO;
}

#pragma mark - 设置背景颜色的透明度
-(void)setBgColorAlpha:(CGFloat)bgColorAlpha{
    _bgColorAlpha = bgColorAlpha;
    self.containerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:self.bgColorAlpha];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.containerView.frame, point)) {
        if (self.dismissTouchOutside) {
            [self dismiss:nil];
        }
    }
}

#pragma mark - 关闭
-(void)dismiss:(void(^)())completion{
    CGRect containerFrame = self.containerView.frame;
    containerFrame.origin.y = CGRectGetHeight(self.frame);
    __weak typeof (self)MyWeakSelf = self;
    [UIView animateWithDuration:self.duration animations:^{
        MyWeakSelf.alpha = 0;
        MyWeakSelf.containerView.frame = containerFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            if (completion) {
                completion();
            }
            [MyWeakSelf removeFromSuperview];
        }
    }];
}

-(void)setEnabledLog:(BOOL)enabledLog{
    _enabledLog = enabledLog;
    self.payDetailView.enabledLog = self.enabledLog;
    self.paywayListView.enabledLog = self.enabledLog;
}

#pragma mark - 显示
-(void)show:(void(^)())completion{
    [self showInView:nil completion:completion];
}

#pragma mark - 显示
-(void)showInView:(UIView*)view completion:(void(^)())completion{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
    [view addSubview:self];
    __weak typeof (self)MyWeakSelf = self;
    self.alpha = 0;
    [UIView animateWithDuration:self.duration animations:^{
        MyWeakSelf.alpha = 1;
        MyWeakSelf.containerView.transform = CGAffineTransformMakeTranslation(0, -MyWeakSelf.contentViewH);
    } completion:^(BOOL finished) {
        if (finished) {
            if (completion) {
                completion();
            }
        }
    }];
}

#pragma mark - 内容视图
-(UIScrollView*)containerView{
    if (!_containerView) {
        _containerView = [[UIScrollView alloc]init];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.scrollEnabled = NO;
        _containerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:self.bgColorAlpha];
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}

#pragma mark - 重写layoutSubviews方法
-(void)layoutSubviews{
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.contentViewH, CGRectGetWidth(self.frame), self.contentViewH);
    self.containerView.contentSize = CGSizeMake(2 * CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame));
    self.payDetailView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame));
    self.paywayListView.frame = CGRectMake(CGRectGetMaxX(self.payDetailView.frame), 0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(self.containerView.frame));
}

#pragma mark - 支付详情信息视图
-(LYSPayDetailCell*)payDetailView{
    if (!_payDetailView) {
        _payDetailView = [LYSPayDetailCell new];
        __weak typeof (self) MyWeakSelf = self;
        _payDetailView.CloseBtnClickBlock = ^(){
            [MyWeakSelf dismiss:nil];
        };
        _payDetailView.PayWayItemSelected = ^(){
            if (MyWeakSelf.PayWayItemSelected) {
                MyWeakSelf.PayWayItemSelected(MyWeakSelf);
            }
        };
        _payDetailView.LoadingBtnClickedBlock = ^(){
            if (MyWeakSelf.LoadingBtnClickBlock) {
                MyWeakSelf.LoadingBtnClickBlock(MyWeakSelf);
            }
        };
    }
    return _payDetailView;
}

#pragma mark - 支付方式列表视图
-(LYSPayWayListCell*)paywayListView{
    if (!_paywayListView) {
        _paywayListView = [LYSPayWayListCell new];
        __weak typeof (self) MyWeakSelf = self;
        _paywayListView.BackBtnClicked = ^(){
            [MyWeakSelf scrollToOrderDetail];
        };
        _paywayListView.ItemSelectedBlock = ^(LYSPaywayListItem *item){
            [MyWeakSelf scrollToOrderDetail];
            LYSPayDetailItem *payDetail = MyWeakSelf.payDetailView.item;
            payDetail.payway = item.paywayName;
            payDetail.payChannelCode = item.payChannelCode;
            MyWeakSelf.payDetailView.item = payDetail;
        };
    }
    return _paywayListView;
}

#pragma mark - 标题停止加载
-(void)titleStopLoading{
    [self.payDetailView titleStopLoading];
}

#pragma mark - 标题开始加载
-(void)titleStartLoading{
    [self.payDetailView titleStartLoading];
}

#pragma mark - 订单详细信息
-(void)setOrderDetail:(LYSPayDetailItem *)orderDetail{
    _orderDetail = orderDetail;
    self.payDetailView.item = self.orderDetail;
}

#pragma mark - 设置支付列表信息
-(void)setPaywayList:(NSArray<LYSPaywayListItem *> *)paywayList{
    _paywayList = paywayList;
    if (self.payDetailView.item) {
        __weak typeof (self) MyWeakSelf = self;
        [self.paywayList enumerateObjectsUsingBlock:^(LYSPaywayListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = [MyWeakSelf.payDetailView.item.payChannelCode isEqualToString:obj.payChannelCode];
        }];
    }
    self.paywayListView.items = self.paywayList;
}

#pragma mark -
-(void)dealloc{
    if(self.enabledLog){
        NSLog(@"%@ was dealloc",NSStringFromClass([self class]));
    }
}

#pragma mark - 加载按钮开始加载
-(void)loadingBtnStartLoading{
    [self.payDetailView loadingBtnStartLoading];
}

#pragma mark - 加载按钮结束加载
-(void)loadingBtnEndLoading{
    [self.payDetailView loadingBtnEndLoading];
}
@end
