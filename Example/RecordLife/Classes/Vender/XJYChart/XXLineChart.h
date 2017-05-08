//
//  XXLineChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLineChartView.h"
#import "XXEnumHeader.h"
#import "XXLineChartItem.h"

@interface XXLineChart : UIView


/**
 Random ：RandomColor
 Custom :  need to set (at XXLineChartItem)
 */
@property (nonatomic, assign) XXColorMode colorMode;

@property (nonatomic, assign) XXLineMode lineMode;


/**
 XXLineChart初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;

@end
