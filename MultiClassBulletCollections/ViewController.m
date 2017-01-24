//
//  ViewController.m
//  MultiClassBulletCollections
//
//  Created by 冯文秀 on 17/1/5.
//  Copyright © 2017年 Hera. All rights reserved.
//

#import "ViewController.h"
#import "WMSigleAlertView.h"
#import "WMMoveGoodToGroupView.h"
#import "WMGroupListModel.h"
#import "WMCEGoodGroupView.h"


@interface ViewController ()
@property (nonatomic, strong) UIButton *simpleButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = WMShopBg;
    self.navigationController.navigationBar.barTintColor = WMNavBgBlueColor;
    self.navigationItem.title = @"多类别弹框";
    
    self.simpleButton = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 150)/2, 100, 150, 30)];
    self.simpleButton.layer.cornerRadius = 5;
    self.simpleButton.clipsToBounds = YES;
    self.simpleButton.backgroundColor = WMBlueColor;
    self.simpleButton.titleLabel.font = WMHLFont(15);
    [self.simpleButton setTitle:@"简易提示框" forState:UIControlStateNormal];
    [self.simpleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.simpleButton addTarget:self action:@selector(simpleHintView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_simpleButton];
    
    self.selectButton = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 150)/2, 180, 150, 30)];
    self.selectButton.layer.cornerRadius = 5;
    self.selectButton.clipsToBounds = YES;
    self.selectButton.backgroundColor = WMBlueColor;
    self.selectButton.titleLabel.font = WMHLFont(15);
    [self.selectButton setTitle:@"选择弹框" forState:UIControlStateNormal];
    [self.selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectButton addTarget:self action:@selector(selectePopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectButton];

    
    
    self.editButton = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 150)/2, 260, 150, 30)];
    self.editButton.layer.cornerRadius = 5;
    self.editButton.clipsToBounds = YES;
    self.editButton.backgroundColor = WMBlueColor;
    self.editButton.titleLabel.font = WMHLFont(15);
    [self.editButton setTitle:@"管理分组" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(configurePopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editButton];
    
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 150)/2, 340, 150, 30)];
    self.addButton.layer.cornerRadius = 5;
    self.addButton.clipsToBounds = YES;
    self.addButton.backgroundColor = WMBlueColor;
    self.addButton.titleLabel.font = WMHLFont(15);
    [self.addButton setTitle:@"添加新分组" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addPopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];


    // 假数据
    self.dataArray = @[
  @{@"createTime":@1469779925000,@"groupName":@"服装",@"groupNo":@1756,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"-1",@"parentNo":@0,@"sellerId":@386,@"subGroupList":@[]},
  @{@"createTime":@1475114206000,@"groupName":@"护肤",@"groupNo":@2320,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"-1",@"parentNo":@0,@"sellerId":@386,@"subGroupList":@[@{@"createTime":@1475114206000,@"groupName":@"面霜",@"groupNo":@2321,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"0",@"parentNo":@2320,@"sellerId":@386}]},
  @{@"createTime":@1470715121000,@"groupName":@"彩妆",@"groupNo":@1772,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"-1",@"parentNo":@0,@"sellerId":@386,@"subGroupList":@[@{@"createTime":@1470715170000,@"groupName":@"眼影",@"groupNo":@1775,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"0",@"parentNo":@1772,@"sellerId":@386},@{@"createTime":@1483495282000,@"groupName":@"口红",@"groupNo":@2870,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"1",@"parentNo":@1772,@"sellerId":@386},@{@"createTime":@1483684877000,@"groupName":@"粉饼",@"groupNo":@2875,@"groupsortNo":@0,@"gsortMax":@0,@"gsortMin":@0,@"navSortno":@"2",@"parentNo":@1772,@"sellerId":@386}]}];
    
}

#pragma mark --- 简易提示框 ---
- (void)simpleHintView
{
    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
    WMSigleAlertView *sigleView = [[WMSigleAlertView alloc]init];
    [sigleView showAlertViewTitle:@"简易提示框哦~" bgView:keyWindow];
}

#pragma mark --- 选择弹框 ---
- (void)selectePopView
{
    WMMoveGoodToGroupView *moveView = [[WMMoveGoodToGroupView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    moveView.goodsId = @"110";
    moveView.groupArray = [WMGroupListModel configureGroupListModel:self.dataArray];
    [moveView.groupTabView reloadData];
    [self.view addSubview:moveView];
}

#pragma mark --- 可输入弹框 ---
- (void)configurePopView
{
    NSMutableArray *mutableArr = [WMGroupListModel configureGroupListModel:self.dataArray];
    WMGroupListModel *listModel = mutableArr[1];
    WMCEGoodGroupView *ceGoodGroupView = [[WMCEGoodGroupView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) titleStr:@"管理商品分组" listModel:listModel isCreate:NO];
    [self.view addSubview:ceGoodGroupView];
}


- (void)addPopView
{
    WMGroupListModel *listModel = [[WMGroupListModel alloc]init];
    WMCEGoodGroupView *ceGoodGroupView = [[WMCEGoodGroupView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) titleStr:@"添加商品分组" listModel:listModel isCreate:NO];
    [self.view addSubview:ceGoodGroupView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
