//
//  TBCycleView.h
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJYCycleViewDelegate <NSObject>

/**
 当前进度比例

 @param ratio 0.0 ~ 1.0
 */
- (void)ratioChange:(CGFloat)ratio;

@end

@interface XJYCycleView : UIControl


@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic,assign) int lineWidth;
@property (nonatomic,setter=changeAngle:) int angle;
//- (void)drawProgress:(CGFloat )progress;
@property (nonatomic, weak) id<XJYCycleViewDelegate> cycleViewDeleagte;

@end
