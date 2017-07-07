//
//  XAnimationLabel.m
//  RecordLife
//
//  Created by 谢俊逸 on 24/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XAnimationLabel.h"


@interface XAnimationLabel ()


@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) CGFloat startingValue;
@property (nonatomic, assign) CGFloat destinationValue;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat lastUpdateTime;
@property (nonatomic, assign) CGFloat totalTime;

@property (nonatomic, strong) CADisplayLink *timer;

@property (nonatomic, assign) CGFloat currentValue;

@end

@implementation XAnimationLabel




- (void)addDisplayLink {
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue:)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateValue:(CADisplayLink *)timer {
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
    self.text = [NSString stringWithFormat:@"%.1f",number];
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
        return ;
    }
    
    self.progress = 0.0;
    self.totalTime = duration;
    
    self.lastUpdateTime = [NSDate timeIntervalSinceReferenceDate];
    
    [self addDisplayLink];
}

- (void)countFromCurrentTo:(CGFloat)to duration:(CGFloat)duration {
    [self countFrom:self.currentValue to:to duration:duration];
}

#pragma mark Get 

- (CGFloat)currentValue {
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    return self.startingValue + (self.progress/self.totalTime)*(self.destinationValue - self.startingValue);
    
}
@end
