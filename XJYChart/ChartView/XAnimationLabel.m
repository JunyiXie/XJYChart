//
//  XAnimationLabel.m
//  RecordLife
//
//  Created by 谢俊逸 on 24/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimationLabel.h"



@interface XAnimationLabel ()

@property(nonatomic, assign) CGFloat animationDuration;
@property(nonatomic, assign) CGFloat startingValue;
@property(nonatomic, assign) CGFloat destinationValue;
@property(nonatomic, assign) CGFloat progress;

@property(nonatomic, assign) CGFloat lastUpdateTime;
@property(nonatomic, assign) CGFloat totalTime;

@property(nonatomic, strong) CADisplayLink* timer;

@property(nonatomic, assign) CGFloat currentValue;

@end

@implementation XAnimationLabel

#pragma mark Quick Initialize

+ (XAnimationLabel*)topLabelWithPoint:(CGPoint)point
                                 text:(NSString*)text
                            textColor:(UIColor*)textColor
                            fillColor:(UIColor*)fillColor {
  CGRect rect = CGRectMake(point.x - 30, point.y - 35, 60, 35);
  return [self topLabelWithFrame:rect text:text textColor:textColor fillColor:fillColor];
}

+ (XAnimationLabel*)topLabelWithFrame:(CGRect)frame
                                 text:(NSString*)text
                            textColor:(UIColor*)textColor
                            fillColor:(UIColor*)fillColor {
  CGFloat number = text.floatValue;
  NSString* labelText = [NSString stringWithFormat:@"%.1f", number];
  XAnimationLabel* topLabel = [[XAnimationLabel alloc] initWithFrame:frame];
  topLabel.backgroundColor = fillColor;
  [topLabel setTextAlignment:NSTextAlignmentCenter];
  topLabel.text = labelText;
  float largestFontSize = 12;
  while ([topLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].width > topLabel.frame.size.width)
  {
    largestFontSize--;
  }
//  topLabel.verticalAlignment = XVerticalAlignmentBottom;
  topLabel.font = [UIFont systemFontOfSize:largestFontSize];
//  topLabel.adjustsFontSizeToFitWidth = YES;
  [topLabel setTextColor:textColor];
  return topLabel;
}

/// Start Animation
- (void)countFromCurrentTo:(CGFloat)to duration:(CGFloat)duration {
  [self countFrom:self.currentValue to:to duration:duration];
}

- (void)addDisplayLink {
  self.timer = [CADisplayLink displayLinkWithTarget:self
                                           selector:@selector(updateValue:)];
  [self.timer addToRunLoop:[NSRunLoop currentRunLoop]
                   forMode:NSRunLoopCommonModes];
}

- (void)updateValue:(CADisplayLink*)timer {
  CGFloat now = [NSDate timeIntervalSinceReferenceDate];
  self.progress += now - self.lastUpdateTime;
  self.lastUpdateTime = now;

  if (self.progress >= self.totalTime) {
    if (self.timer != nil) {
      [self.timer invalidate];
      self.timer = nil;
      self.progress = self.totalTime;
    }
  }
  [self setTextValue:self.currentValue];
}

- (void)setTextValue:(CGFloat)number {
  self.text = [NSString stringWithFormat:@"%.1f", number];
}

- (void)countFrom:(CGFloat)from to:(CGFloat)to duration:(CGFloat)duration {
  self.startingValue = from;
  self.destinationValue = to;

  if (self.timer != nil) {
    [self.timer invalidate];
    self.timer = nil;
  }

  if (duration == 0.0) {
    [self setTextValue:to];
    return;
  }

  self.progress = 0.0;
  self.totalTime = duration;
  self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];

  [self addDisplayLink];
}

#pragma mark Get

- (CGFloat)currentValue {
  if (self.progress >= self.totalTime) {
    return self.destinationValue;
  }
  return self.startingValue +
         (self.progress / self.totalTime) *
             (self.destinationValue - self.startingValue);
}
@end
