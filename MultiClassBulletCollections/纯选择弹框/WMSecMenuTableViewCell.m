//
//  WMSecMenuTableViewCell.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMSecMenuTableViewCell.h"

@implementation WMSecMenuTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectButton = [[UIButton alloc]initWithFrame:CGRectMake(41, 8 * KScreenWScale + 2, 21, 21)];
        [self.selectButton setImage:[UIImage imageNamed:@"wemart_sel_empty"] forState:UIControlStateNormal];
        [self.selectButton addTarget:self action:@selector(wheatherSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        
        self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(76, 8 * KScreenWScale, KScreenWidth - 136, 25)];
        self.nameLab.font = WMMediumFont(14);
        self.nameLab.textColor = WMHPDark;
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLab];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(41, 0, KScreenWidth - 101, 0.5)];
        lineView.backgroundColor = WMLineColor;
        [self.contentView addSubview:lineView];
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
    if ([self.delegate respondsToSelector:@selector(signSecMenuWheatherSelected:isSelected:)]) {
        [self.delegate signSecMenuWheatherSelected:self isSelected:select.selected];
    }
}

- (void)configureWithSecMenuTableViewCell:(NSDictionary *)dic
{
    self.nameLab.text = dic[@"groupName"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
