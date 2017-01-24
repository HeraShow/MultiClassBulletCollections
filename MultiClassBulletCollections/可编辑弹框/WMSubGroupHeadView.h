//
//  WMMainGroupHeadView.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/23.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMGroupListModel.h"

@interface WMSubGroupHeadView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *groupLab;
@property (nonatomic, strong) UIView *textBgView;
@property (nonatomic, strong) UITextField *groupTextField;
@property (nonatomic, strong) UIButton *sureButton;



@end
