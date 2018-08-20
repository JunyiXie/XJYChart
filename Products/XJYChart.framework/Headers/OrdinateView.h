//
//  OrdinateView.h
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XBaseChartConfiguration;
@interface OrdinateView : UIView

/**
 init

 @param frame frame
 @param topNumber top number in ordinate View
 @param bottomNumber bottom number in ordinate View
 @return ordinate View instance
 */
- (instancetype)initWithFrame:(CGRect)frame
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber;

/**
 init
 
 @param frame frame
 @param topNumber top number in ordinate View
 @param bottomNumber bottom number in ordinate View
 @configuration configuration
 @return ordinate View instance
 */
- (instancetype)initWithFrame:(CGRect)frame
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
                configuration:(XBaseChartConfiguration *)configuration;
@end
