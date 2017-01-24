//
//  XJYBarChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJYBarItem.h"

@interface XJYBarChart : UIView

@property (nonatomic, strong) NSMutableArray<XJYBarItem *> *dataItemArray;

///**
// enableAnimation
// Default is YES
// */
//@property (nonatomic, assign) BOOL enableAnimation;
//

/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;


///**
// should High light Sector On Touch default is YES
// */
//@property (nonatomic, assign) BOOL shouldHighlightSectorOnTouch;
//
///**
// enable Multiple Selection default is NO
// */
//@property (nonatomic, assign) BOOL enableMultipleSelection;
//
///**
// show Absolute Values
// Default is NO
// */
//@property (nonatomic, assign) BOOL showAbsoluteValues;
//
///**
// hide Value Labels
// Default is NO
// */
//@property (nonatomic, assign) BOOL hideValueLabels;
//
///**
// only Show Values
// default is NO
// */
//@property (nonatomic, assign) BOOL onlyShowValues;
@end
