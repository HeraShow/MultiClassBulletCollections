//
//  WMMoveGoodToView.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMMoveGoodToGroupView.h"
#import "WMPreMenuHeaderView.h"
#import "WMSecMenuTableViewCell.h"
#import "WMGroupListModel.h"

@interface WMMoveGoodToGroupView() <UITableViewDelegate, UITableViewDataSource, PreMenuDelegate, SecMenuDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) NSDictionary *selectedDic;
@property (nonatomic, strong) NSMutableArray *selGroupNoArray;

@end

@implementation WMMoveGoodToGroupView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.selGroupNoArray = [NSMutableArray array];
        
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, frame.size.height)];
        self.bgView.backgroundColor = ColorRGB(0, 0, 0, 0.68);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeMoveView)];
        [self.bgView addGestureRecognizer:tap];
        [self addSubview:_bgView];
        
        self.mainView = [[UIView alloc]initWithFrame:CGRectMake(25, 55, KScreenWidth - 50, frame.size.height - 110)];
        self.mainView.layer.cornerRadius = 5;
        self.mainView.backgroundColor = WMShopBg;
        // 屏蔽掉点击 bgView 视图消失的手势
        UITapGestureRecognizer *stopTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopTransTap)];
        [self.mainView addGestureRecognizer:stopTap];
        [self.bgView addSubview:_mainView];
        
        UILabel *hintLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 9, KScreenWidth - 130, 22)];
        hintLab.font = WMMediumFont(14);
        hintLab.textColor = WMHPDark;
        hintLab.textAlignment = NSTextAlignmentLeft;
        hintLab.text = @"移动至";
        [self.mainView addSubview:hintLab];
        
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 88, 11.5, 18, 18)];
        [self.closeButton setImage:[UIImage imageNamed:@"wemart_good_close"] forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(closeMoveView) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_closeButton];
        
        self.groupTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, KScreenWidth - 50, frame.size.height - 187)];
        self.groupTabView.backgroundColor = WMShopBg;
        self.groupTabView.delegate = self;
        self.groupTabView.dataSource = self;
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 50, 7)];
        footerView.backgroundColor = WMShopBg;
        self.groupTabView.tableFooterView = footerView;
        self.groupTabView.rowHeight = 16 * KScreenWScale + 25;
        [self.groupTabView registerClass:[WMSecMenuTableViewCell class] forCellReuseIdentifier:@"secondCell"];
        [self.groupTabView registerClass:[WMPreMenuHeaderView class] forHeaderFooterViewReuseIdentifier:@"preHead"];
        self.groupTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mainView addSubview:_groupTabView];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height - 152, KScreenWidth/2 - 25, 42)];
        UIBezierPath *maskLeftPath = [UIBezierPath bezierPathWithRoundedRect:self.cancelButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(3, 3)];
        CAShapeLayer *maskLeftLayer = [[CAShapeLayer alloc] init];
        maskLeftLayer.frame = self.cancelButton.bounds;
        maskLeftLayer.path = maskLeftPath.CGPath;
        self.cancelButton.layer.mask = maskLeftLayer;
        self.cancelButton.backgroundColor = [UIColor whiteColor];
        self.cancelButton.titleLabel.font = WMMediumFont(16.f);
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:WMBlueColor forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(closeMoveView) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_cancelButton];
        
        self.sureButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 25, frame.size.height - 152, KScreenWidth/2 - 25, 42)];
        UIBezierPath *maskRightPath = [UIBezierPath bezierPathWithRoundedRect:self.cancelButton.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
        CAShapeLayer *maskRightLayer = [[CAShapeLayer alloc] init];
        maskRightLayer.frame = self.sureButton.bounds;
        maskRightLayer.path = maskRightPath.CGPath;
        self.sureButton.layer.mask = maskRightLayer;
        self.sureButton.backgroundColor = WMBlueColor;
        self.sureButton.titleLabel.font = WMMediumFont(16.f);
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(sureView) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_sureButton];
    }
    return self;
}

- (void)setGroupArray:(NSMutableArray *)groupArray
{
    _groupArray = groupArray;
    CGFloat height = (16 * KScreenWScale + 25 + 6.5)* groupArray.count;
    for (WMGroupListModel *listModel in groupArray) {
        if (listModel.subGroupList.count != 0) {
            height += listModel.subGroupList.count *  (16 * KScreenWScale + 25);
        }
    }
    if (height >= self.frame.size.height - 153) {
        self.groupTabView.frame = CGRectMake(0, 35, KScreenWidth - 50, self.frame.size.height - 187);
        self.cancelButton.frame = CGRectMake(0, self.frame.size.height - 152, KScreenWidth/2 - 25, 42);
        self.sureButton.frame = CGRectMake(KScreenWidth/2 - 25, self.frame.size.height - 152, KScreenWidth/2 - 25, 42);
        self.mainView.frame = CGRectMake(25, 55, KScreenWidth - 50, self.frame.size.height - 110);
    }
    else{
        self.groupTabView.frame = CGRectMake(0, 35, KScreenWidth - 50, height);
        self.cancelButton.frame = CGRectMake(0, height + 35, KScreenWidth/2 - 25, 42);
        self.sureButton.frame = CGRectMake(KScreenWidth/2 - 25, height + 35, KScreenWidth/2 - 25, 42);
        self.mainView.frame = CGRectMake(25, (self.frame.size.height - height + 77)/2, KScreenWidth - 50, height + 77);
    }
}

#pragma mark --- groupTabView 代理方法 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WMGroupListModel *listModel = self.groupArray[section];
    NSArray *secArray = listModel.subGroupList;
    return secArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMSecMenuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    WMGroupListModel *listModel = self.groupArray[indexPath.section];
    NSArray *secArray = listModel.subGroupList;
    cell.sectionNum = indexPath.section;
    cell.rowNum = indexPath.row;
    [cell configureWithSecMenuTableViewCell:secArray[indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WMPreMenuHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"preHead"];
    headView.sectionNum = section;  
    WMGroupListModel *listModel = self.groupArray[section];
    [headView configurePreMenuHeadViewWith:listModel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16 * KScreenWScale + 25 + 6.5;
}

#pragma mark --- 自定义 代理方法 ---
- (void)signPreMenuWheatherSelected:(WMPreMenuHeaderView *)selectView isSelected:(BOOL)isSelected
{
    WMGroupListModel *listModel = self.groupArray[selectView.sectionNum];
    if (isSelected) {
        [self.selGroupNoArray addObject:listModel.groupNo];
    }
    else{
        [self.selGroupNoArray removeObject:listModel.groupNo];
    }
}

- (void)signSecMenuWheatherSelected:(WMSecMenuTableViewCell *)selectCell isSelected:(BOOL)isSelected
{
    WMGroupListModel *listModel = self.groupArray[selectCell.sectionNum];
    NSArray *subListArray = listModel.subGroupList;
    NSNumber *groupNo = subListArray[selectCell.rowNum][@"groupNo"];
    if (isSelected) {
        [self.selGroupNoArray addObject:groupNo];
    }
    else{
        [self.selGroupNoArray removeObject:groupNo];
    }
}

#pragma mark --- 关闭弹框 ---
- (void)closeMoveView
{
    [self removeFromSuperview];
}

- (void)stopTransTap
{
    // 屏蔽掉点击 bgView 视图消失的手势
}


#pragma mark --- 确定移动 ---
- (void)sureView
{
    [self removeFromSuperview];
    NSArray *groupNoListArray = [self.selGroupNoArray copy];
    self.selectedDic = @{@"goodsList":@[@{@"goodsId":self.goodsId}], @"groupNoList":groupNoListArray};
    // 最后将选择好的数据 传给目标界面
}

#pragma mark --- 去掉UItableview headerview黏性 ---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.groupTabView)
    {
        CGFloat sectionHeaderHeight = 16 * KScreenWScale + 25 + 6;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
