//
//  WMGroupListModel.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMGroupListModel : NSObject

@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSNumber *groupNo;
@property (nonatomic, strong) NSNumber *groupsortNo;
@property (nonatomic, strong) NSNumber *gsortMax;
@property (nonatomic, strong) NSNumber *gsortMin;
@property (nonatomic, copy) NSString *navSortno;
@property (nonatomic, strong) NSNumber *parentNo;
@property (nonatomic, strong) NSNumber *sellerId;
@property (nonatomic, strong) NSArray *subGroupList;


+ (WMGroupListModel *)configureSigleListModel:(NSDictionary *)dic;
+ (NSMutableArray *)configureGroupListModel:(NSArray *)dataArray;
@end
