//
//  AbscissaView.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "AbscissaView.h"

@interface AbscissaView ()

@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;

@end

@implementation AbscissaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    
}

@end
