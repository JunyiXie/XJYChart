//
//  XBarContainerView.h
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XJYBarItem.h"

@interface XBarContainerView : UIView


- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray *)dataItemArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;
/**
 dataItemArray
 */
@property (nonatomic, strong) NSMutableArray *dataItemArray;
/**
 纵坐标最高点
 */
@property (nonatomic, strong) NSNumber *top;

/**
 纵坐标最低点
 */
@property (nonatomic, strong) NSNumber *bottom;

@end
