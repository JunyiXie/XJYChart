//
//  XJYPopOption.h
//  SFMS
//
//  Created by 谢俊逸 on 2016/11/1.
//  Copyright © 2016年 谢俊逸. All rights reserved.
//

//这个视图，view 占据了整个屏幕，backgroundView 是 弹出表的视图,button添加到backgroundview上

#import <UIKit/UIKit.h>

typedef void(^XJYPopOptionBlock)(NSInteger index, NSString *content);

@interface XJYPopOption : UIView

@property (nonatomic, strong) NSArray *option_optionContents;   // 内容数组 必要
@property (nonatomic, strong) NSArray *option_optionImages;     // 图片数组 非必要
@property (nonatomic, assign) CGFloat  option_lineHeight;       // 行高 默认 40.0f
@property (nonatomic, assign) CGFloat  option_mutiple;          // 宽度比 默认为0.35f
@property (nonatomic ,assign) float    option_animateTime;      // 设置动画时长 默认0.2f秒 如果设置为0为没有动画


/**
 设置PopView

 @param block 动画
 @param frame Frame
 @param animate 是否有动画
 @return instancetype
 */
- (instancetype) option_setupPopOption:(XJYPopOptionBlock)block whichFrame:(CGRect)frame animate:(BOOL)animate;

/**
 显示
 */
- (void) option_show;

@end
