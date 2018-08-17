//
//  XAnimationLabel.h
//  RecordLife
//
//  Created by 谢俊逸 on 24/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAlignLabel.h"
@interface XAnimationLabel : XAlignLabel

/**
 Start number animation

 The Begin Number is XAnimationLabel.text number value

 @param to End point
 @param duration Animation duration
 */
- (void)countFromCurrentTo:(CGFloat)to duration:(CGFloat)duration;

/**
 Initialize the XAnimationLabel on the CGPoint Top
 Quick Use for Chart number

 @param point point for location
 @param text number string. eg: @"12". As the start number.
 @param textColor Text Color
 @param fillColor backgroundColor
 @return label
 */
+ (XAnimationLabel*)topLabelWithPoint:(CGPoint)point
                                 text:(NSString*)text
                            textColor:(UIColor*)textColor
                            fillColor:(UIColor*)fillColor;

/**
 Initialize the XAnimationLabel
 Quick Use for Chart number

 @param frame Label Frame
 @param text number string. eg: @"12". As the start number.
 @param textColor Text Color
 @param fillColor backgroundColor
 @return label
 */
+ (XAnimationLabel*)topLabelWithFrame:(CGRect)frame
                                 text:(NSString*)text
                            textColor:(UIColor*)textColor
                            fillColor:(UIColor*)fillColor;

@end
