//
//  XJYPieChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPieItem.h"
#import "XJYChartDelegate.h"

//颜色

#define UIColorFromRGBHex(rgbValue)                                    \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                   blue:((float)(rgbValue & 0xFF)) / 255.0             \
                  alpha:1.0]
@interface XPieChart : UIView

- (void)refreshChart;

@property(nonatomic, strong) NSMutableArray<XPieItem*>* dataItemArray;
@property(nonatomic, weak) id<XJYChartDelegate> delegate;

/**
 enableAnimation
 Default is YES
 */
@property(nonatomic, assign) BOOL enableAnimation;

/**
 descriptionTextFont default is 10
 */
@property(nonatomic) UIFont* descriptionTextFont;

/**
 descriptionTextColor default is blackColor
 */
@property(nonatomic) UIColor* descriptionTextColor;
/** Default clear Color. */
@property(nonatomic) UIColor* descriptionTextShadowColor;
/** Default is CGSizeMake(0, 0). */
@property(nonatomic) CGSize descriptionTextShadowOffset;

/**
 should High light Sector On Touch default is YES
 */
@property(nonatomic, assign) BOOL shouldHighlightSectorOnTouch;

/**
 enable Multiple Selection default is NO
 */
@property(nonatomic, assign) BOOL enableMultipleSelection;

/**
 show Absolute Values
 Default is NO
 */
@property(nonatomic, assign) BOOL showAbsoluteValues;

/**
 hide Value Labels
 Default is NO
 */
@property(nonatomic, assign) BOOL hideValueLabels;

/**
 only Show Values
 default is NO
 */
@property(nonatomic, assign) BOOL onlyShowValues;
@end
