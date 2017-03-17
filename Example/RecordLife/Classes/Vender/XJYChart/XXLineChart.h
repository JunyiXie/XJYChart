//
//  XXLineChart.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLineChartView.h"

@interface XXLineChart : UIView

@property (nonatomic, strong) NSNumber *top;
@property (nonatomic, strong) NSNumber *bottom;
@property (nonatomic, strong) NSMutableArray<XXLineChartItem *> *dataItemArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *dataDescribeArray;

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;

@end
