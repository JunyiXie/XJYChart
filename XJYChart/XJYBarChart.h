//
//  XJYBarChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJYBarItem.h"
#import <Masonry/Masonry.h>

//颜色

#define UIColorFromRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface XJYBarChart : UIView

/**
 初始化方法

 @param frame frame
 @param dataItemArray items
 @param topNumbser top
 @param bottomNumber buttom
 @return instancetype
 */
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XJYBarItem *> *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;



/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray<XJYBarItem *> *dataItemArray;


/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;

@end
