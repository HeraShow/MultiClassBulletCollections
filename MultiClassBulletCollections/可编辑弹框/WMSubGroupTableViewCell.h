//
//  WMSubGroupTableViewCell.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/23.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMSubGroupTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *textBgView;
@property (nonatomic, strong) UITextField *subTextField;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *upButton;
@property (nonatomic, strong) UIButton *downButton;

- (void)configureSubGroupTabView:(NSDictionary *)dic isFirst:(NSInteger)isFirst;
@end
