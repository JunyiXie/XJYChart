//
//  SGLabel.h
//  SwiftGraphicsDemo
//
//  Created by 谢俊逸 on 30/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SGLabelRangeType) {
    SGLabelRangeTypeAtRegularExpression,
    SGLabelRangeNumberRegularExpression,
};

@protocol SGLabelDelegate <NSObject>

@required
- (void)touchUpInsideSpecialRangeType:(SGLabelRangeType) rangeType;

@end


@interface SGLabel : UIView

// 委托
@property (nonatomic, weak) id<SGLabelDelegate> sgLabelDelegate;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;


- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

@end
