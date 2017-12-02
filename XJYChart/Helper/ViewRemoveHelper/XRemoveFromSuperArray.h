//
//  XRemoveFromSuperArray.h
//  XJYChart
//
//  Created by JunyiXie on 2017/12/2.
//  Copyright © 2017年 JunyiXie. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Store CALayer or UIView and they subclass instance*/
@interface XRemoveFromSuperArray : NSMutableArray


/**
 remove item from super layer or super view.
 empty array.
 thread safe.
 */
- (void)removeFromSuperDisplayAndEmptyArray;
/// judge classA is classB subclass
BOOL classDescendsFromClass(Class classA, Class classB);
@end
