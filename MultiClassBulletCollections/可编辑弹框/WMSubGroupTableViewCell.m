//
//  WMSubGroupTableViewCell.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/23.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMSubGroupTableViewCell.h"

@implementation WMSubGroupTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.textBgView = [[UIView alloc]initWithFrame:CGRectMake(15, 6, KScreenWidth - 140, 30)];
        self.textBgView.backgroundColor = ColorRGB(249, 249, 249, 1);
        self.textBgView.layer.cornerRadius = 5;
        self.textBgView.layer.borderColor = ColorRGB(240, 242, 243, 1).CGColor;
        self.textBgView.layer.borderWidth = 1.0f;
        self.textBgView.clipsToBounds = YES;
        [self.contentView addSubview:_textBgView];
        
        self.subTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 1, KScreenWidth - 150, 28)];
        self.subTextField.backgroundColor = ColorRGB(249, 249, 249, 1);
        self.subTextField.textAlignment = NSTextAlignmentLeft;
        self.subTextField.font = WMLightFont(12);
        self.subTextField.textColor = WMContent3Color;
        [self.textBgView addSubview:_subTextField];
        
        self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 142 - 16 - 4, 8, 14, 14)];
        [self.closeButton setTintColor:ColorRGB(249, 249, 249, 1)];
        [self.closeButton setImage:[UIImage imageNamed:@"wemart_good_close"] forState:UIControlStateNormal];
        [self.textBgView addSubview:_closeButton];
        
        self.upButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 50 - 15 - 54, 11, 18, 18)];
        [self.upButton setImage:[UIImage imageNamed:@"wemart_up_blue"] forState:UIControlStateNormal];
        [self.contentView addSubview:_upButton];
        
        
        self.downButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 50 - 15 - 54 + 36, 11, 18, 18)];
        [self.downButton setImage:[UIImage imageNamed:@"wemart_down_blue"] forState:UIControlStateNormal];
        [self.contentView addSubview:_downButton];
        
    }
    return self;
}

- (void)configureSubGroupTabView:(NSDictionary *)dic isFirst:(NSInteger)isFirst
{
    if ([dic[@"groupName"] length] != 0) {
        self.subTextField.text = dic[@"groupName"];
    }
    else{
        self.subTextField.text = @"";
    }
    if (isFirst == 1) {
        self.upButton.userInteractionEnabled = YES;
        [self.upButton setImage:[UIImage imageNamed:@"wemart_up_blue"] forState:UIControlStateNormal];
        self.downButton.userInteractionEnabled = YES;
        [self.downButton setImage:[UIImage imageNamed:@"wemart_down_blue"] forState:UIControlStateNormal];
    }
    else if (isFirst == 0){
        self.upButton.userInteractionEnabled = NO;
        [self.upButton setImage:[UIImage imageNamed:@"wemart_up_gray"] forState:UIControlStateNormal];
        self.downButton.userInteractionEnabled = YES;
        [self.downButton setImage:[UIImage imageNamed:@"wemart_down_blue"] forState:UIControlStateNormal];
    }
    else{
        self.upButton.userInteractionEnabled = YES;
        [self.upButton setImage:[UIImage imageNamed:@"wemart_up_blue"] forState:UIControlStateNormal];
        self.downButton.userInteractionEnabled = NO;
        [self.downButton setImage:[UIImage imageNamed:@"wemart_down_gray"] forState:UIControlStateNormal];
    }
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
