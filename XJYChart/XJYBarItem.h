//
//  XJYBarItem.h
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJYBarItem : NSObject
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSNumber *dataNumber;
@property (nonatomic, strong) NSString *dataDescribe;


- (instancetype)initWithDataNumber:(NSNumber *)dataNumber color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;

@end
