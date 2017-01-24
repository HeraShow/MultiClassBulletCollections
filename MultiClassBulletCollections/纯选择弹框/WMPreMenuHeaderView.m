//
//  WMPreMenuHeaderView.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMPreMenuHeaderView.h"

@implementation WMPreMenuHeaderView
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WMShopBg;
        
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 6, KScreenWidth - 25, 16 * KScreenWScale + 25)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        self.selectButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 8 * KScreenWScale + 2, 21, 21)];
        [self.selectButton setImage:[UIImage imageNamed:@"wemart_sel_empty"] forState:UIControlStateNormal];
        [self.selectButton addTarget:self action:@selector(wheatherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_selectButton];
        
        self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 8 * KScreenWScale, KScreenWidth - 120, 25)];
        self.nameLab.font = WMMediumFont(14);
        self.nameLab.textColor = WMHPDark;
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_nameLab];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 16 * KScreenWScale + 25, KScreenWidth - 70, 0.5)];
        self.lineView.backgroundColor = WMLineColor;
    }
    return self;
}

#pragma mark --- 是否选中 ---
- (void)wheatherSelected:(UIButton *)select
{
    select.selected = !select.selected;
    if (select.selected) {
        [self.selectButton setImage:[UIImage imageNamed:@"wemart_selected"] forState:UIControlStateNormal];
    }
    else{
        [self.selectButton setImage:[UIImage imageNamed:@"wemart_sel_empty"] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(signPreMenuWheatherSelected: isSelected:)]) {
        [self.delegate signPreMenuWheatherSelected:self isSelected:select.selected];
    }
}



- (void)configurePreMenuHeadViewWith:(WMGroupListModel *)listModel
{
    self.bgView.frame = CGRectMake(0, 8, KScreenWidth - 25, 16 * KScreenWScale + 25);
    self.nameLab.text = listModel.groupName;
    if (listModel.subGroupList.count != 0) {
        [self.bgView addSubview:_lineView];
        [self.selectButton removeFromSuperview];
        self.nameLab.frame = CGRectMake(10, 8 * KScreenWScale, KScreenWidth - 80, 25);
    }
    else{
        [self.lineView removeFromSuperview];
        [self.bgView addSubview:_selectButton];
        self.nameLab.frame = CGRectMake(45, 8 * KScreenWScale, KScreenWidth - 120, 25);
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
