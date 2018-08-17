//
//  XAlignLabel.h
//  XJYChart
//
//  Created by 谢俊逸 on 24/5/2018.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  XVerticalAlignmentTop = 0, //default
  XVerticalAlignmentMiddle,
  XVerticalAlignmentBottom,
  
} XVerticalAlignment;

@interface XAlignLabel : UILabel
@property (nonatomic) XVerticalAlignment verticalAlignment;
@end
