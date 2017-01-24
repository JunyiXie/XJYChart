
//
//  XJYPopOption.m
//  SFMS
//
//  Created by 谢俊逸 on 2016/11/1.
//  Copyright © 2016年 谢俊逸. All rights reserved.
//
#import "XJYPopOption.h"

@interface XJYPopOption ()

@property (nonnull, strong) UIView *backgroundView;
@property (nonatomic, weak) XJYPopOptionBlock optionBlock;
@end

@implementation XJYPopOption


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //这个视图占据了整个屏幕
        self.frame = frame;
        self.alpha = 0.0f;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    }
    return self;
}

- (instancetype) option_setupPopOption:(XJYPopOptionBlock)block whichFrame:(CGRect)frame animate:(BOOL)animate {
    self.optionBlock = block;
    [self _setupParamsWithAnimate:animate];
    [self _setupBackgourndviewWithFrame:frame];
    return self;
}

//show 只是添加了一个手势来点击移除 自己
- (void) option_show {
    [UIView animateWithDuration:self.option_animateTime animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        //用来移除
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapGesturePressed)];
        [self addGestureRecognizer:tapGesture];
    }];
}


#pragma mark - private
-(void) _setupParamsWithAnimate:(BOOL)animate {
    if (self.option_lineHeight == 0) {
        self.option_lineHeight = 40.0f;
    }
    if (self.option_mutiple == 0) {
        self.option_mutiple = 0.4f;
    }
    if (animate) {
        if (self.option_animateTime == 0) {
            self.option_animateTime = 0.2f;
        }
    } else {
        self.option_animateTime = 0;
    }
}

// 创建背景
- (void) _setupBackgourndviewWithFrame:(CGRect)whichFrame {
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.cornerRadius = 5;
    self.backgroundView.layer.masksToBounds = YES;
    [self addSubview:self.backgroundView];
    [self _setupOptionButton];
    [self _tochangeBackgroudViewFrame:whichFrame];
}

//设置表单的button
- (void) _setupOptionButton {
    if ((self.option_optionContents&&self.option_optionContents.count>0)) {
        for (NSInteger i = 0; i < self.option_optionContents.count; i++) {
            UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            //optionButton.backgroundColor = [UIColor blackColor];
            optionButton.frame = CGRectMake(0,
                                            self.option_lineHeight*i,
                                            self.frame.size.width*self.option_mutiple,
                                            self.option_lineHeight);
            optionButton.tag = i;
            [optionButton addTarget:self action:@selector(_buttonSelectPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
            [optionButton addTarget:self action:@selector(_buttonSelectDown:)
                   forControlEvents:UIControlEventTouchDown];
            [optionButton addTarget:self action:@selector(_buttonSelectOutside:)
                   forControlEvents:UIControlEventTouchUpOutside];
            [self.backgroundView addSubview:optionButton];
            
            [self _setupOptionContent:optionButton];
        }
    }
}
- (void) _setupOptionContent:(UIButton *)optionButton {
    if(self.option_optionImages&&self.option_optionImages.count>0) {
        UIImageView *headImageView = [UIImageView new];
        headImageView.frame = CGRectMake(14, 7, self.option_lineHeight-14, self.option_lineHeight-14);
        headImageView.image = [UIImage imageNamed:self.option_optionImages[optionButton.tag]];
        [optionButton addSubview:headImageView];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.frame = CGRectMake(self.option_lineHeight+7,
                                        0,
                                        self.frame.size.width-(self.option_lineHeight-14),
                                        self.option_lineHeight);
        contentLabel.text = self.option_optionContents[optionButton.tag];
        contentLabel.textColor = [UIColor darkGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:15];
        [optionButton addSubview:contentLabel];
    } else {
        UILabel *contentLabel = [UILabel new];
        [optionButton addSubview:contentLabel];
        contentLabel.frame = optionButton.bounds;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.text = self.option_optionContents[optionButton.tag];
        contentLabel.textColor = [UIColor darkGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:15];
    }
    
    if(optionButton.tag != 0) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        lineView.frame = CGRectMake(0,
                                    self.option_lineHeight*optionButton.tag,
                                    self.frame.size.width*self.option_mutiple,
                                    1);
        [self.backgroundView addSubview:lineView];
    }
}

//frame 是按钮的frame
//这个方法把按钮添加到当前窗口上
- (void) _tochangeBackgroudViewFrame:(CGRect)whichFrame {
    CGFloat self_w = self.frame.size.width;
    
    CGFloat which_x = whichFrame.origin.x;
    CGFloat which_w = whichFrame.size.width;
    CGFloat which_h = whichFrame.size.height;
    
    CGFloat background_x = which_x-((self_w*self.option_mutiple/2)-which_w/2);
    CGFloat background_y = whichFrame.origin.y+which_h+10;
    CGFloat background_w = self_w * self.option_mutiple;
    CGFloat background_h = self.option_lineHeight*self.option_optionContents.count;
    
    if (background_x < 10) {
        background_x = 10;
    }
    if (self_w-(which_x+which_w)<=10||
        ((self_w*self.option_mutiple/2)-which_w/2>=(self_w-(which_x+which_w)))) {
        background_x = self_w-(self_w*self.option_mutiple)-10;
    }
    
    self.backgroundView.frame = CGRectMake(background_x, background_y, background_w, background_h);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Select"]];
    [self addSubview:imageView];
    imageView.frame = CGRectMake(which_x+which_w/2-10,
                                 background_y-15,
                                 20,
                                 15);
    //直接加到窗口上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


// 点击消失
- (void) _tapGesturePressed {
    [UIView animateWithDuration:self.option_animateTime animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.option_animateTime animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}


#pragma mark - inside outside down

- (void) _buttonSelectPressed:(UIButton *)button {
    self.optionBlock(button.tag, self.option_optionContents[button.tag]);
    button.backgroundColor = [UIColor whiteColor];
    [self _tapGesturePressed];
}
- (void) _buttonSelectDown:(UIButton *)button {
    button.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
}
- (void) _buttonSelectOutside:(UIButton *)button {
    button.backgroundColor = [UIColor whiteColor];
}

@end
