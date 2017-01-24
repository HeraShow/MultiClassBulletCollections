//
//  WMSecMenuTableViewCell.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMSecMenuTableViewCell;
@protocol SecMenuDelegate <NSObject>
- (void)signSecMenuWheatherSelected:(WMSecMenuTableViewCell *)selectCell isSelected:(BOOL)isSelected;
@end

@interface WMSecMenuTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, assign) id <SecMenuDelegate> delegate;
@property (nonatomic, assign) NSInteger rowNum;
@property (nonatomic, assign) NSInteger sectionNum;

- (void)configureWithSecMenuTableViewCell:(NSDictionary *)dic;
@end
