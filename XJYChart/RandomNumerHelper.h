//
//  RandomNumerHelper.h
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomNumerHelper : NSObject


+ (instancetype)shareRandomNumberHelper;
- (int)randomNumberSmallThan:(NSInteger)max;
@end
