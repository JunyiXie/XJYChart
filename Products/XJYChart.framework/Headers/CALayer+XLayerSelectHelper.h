//
//  CALayer+XXLayer.h
//  RecordLife
//
//  Created by 谢俊逸 on 24/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XXLayer)

@property(nonatomic, strong) NSNumber* selectIdxNumber;
@property(nonatomic, strong) NSValue* frameValue;
@property(nonatomic, strong) NSValue* backgroundFrameValue;
@property(nonatomic, strong) NSNumber* selectStatusNumber;

@property(nonatomic, strong)
    NSMutableArray<NSMutableArray<NSValue*>*>* segementPointsArrays;

@end
