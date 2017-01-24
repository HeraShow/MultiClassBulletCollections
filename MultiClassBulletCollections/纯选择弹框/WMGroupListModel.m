//
//  WMGroupListModel.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/12/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMGroupListModel.h"

@implementation WMGroupListModel
- (void)setValue:(id)value forKey:(NSString *)key
{
    
}

+ (WMGroupListModel *)configureSigleListModel:(NSDictionary *)dic
{
    WMGroupListModel *groupListModel = [[WMGroupListModel alloc]init];
//    [groupListModel setValuesForKeysWithDictionary:dic]; 不知道为什么 用这行代码，数据就是传不过去
    
    groupListModel.groupsortNo = dic[@"groupsortNo"];
    groupListModel.createTime = dic[@"createTime"];
    groupListModel.gsortMax = dic[@"gsortMax"];
    groupListModel.gsortMin = dic[@"gsortMin"];
    groupListModel.navSortno = dic[@"navSortno"];
    groupListModel.parentNo = dic[@"parentNo"];
    groupListModel.sellerId = dic[@"sellerId"];
    groupListModel.groupNo = dic[@"groupNo"];
    groupListModel.groupName = dic[@"groupName"];
    groupListModel.subGroupList = dic[@"subGroupList"];
    return groupListModel;
}

+ (NSMutableArray *)configureGroupListModel:(NSArray *)dataArray
{
    NSMutableArray *groupArray = [NSMutableArray array];
    for (NSDictionary * dic in dataArray) {
        WMGroupListModel *groupListModel = [WMGroupListModel configureSigleListModel:dic];
        [groupArray addObject:groupListModel];
    }
    return groupArray;
}
@end
