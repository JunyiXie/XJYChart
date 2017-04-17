//
//  XJYPointView.h
//  RecordLife
//
//  Created by 谢俊逸 on 20/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry/Masonry.h"

typedef NS_ENUM(NSUInteger, XJYPointShapeType) {
    XJYPointShapeTypeCircular,
    XJYPointShapeTypeTriangle,
    XJYPointShapeTypeSquare,
};

@interface XJYPointView : UIView


@property (nonatomic, assign) XJYPointShapeType pointShapeType;

//点的颜色 default is red
@property (nonatomic, strong) UIColor *pointColor;
@property (nonatomic, strong) UIColor *secondPointColor;
@property (nonatomic, strong) UIColor *thirdPointColor;

@end
