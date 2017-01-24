//
//  PublicHeader.h
//  MultiClassBulletCollections
//
//  Created by 冯文秀 on 17/1/5.
//  Copyright © 2017年 Hera. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#define WMHLFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Light" size:FontSize]
#define WMHRFont(FontSize) [UIFont fontWithName:@"HelveticaNeue-Regular" size:FontSize]

#define WMLightFont(FontSize) [UIFont fontWithName:@"PingFangSC-Light" size:FontSize]
#define WMBoldFont(FontSize) [UIFont fontWithName:@"PingFangSC-Bold" size:FontSize]
#define WMMediumFont(FontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize]
#define WMRegularFont(FontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize]


#define ColorRGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define WMShopBg ColorRGB(240, 243, 245, 1)
#define WMNavBgBlueColor ColorRGB(51, 165, 239, 0.9)
#define WMBlueColor ColorRGB(16, 169, 235, 1)
#define WMHPDark ColorRGB(55, 59, 64, 1)
#define WMLogoutBg ColorRGB(238, 84, 41, 1)
#define WMLineColor ColorRGB(195, 198, 198, 1)
#define WMContent3Color ColorRGB(140, 144, 145, 1)


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWScale (KScreenWidth / 375.f)

#endif /* PublicHeader_h */
