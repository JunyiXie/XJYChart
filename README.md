### XJYChart

  `High-performance` `Elegant`  `Easy-to-integrate` `Charting Framework`.
 
 ![License](https://img.shields.io/badge/license-MIT-green.svg)
 ![CircleCI](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser.svg)
 ![release](https://img.shields.io/badge/XJYChart-v1.0.0-blue.svg)
 ![cocoapods](https://img.shields.io/badge/Cocoapods-v1.0.0-green.svg)

***
#### Charts In This Framework

- [x] **LineChart**
- [x] **BarChart**
- [x] **PositiveNegativeBarChart**
- [x] **PieChart**
- [x] **CycleChart**

***
#### All Chart Support 

- [x] **Animation**
- [x] **Touch**
- [x] **Scroll**
- [x] **Beautiful**

***


![gif](https://github.com/JunyiXie/XJYChart/raw/master/photos/XJYChart.gif)



 ###### Installation With CocoaPods
```
pod 'XJYChart'
```

update 0.0.3
+ Add XJYCycleView   

- touch
- gradient

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image7.PNG)

use XIB or Code
```objectivec
//XJYCycleView
- (instancetype)initWithFrame:(CGRect)frame;
```

Update 0.0.2
- Clear abandoned API
+ Add The positive and negative Bar Chart**

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)

#### How to Use

###### XXPositiveNegativeBarChart

```objectivec
XXPositiveNegativeBarChart *barChart = [[XXPositiveNegativeBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@(-170)];
```

###### XXLineChart


```objectivec

- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XXLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;
```

###### XXLineChartItem

```objectivec
- (instancetype)initWithDataNumberArray:(NSMutableArray *)numberArray color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;
```

```objectivec
XXLineChart *lineChart = [[XXLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@200 bottomNumber:@0];
```

###### Cycle Chart
```objectivec
//XJYCycleView
- (instancetype)initWithFrame:(CGRect)frame;
```

###### PieChart

```objectivec
self.pieChartView = [[XJYPieChart alloc] init];
NSMutableArray *pieItems = [[NSMutableArray alloc] init];
NSArray *colorArray = @[RGB(145, 235, 253), RGB(198, 255, 150), RGB(254, 248, 150), RGB(253, 210, 147)];
NSArray *dataArray = @[@"iPhone6",@"iPhone6 Plus",@"iPhone6s",@"其他"];
XJYPieItem *item1 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:20.9] color:colorArray[0] dataDescribe:dataArray[0]];
            [pieItems addObject:item1];
XJYPieItem *item2 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:14.82] color:colorArray[1] dataDescribe:dataArray[1]];
[pieItems addObject:item2];  
self.pieChartView.dataItemArray = pieItems;
```

###### ChartColor 
Provide many colors In XJYColor.h
...


#### Update 

###### Update 1.1 
Added slippery graph And Chart Animations
Example 

Directly Run To See XJYChart Example


使用该框架的App
- 急用钱

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image3.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)

