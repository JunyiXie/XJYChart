//
//  XPieItem.h
//  RecordLife
//
//  Created by 谢俊逸 on 22/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPieItem : NSObject

@property(nonatomic, strong) UIColor* color;
@property(nonatomic, strong) NSNumber* dataNumber;
@property(nonatomic, strong) NSString* dataDescribe;

/**
 设置数据item

 @param dataNumber (NSNumber *)dataNumber
 @param color (UIColor *)color
 @param dataDescribe (NSString *)dataDescribe
 @return instancetype
 */
- (instancetype)initWithDataNumber:(NSNumber*)dataNumber
                             color:(UIColor*)color
                      dataDescribe:(NSString*)dataDescribe;

@end
