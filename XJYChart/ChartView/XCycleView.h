//
//  TBCycleView.h
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCycleViewDelegate<NSObject>

/**
 ratio
 @param ratio 0.0 ~ 1.0
 */
- (void)ratioChange:(CGFloat)ratio;

@end

@interface XCycleView : UIControl
/// progress 0.0 ~ 1.0
@property(nonatomic, assign) CGFloat progress;

@property(nonatomic, weak) id<XCycleViewDelegate> cycleViewDelegate;
@end
