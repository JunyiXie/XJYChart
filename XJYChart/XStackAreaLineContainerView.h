//
//  XStackAreaLineContainerView.h
//  RecordLife
//
//  Created by 谢俊逸 on 11/05/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXLineChartItem.h"
#import "XXEnumHeader.h"

@interface XStackAreaLineContainerView : UIView
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray topNumber:(NSNumber *)topNumber bottomNumber:(NSNumber *)bottomNumber;
/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray<XXLineChartItem *> *dataItemArray;
/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;

@property (nonatomic, assign) XXColorMode colorMode;

@property (nonatomic, assign) XXLineMode lineMode;
@end
