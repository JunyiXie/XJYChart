//
//  XAbscissaView.h
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AbscissaHeight 40

@interface XAbscissaView : UIView

/**
 init

 @param frame frame
 @param dataItemArray datas
 @return XAbscissaView instance
 */
- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray*)dataItemArray;

@end
