//
//  XXLineChartItem.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XXLineChartItem.h"

@implementation XXLineChartItem

- (instancetype)initWithDataNumberArray:(NSMutableArray *)numberArray color:(UIColor *)color dataDescribe:(NSString *)dataDescribe {
    if (self = [super init]) {
        self.dataDescribe = dataDescribe;
        self.numberArray = numberArray;
        self.color = color;
    }
    return self;
}
@end
