//
//  WMMoveGoodToView.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMMoveGoodToGroupView : UIView
@property (nonatomic, strong) UITableView *groupTabView;
@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, copy) NSString *goodsId;

@end
