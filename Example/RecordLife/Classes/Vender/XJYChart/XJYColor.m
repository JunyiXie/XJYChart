//
//  XJYColor.m
//  RecordLife
//
//  Created by 谢俊逸 on 23/01/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XJYColor.h"

@interface XJYColor ()

@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@property (nonatomic, strong) NSArray<NSString *> *colors;
@end

@implementation XJYColor


+ (instancetype)shareXJYColor {
    static XJYColor *xjyColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xjyColor = [[XJYColor alloc] init];
    });
    return xjyColor;
}

- (UIColor *)randomColorInColorArray {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupColorArray];
    });
    
    int idx = arc4random() % self.colorArray.count;
    return self.colorArray[idx];

}


- (void)setupColorArray {
    self.colorArray = [NSMutableArray new];
//    [self.colorArray addObject:XJYLightBlue];
//    [self.colorArray addObject:XJYGreen];
////    [self.colorArray addObject:XJYLightGreen];
//    [self.colorArray addObject:XJYFreshGreen];
//    [self.colorArray addObject:XJYDeepGreen];
//    [self.colorArray addObject:XJYRed];
//    [self.colorArray addObject:XJYMauve];
//    [self.colorArray addObject:XJYBrown];
//    [self.colorArray addObject:XJYBlue];
//    [self.colorArray addObject:XJYDarkBlue];
//    [self.colorArray addObject:XJYYellow];
//    [self.colorArray addObject:XJYHealYellow];
//    [self.colorArray addObject:XJYLightYellow];
//    [self.colorArray addObject:XJYPinkDark];
//    [self.colorArray addObject:XJYStarYellow];
//    [self.colorArray addObject:XJYTwitterColor];
//    [self.colorArray addObject:XJYWeiboColor];
//    [self.colorArray addObject:XJYiOSGreenColor];
    
    self.colors = @[@"infoBlue",
                    @"success",
                    @"warning",
                    @"danger",
                    @"antiqueWhite",
                    @"oldLace",
                    @"ivory",
                    @"seashell",
                    @"ghostWhite",
                    @"snow",
                    @"linen",
                    @"black25Percent",
                    @"black50Percent",
                    @"black75Percent",
                    @"warmGray",
                    @"coolGray",
                    @"charcoal",
                    @"teal",
                    @"steelBlue",
                    @"robinEgg",
                    @"pastelBlue",
                    @"turquoise",
                    @"skyBlue",
                    @"indigo",
                    @"denim",
                    @"blueberry",
                    @"cornflower",
                    @"babyBlue",
                    @"midnightBlue",
                    @"fadedBlue",
                    @"iceberg",
                    @"wave",
                    @"emerald",
                    @"grass",
                    @"pastelGreen",
                    @"seafoam",
                    @"paleGreen",
                    @"cactusGreen",
                    @"chartreuse",
                    @"hollyGreen",
                    @"olive",
                    @"oliveDrab",
                    @"moneyGreen",
                    @"honeydew",
                    @"lime",
                    @"cardTable",
                    @"salmon",
                    @"brickRed",
                    @"easterPink",
                    @"grapefruit",
                    @"pink",
                    @"indianRed",
                    @"strawberry",
                    @"coral",
                    @"maroon",
                    @"watermelon",
                    @"tomato",
                    @"pinkLipstick",
                    @"paleRose",
                    @"crimson",
                    @"eggplant",
                    @"pastelPurple",
                    @"palePurple",
                    @"coolPurple",
                    @"violet",
                    @"plum",
                    @"lavender",
                    @"raspberry",
                    @"fuschia",
                    @"grape",
                    @"periwinkle",
                    @"orchid",
                    @"goldenrod",
                    @"yellowGreen",
                    @"banana",
                    @"mustard",
                    @"buttermilk",
                    @"gold",
                    @"cream",
                    @"lightCream",
                    @"wheat",
                    @"beige",
                    @"peach",
                    @"burntOrange",
                    @"pastelOrange",
                    @"cantaloupe",
                    @"carrot",
                    @"mandarin",
                    @"chiliPowder",
                    @"burntSienna",
                    @"chocolate",
                    @"coffee",
                    @"cinnamon",
                    @"almond",
                    @"eggshell",
                    @"sand",
                    @"mud",
                    @"sienna",
                    @"dust"];
    
    // The class constructor for the relevant UIColor is <color name>Color
    [self.colors enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Color", obj]);
        // Suppress perform selector leak compiler warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        UIColor *color = (UIColor *)[[UIColor class] performSelector:selector];
#pragma diagnostic pop
        [self.colorArray addObject:color];
    }];
    
    
}

@end
