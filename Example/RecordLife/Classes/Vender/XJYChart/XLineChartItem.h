//
//  XLineChartItem.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLineChartItem : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *dataDescribe;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *numberArray;
/**
 设置数据item
 
 @param numberArray (NSNumber *)dataNumber
 @param color (UIColor *)color
 @param dataDescribe (NSString *)dataDescribe
 @return instancetype
 */
- (instancetype)initWithDataNumberArray:(NSMutableArray *)numberArray color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;

@end
