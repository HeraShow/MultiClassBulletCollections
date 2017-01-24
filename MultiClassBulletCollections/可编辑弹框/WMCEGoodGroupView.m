//
//  WMCreateGoodGroupView.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMCEGoodGroupView.h"
#import "WMSubGroupHeadView.h"
#import "WMSubGroupTableViewCell.h"
#import "WMGroupListModel.h"

@interface WMCEGoodGroupView() <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *bgView;
@property (nonatomic, strong) UIView *mainBgView;
@property (nonatomic, strong) UILabel *inputHintLab;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *finshButton;
@property (nonatomic, strong) NSDictionary *parDic;
@property (nonatomic, strong) WMSubGroupHeadView *headView;
@property (nonatomic, strong) UITextField *groupTextField;
@property (nonatomic, assign) BOOL isAdd;

@property (nonatomic, strong) NSMutableArray *removeArray;
@end

@implementation WMCEGoodGroupView

- (id)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr listModel:(WMGroupListModel *)listModel isCreate:(BOOL)isCreate
{
    if (self = [super initWithFrame:frame]) {
        self.listModel = listModel;
        if ([titleStr isEqualToString:@"添加商品分组"]) {
            self.isAdd = YES;
        }
        // 管理商品分组
        else{
            self.isAdd = NO;
        }
        
        self.bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, frame.size.height)];
        self.bgView.delegate = self;
        self.bgView.contentSize =CGSizeMake(KScreenWidth, frame.size.height);
        self.bgView.backgroundColor = ColorRGB(0, 0, 0, 0.68);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeMoveView)];
        [self.bgView addGestureRecognizer:tap];
        [self addSubview:_bgView];
        
        self.mainBgView = [[UIView alloc]initWithFrame:CGRectMake(25, 35, KScreenWidth - 50, frame.size.height - 70)];
        self.mainBgView.layer.cornerRadius = 5;
        self.mainBgView.clipsToBounds = YES;
        self.mainBgView.backgroundColor = WMShopBg;
        // 屏蔽掉点击 bgView 视图消失的手势
        UITapGestureRecognizer *stopTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopTransTap)];
        [self.mainBgView addGestureRecognizer:stopTap];
        [self.bgView addSubview:_mainBgView];
        
        UILabel *addHintLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 9, KScreenWidth - 130, 22)];
        addHintLab.font = WMMediumFont(14);
        addHintLab.textColor = WMHPDark;
        addHintLab.textAlignment = NSTextAlignmentLeft;
        addHintLab.text = titleStr;
        [self.mainBgView addSubview:addHintLab];
        
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 88, 11.5, 18, 18)];
        [self.closeButton setImage:[UIImage imageNamed:@"wemart_good_close"] forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(closeMoveView) forControlEvents:UIControlEventTouchUpInside];
        [self.mainBgView addSubview:_closeButton];
        
        UIView *tabHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 50, 102)];
        tabHeadView.backgroundColor = [UIColor whiteColor];

        UILabel *groupLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 120, 18)];
        groupLab.font = WMMediumFont(14.f);
        groupLab.textColor = WMHPDark;
        groupLab.textAlignment = NSTextAlignmentLeft;
        groupLab.text = @"商品分组名称";
        [tabHeadView addSubview:groupLab];
        
        self.inputHintLab = [[UILabel alloc]initWithFrame:CGRectMake(130, 21, 130, 16)];
        self.inputHintLab.font = WMLightFont(13.f);
        self.inputHintLab.textColor = WMLogoutBg;
        self.inputHintLab.textAlignment = NSTextAlignmentLeft;
        self.inputHintLab.text = @"* 分组名称必须填写";
        self.inputHintLab.hidden = YES;
        [tabHeadView addSubview:_inputHintLab];
        
        UIView *textBgView = [[UIView alloc]initWithFrame:CGRectMake(15, 48, KScreenWidth - 80, 30)];
        textBgView.backgroundColor = [UIColor whiteColor];
        textBgView.layer.cornerRadius = 5;
        textBgView.layer.borderColor = WMLineColor.CGColor;
        textBgView.layer.borderWidth = 1;
        textBgView.clipsToBounds = YES;
        [tabHeadView addSubview:textBgView];
        
        self.groupTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 1, KScreenWidth - 90, 28)];
        self.groupTextField.tag = 200;
        self.groupTextField.textAlignment = NSTextAlignmentLeft;
        self.groupTextField.font = WMLightFont(14);
        self.groupTextField.textColor = WMHPDark;
        self.groupTextField.delegate = self;
        [self.groupTextField addTarget:self action:@selector(groupTextChange:) forControlEvents:UIControlEventEditingChanged];
        [textBgView addSubview:_groupTextField];
        
        if (listModel.groupName.length != 0) {
            self.groupTextField.text = listModel.groupName;
        }
        else{
            self.groupTextField.text = @"";
        }
        
        UILabel *hintLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 86, KScreenWidth - 80, 16)];
        hintLab.font = WMLightFont(13.f);
        hintLab.textColor = WMContent3Color;
        hintLab.textAlignment = NSTextAlignmentLeft;
        hintLab.text = @"15个字以内";
        [tabHeadView addSubview:hintLab];
        
        self.groupTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 39, KScreenWidth - 50, frame.size.height - 151) style:UITableViewStyleGrouped];
        self.groupTabView.backgroundColor = WMShopBg;
        self.groupTabView.delegate = self;
        self.groupTabView.dataSource = self;
        self.groupTabView.rowHeight = 38;
        self.groupTabView.tableHeaderView = tabHeadView;
        [self.groupTabView registerClass:[WMSubGroupTableViewCell class] forCellReuseIdentifier:@"subCell"];
        [self.groupTabView registerClass:[WMSubGroupHeadView class] forHeaderFooterViewReuseIdentifier:@"subHead"];
        self.groupTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mainBgView addSubview:_groupTabView];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42)];
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
        [self.mainBgView addSubview:_cancelButton];
        
        self.finshButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 25, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42)];
        UIBezierPath *maskRightPath = [UIBezierPath bezierPathWithRoundedRect:self.cancelButton.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
        CAShapeLayer *maskRightLayer = [[CAShapeLayer alloc] init];
        maskRightLayer.frame = self.finshButton.bounds;
        maskRightLayer.path = maskRightPath.CGPath;
        self.finshButton.layer.mask = maskRightLayer;
        self.finshButton.backgroundColor = WMBlueColor;
        self.finshButton.titleLabel.font = WMMediumFont(16.f);
        [self.finshButton setTitle:@"完成" forState:UIControlStateNormal];
        [self.finshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.finshButton addTarget:self action:@selector(finshView) forControlEvents:UIControlEventTouchUpInside];
        [self.mainBgView addSubview:_finshButton];

        self.groupArray = [NSMutableArray array];
        self.removeArray = [NSMutableArray array];
        if (listModel.subGroupList.count != 0) {
            for (NSInteger i = 0; i < listModel.subGroupList.count; i++) {
                NSDictionary *dic = listModel.subGroupList[i];
                NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
                [mutableDic setObject:dic[@"groupName"] forKey:@"groupName"];
                [mutableDic setObject:dic[@"groupNo"] forKey:@"groupNo"];
                [mutableDic setObject:listModel.groupNo forKey:@"parentNo"];
                [mutableDic setObject:@1 forKey:@"act"];
                [mutableDic setObject:[NSNumber numberWithInteger:i] forKey:@"navSortno"];
                [self.groupArray addObject:mutableDic];
            }
        }
        
        if ([titleStr isEqualToString:@"管理商品分组"]) {
            if (listModel.subGroupList.count == 0) {
                self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, 112);
                self.mainBgView.frame = CGRectMake(25, (frame.size.height - 193)/2, KScreenWidth - 50, 193);
                self.groupTabView.scrollEnabled = NO;
            }
            else{
                CGFloat height = 86 + 38 * listModel.subGroupList.count;
                if (height >= frame.size.height - 70 - 81 - 102) {
                    self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, frame.size.height - 70 - 81);
                    self.mainBgView.frame = CGRectMake(25, 35, KScreenWidth - 50, frame.size.height - 70);
                    self.groupTabView.scrollEnabled = YES;
                }
                else{
                    CGFloat currentHeight = 86 + 38 * listModel.subGroupList.count;
                    self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, currentHeight + 102);
                    self.mainBgView.frame = CGRectMake(25, (frame.size.height - currentHeight - 102 - 81)/2, KScreenWidth - 50, currentHeight + 102 + 81);
                    self.groupTabView.scrollEnabled = NO;
                }
            }
        }
        else{
            if (listModel.subGroupList.count == 0) {
                self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, 188);
                self.mainBgView.frame = CGRectMake(25, (frame.size.height - 269)/2, KScreenWidth - 50, 269);
                self.groupTabView.scrollEnabled = NO;
            }
        }
        self.cancelButton.frame = CGRectMake(0, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
        self.finshButton.frame = CGRectMake(KScreenWidth/2 - 25, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
    }
    return self;
}



#pragma mark --- groupTabView 代理方法 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMSubGroupTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
    NSDictionary *subDic = self.groupArray[indexPath.row];
    if (indexPath.row == 0) {
        [cell configureSubGroupTabView:subDic isFirst:0];
    }
    else if (indexPath.row == self.groupArray.count - 1){
        [cell configureSubGroupTabView:subDic isFirst:2];
    }
    else{
        [cell configureSubGroupTabView:subDic isFirst:1];
    }

    cell.upButton.tag = 100 + indexPath.row;
    [cell.upButton addTarget:self action:@selector(upOneSet:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.downButton.tag = 200 + indexPath.row;
    [cell.downButton addTarget:self action:@selector(downOneSet:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.closeButton.tag = 300 + indexPath.row;
    [cell.closeButton addTarget:self action:@selector(removeOneSet:) forControlEvents:UIControlEventTouchUpInside];
    cell.subTextField.delegate = self;
    cell.subTextField.tag = 400 + indexPath.row;
    [cell.subTextField addTarget:self action:@selector(subGroupTextChange:) forControlEvents:UIControlEventEditingChanged];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"subHead"];
    self.headView.groupTextField.delegate = self;
    [self.headView.sureButton addTarget:self action:@selector(sureAddGoodSubGroup) forControlEvents:UIControlEventTouchUpInside];
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth - 50, 6)];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}

#pragma mark --- 上移一位 ---
- (void)upOneSet:(UIButton *)up
{
    NSInteger index = up.tag - 100;
    [self.groupArray exchangeObjectAtIndex:index - 1 withObjectAtIndex:index];
    [self.groupTabView reloadData];
}

#pragma mark --- 下移一位 ---
- (void)downOneSet:(UIButton *)down
{
    NSInteger index = down.tag - 200;
    [self.groupArray exchangeObjectAtIndex:index + 1 withObjectAtIndex:index];
    [self.groupTabView reloadData];
}

#pragma mark --- 移除子分组 ---
- (void)removeOneSet:(UIButton *)remove
{
    NSInteger index = remove.tag - 300;
    NSDictionary *dic = self.groupArray[index];
    if ([dic.allKeys containsObject:@"groupNo"]) {
        for (NSDictionary *groupDic in self.listModel.subGroupList) {
            if ([dic[@"groupNo"] isEqual:groupDic[@"groupNo"]]) {
                [self.removeArray addObject:dic];
            }
        }
    }
    
    [self.groupArray removeObjectAtIndex:index];
    [self.groupTabView reloadData];
    if (self.groupArray.count == 0) {
        self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, 188);
        self.mainBgView.frame = CGRectMake(25, (self.frame.size.height - 269)/2, KScreenWidth - 50, 269);
        self.groupTabView.scrollEnabled = NO;
    }
    else{
        CGFloat height = 86 + 38 * self.groupArray.count;
        if (height >= self.frame.size.height - 70 - 81 - 102) {
            self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, self.frame.size.height - 70 - 81);
            self.mainBgView.frame = CGRectMake(25, 35, KScreenWidth - 50, self.frame.size.height - 70);
            self.groupTabView.scrollEnabled = YES;
        }
        else{
            CGFloat currentHeight = 86 + 38 * self.groupArray.count;
            self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, currentHeight + 102);
            self.mainBgView.frame = CGRectMake(25, (self.frame.size.height - currentHeight - 102 - 81)/2,KScreenWidth - 50, currentHeight + 102 + 81);
            self.groupTabView.scrollEnabled = NO;
        }
    }
    self.cancelButton.frame = CGRectMake(0, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
    self.finshButton.frame = CGRectMake(KScreenWidth/2 - 25, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
}

#pragma mark --- 子分组文本 修改 ---
- (void)subGroupTextChange:(UITextField *)subTextField
{
    NSInteger index = subTextField.tag -  400;
    NSMutableDictionary *dic = [self.groupArray[index] mutableCopy];
    [dic setValue:subTextField.text forKey:@"groupName"];
    [self.groupArray replaceObjectAtIndex:index withObject:[dic copy]];
    [self.groupTabView reloadData];
}

#pragma mark --- 关闭弹框 ---
- (void)closeMoveView
{
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (void)stopTransTap
{
    // 屏蔽掉点击 bgView 视图消失的手势
}

#pragma mark --- 商品分组输入 ---
- (void)groupTextChange:(UITextField *)textField
{
    if (textField.text.length == 0 && self.headView.groupTextField.text.length != 0) {
        self.inputHintLab.hidden = NO;
    }
    else{
        self.inputHintLab.hidden = YES;
    }
}

#pragma mark --- 确定添加 或者修改 ---
- (void)finshView
{
    [self removeFromSuperview];
    for (NSInteger i = 0; i < self.groupArray.count; i++) {
        NSMutableDictionary *dic = [self.groupArray[i] mutableCopy];
        [dic setObject:[NSNumber numberWithInteger:i] forKey:@"navSortno"];
        [self.groupArray replaceObjectAtIndex:i withObject:[dic copy]];
    }
    NSLog(@"self.groupArray --- %@", self.groupArray);
    if (self.isAdd) {
        // 根据接口 准备好 数据
        self.parDic = @{@"groupName":self.groupTextField.text,@"groupNo":@"",@"parentNo":@0,@"act":@0,@"subGroupList":[self.groupArray copy]};
        // 最后将选择好的数据 传给目标界面
    }
    else{
        if (self.removeArray.count != 0) {
            NSLog(@"删除分组 -------- ");
        }
        // 根据接口 准备好 数据
        self.parDic = @{@"groupName":self.groupTextField.text,@"groupNo":self.listModel.groupNo,@"parentNo":@0,@"act":@1};
        // 最后将选择好的数据 传给目标界面
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark --- 键盘即将弹出 ---
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboradFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height = self.mainBgView.frame.size.height;
    self.mainBgView.frame = CGRectMake(25, 25, KScreenWidth - 50, height);
    self.bgView.frame = CGRectMake(0, 0, KScreenWidth, self.frame.size.height - keyboradFrame.size.height);
}

#pragma mark --- 键盘即将消失 ---
- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat height = self.mainBgView.frame.size.height;
    self.mainBgView.frame = CGRectMake(25, (self.frame.size.height - 269)/2, KScreenWidth - 50, height);
    self.bgView.frame = CGRectMake(0, 0, KScreenWidth, self.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.headView.groupTextField] && textField.text.length != 0) {
        if (self.groupTextField.text.length != 0) {
            BOOL isSame = NO;
            for (NSDictionary *dic in self.groupArray) {
                if ([dic[@"groupName"] isEqualToString:textField.text]) {
                    isSame = YES;
                }
            }
            if (!isSame) {
                [self sureAddGoodSubGroup];
            }
            else{
//                [self showHintString:@"子分组不允许重名"];
            }
        }
        else{
            self.inputHintLab.hidden = NO;
            [self.groupTextField resignFirstResponder];
        }
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

#pragma mark --- 确定添加子分组 ---
- (void)sureAddGoodSubGroup
{
    if (self.headView.groupTextField.text.length != 0) {
        if (self.groupTextField.text.length != 0) {
            BOOL isSame = NO;
            for (NSDictionary *dic in self.groupArray) {
                if ([dic[@"groupName"] isEqualToString:self.headView.groupTextField.text]) {
                    isSame = YES;
                }
            }
            if (!isSame) {
                NSDictionary *dic;
                if (self.isAdd) {
                    dic = @{@"groupName":self.headView.groupTextField.text, @"act":@0, @"parentNo":@0,@"navSortno":[NSNumber numberWithInteger:self.groupArray.count]};
                }
                else{
                   dic = @{@"groupName":self.headView.groupTextField.text, @"act":@1, @"parentNo":self.listModel.groupNo,@"navSortno":[NSNumber numberWithInteger:self.groupArray.count]};
                }
                
                [self.groupArray addObject:dic];
                [self.groupTabView reloadData];
                if (self.groupArray.count == 0) {
                    self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, 188);
                    self.mainBgView.frame = CGRectMake(25, (self.frame.size.height - 269)/2, KScreenWidth - 50, 269);
                    self.groupTabView.scrollEnabled = NO;
                }
                else{
                    CGFloat height = 86 + 38 * self.groupArray.count;
                    if (height >= self.frame.size.height - 70 - 81 - 102) {
                        self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, self.frame.size.height - 70 - 81);
                        self.mainBgView.frame = CGRectMake(25, 35, KScreenWidth - 50, self.frame.size.height - 70);
                        self.groupTabView.scrollEnabled = YES;
                    }
                    else{
                        CGFloat currentHeight = 86 + 38 * self.groupArray.count;
                        self.groupTabView.frame = CGRectMake(0, 39, KScreenWidth - 50, currentHeight + 102);
                        self.mainBgView.frame = CGRectMake(25, (self.frame.size.height - currentHeight - 102 - 81)/2, KScreenWidth - 50, currentHeight + 102 + 81);
                        self.groupTabView.scrollEnabled = NO;
                    }
                }
                self.headView.groupTextField.text = @"";
            }
            else{
//                [self showHintString:@"子分组不允许重名"];
            }
        }
        else{
            self.inputHintLab.hidden = NO;
            [self.headView.groupTextField resignFirstResponder];
        }
    }
    else{
        // 未填写 自分组名称
//        [self showHintString:@"未填写子分组"];
    }
    self.cancelButton.frame = CGRectMake(0, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
    self.finshButton.frame = CGRectMake(KScreenWidth/2 - 25, self.mainBgView.frame.size.height - 42, KScreenWidth/2 - 25, 42);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
