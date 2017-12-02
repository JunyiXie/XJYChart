//
//  XRemoveManager.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/2.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRemoveFromSuperArray.h"

@interface XRemoveManager : NSObject

- (void)appendArray:(XRemoveFromSuperArray*)array;

- (void)removeDisplayContentAndItem;

@end
