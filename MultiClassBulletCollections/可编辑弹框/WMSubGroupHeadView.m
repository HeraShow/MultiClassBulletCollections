//
//  WMMainGroupHeadView.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/23.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMSubGroupHeadView.h"

@implementation WMSubGroupHeadView
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.groupLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, KScreenWidth - 80, 18)];
        self.groupLab.font = WMMediumFont(14.f);
        self.groupLab.textColor = WMHPDark;
        self.groupLab.textAlignment = NSTextAlignmentLeft;
        self.groupLab.text = @"添加子分组";
        [self.contentView addSubview:_groupLab];
        
        self.textBgView = [[UIView alloc]initWithFrame:CGRectMake(15, 48, KScreenWidth - 140, 30)];
        self.textBgView.backgroundColor = [UIColor whiteColor];
        self.textBgView.layer.cornerRadius = 5;
        self.textBgView.layer.borderColor = WMLineColor.CGColor;
        self.textBgView.layer.borderWidth = 1;
        self.textBgView.clipsToBounds = YES;
        [self.contentView addSubview:_textBgView];
        
        self.groupTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 1, KScreenWidth - 150, 28)];
        self.groupTextField.textAlignment = NSTextAlignmentLeft;
        self.groupTextField.font = WMLightFont(14);
        self.groupTextField.textColor = WMHPDark;
        [self.textBgView addSubview:_groupTextField];
        
        self.sureButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth - 50 - 15 - 54, 48, 54, 30)];
        self.sureButton.backgroundColor = WMBlueColor;
        self.sureButton.layer.cornerRadius = 5;
        self.sureButton.clipsToBounds = YES;
        self.sureButton.titleLabel.font = WMMediumFont(13);
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_sureButton];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
