//
//  WMPreMenuHeaderView.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMGroupListModel.h"


@class WMPreMenuHeaderView;
@protocol PreMenuDelegate <NSObject>
- (void)signPreMenuWheatherSelected:(WMPreMenuHeaderView *)selectView isSelected:(BOOL)isSelected;
@end
@interface WMPreMenuHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) id <PreMenuDelegate> delegate;
@property (nonatomic, assign) NSInteger sectionNum;

- (void)configurePreMenuHeadViewWith:(WMGroupListModel *)listModel;
@end
