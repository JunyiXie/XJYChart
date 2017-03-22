//
//  CAShapeLayer+frameCategory.h
//  RecordLife
//
//  Created by 谢俊逸 on 20/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (frameCategory)

@property (nonatomic, strong) NSValue *frameValue;
@property (nonatomic, strong) NSValue *backgroundFrameValue;
@property (nonatomic, strong) NSNumber *selectStatusNumber;


@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSValue *> *> *segementPointsArrays;

@end
