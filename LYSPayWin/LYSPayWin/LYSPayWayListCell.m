//
//  LYSPayWayListCell.m
//  LYSPayWin
//
//  Created by jk on 2017/4/28.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSPayWayListCell.h"
#import "LYSPaywayListItemCell.h"


@interface LYSPayWayListCell ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *listView;

@property(nonatomic,strong)UILabel *titleLb;

@property(nonatomic,strong)UIButton *backBtn;

@end

@implementation LYSPayWayListCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(void)initConfig{
    [self setDefaults];
    [self addSubview:self.listView];
    [self addSubview:self.titleLb];
    [self.titleLb addSubview:self.backBtn];
}

-(void)setDefaults{
    _titleText = @"付款方式";
}

-(void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    self.titleLb.text = self.titleText;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLb.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 44.f);
    self.backBtn.frame = CGRectMake(0, 0, CGRectGetHeight(self.titleLb.frame), CGRectGetHeight(self.titleLb.frame));
    self.listView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLb.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) -CGRectGetMaxY(self.titleLb.frame));
}

#pragma mark - 列表视图
-(UITableView *)listView{
    if (!_listView) {
        _listView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.showsVerticalScrollIndicator = NO;
        [_listView registerClass:[LYSPaywayListItemCell class] forCellReuseIdentifier:NSStringFromClass([LYSPaywayListItemCell class])];
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.backgroundColor = [UIColor clearColor];
        _listView.delegate = self;
        _listView.dataSource = self;
    }
    return _listView;
}

#pragma mark - 标题
-(UILabel*)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.userInteractionEnabled = YES;
        _titleLb.textColor = [UIColor hexString:@"414141" alpha:1.0];
        _titleLb.numberOfLines = 1;
        _titleLb.layer.borderWidth = 0.5;
        _titleLb.text = self.titleText;
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.layer.borderColor = [UIColor hexString:@"e3e2e2" alpha:1.0].CGColor;
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLb;
}

-(void)setItems:(NSArray<LYSPaywayListItem *> *)items{
    _items = items;
    [self.listView reloadData];
}

#pragma mark - 返回按钮
-(UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"LYSPayWin.bundle/arrow_left"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"LYSPayWin.bundle/arrow_left"] forState:UIControlStateHighlighted];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

#pragma mark - 返回按钮被点击
-(void)backBtnClicked:(UIButton*)sender{
    if (self.BackBtnClicked) {
        self.BackBtnClicked();
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.items enumerateObjectsUsingBlock:^(LYSPaywayListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = indexPath.row == idx;
    }];
    [self.listView reloadData];
    if(self.ItemSelectedBlock){
        self.ItemSelectedBlock(self.items[indexPath.row]);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYSPaywayListItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYSPaywayListItemCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.item = [self.items objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

-(void)dealloc{
    if (self.enabledLog) {
        NSLog(@"%@ was dealloc",NSStringFromClass([self class]));
    }
}
@end
