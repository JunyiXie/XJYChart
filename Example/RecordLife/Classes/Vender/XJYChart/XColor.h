//
//  XColor.h
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


#define XJYSkyBlue       [UIColor colorWithRed:120.0 / 176.0 green:169.0 / 255.0 blue:226.0 / 255.0 alpha:1.0f]
#define XJYGrey          [UIColor colorWithRed:246.0 / 255.0 green:246.0 / 255.0 blue:246.0 / 255.0 alpha:1.0f]
#define XJYLightBlue     [UIColor colorWithRed:94.0 / 255.0 green:147.0 / 255.0 blue:196.0 / 255.0 alpha:1.0f]
#define XJYGreen         [UIColor colorWithRed:77.0 / 255.0 green:186.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define XJYTitleColor    [UIColor colorWithRed:0.0 / 255.0 green:189.0 / 255.0 blue:113.0 / 255.0 alpha:1.0f]
#define XJYButtonGrey    [UIColor colorWithRed:141.0 / 255.0 green:141.0 / 255.0 blue:141.0 / 255.0 alpha:1.0f]
#define XJYLightGreen    [UIColor colorWithRed:77.0 / 255.0 green:216.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define XJYFreshGreen    [UIColor colorWithRed:77.0 / 255.0 green:196.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define XJYDeepGreen     [UIColor colorWithRed:77.0 / 255.0 green:176.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]
#define XJYRed           [UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]
#define XJYMauve         [UIColor colorWithRed:88.0 / 255.0 green:75.0 / 255.0 blue:103.0 / 255.0 alpha:1.0f]
#define XJYBrown         [UIColor colorWithRed:119.0 / 255.0 green:107.0 / 255.0 blue:95.0 / 255.0 alpha:1.0f]
#define XJYBlue          [UIColor colorWithRed:82.0 / 255.0 green:116.0 / 255.0 blue:188.0 / 255.0 alpha:1.0f]
#define XJYDarkBlue      [UIColor colorWithRed:121.0 / 255.0 green:134.0 / 255.0 blue:142.0 / 255.0 alpha:1.0f]
#define XJYYellow        [UIColor colorWithRed:242.0 / 255.0 green:197.0 / 255.0 blue:117.0 / 255.0 alpha:1.0f]
#define XJYWhite         [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f]
#define XJYDeepGrey      [UIColor colorWithRed:99.0 / 255.0 green:99.0 / 255.0 blue:99.0 / 255.0 alpha:1.0f]
#define XJYPinkGrey      [UIColor colorWithRed:200.0 / 255.0 green:193.0 / 255.0 blue:193.0 / 255.0 alpha:1.0f]
#define XJYHealYellow    [UIColor colorWithRed:245.0 / 255.0 green:242.0 / 255.0 blue:238.0 / 255.0 alpha:1.0f]
#define XJYLightGrey     [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0f]
#define XJYCleanGrey     [UIColor colorWithRed:251.0 / 255.0 green:251.0 / 255.0 blue:251.0 / 255.0 alpha:1.0f]
#define XJYLightYellow   [UIColor colorWithRed:241.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1.0f]
#define XJYDarkYellow    [UIColor colorWithRed:152.0 / 255.0 green:150.0 / 255.0 blue:159.0 / 255.0 alpha:1.0f]
#define XJYPinkDark      [UIColor colorWithRed:170.0 / 255.0 green:165.0 / 255.0 blue:165.0 / 255.0 alpha:1.0f]
#define XJYCloudWhite    [UIColor colorWithRed:244.0 / 255.0 green:244.0 / 255.0 blue:244.0 / 255.0 alpha:1.0f]
#define XJYBlack         [UIColor colorWithRed:45.0 / 255.0 green:45.0 / 255.0 blue:45.0 / 255.0 alpha:1.0f]
#define XJYStarYellow    [UIColor colorWithRed:252.0 / 255.0 green:223.0 / 255.0 blue:101.0 / 255.0 alpha:1.0f]
#define XJYTwitterColor  [UIColor colorWithRed:0.0 / 255.0 green:171.0 / 255.0 blue:243.0 / 255.0 alpha:1.0]
#define XJYWeiboColor    [UIColor colorWithRed:250.0 / 255.0 green:0.0 / 255.0 blue:33.0 / 255.0 alpha:1.0]
#define XJYiOSGreenColor [UIColor colorWithRed:98.0 / 255.0 green:247.0 / 255.0 blue:77.0 / 255.0 alpha:1.0]


@interface XColor : NSObject

+ (instancetype)shareXColor;
- (UIColor *)randomColorInColorArray;
@end
