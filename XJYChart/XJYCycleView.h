
//
//  XJYCycleView.h
//  RecordLife
//
//  Created by 谢俊逸 on 15/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJYCycleViewDelegate <NSObject>

/**
 ratio
 @param ratio 0.0 ~ 1.0
 */
- (void)ratioChange:(CGFloat)ratio;

@end

@interface XJYCycleView : UIControl
/// progress 0.0 ~ 1.0
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, weak) id<XJYCycleViewDelegate> cycleViewDeleagte;
@end
