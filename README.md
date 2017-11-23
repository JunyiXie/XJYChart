
![fun](https://github.com/JunyiXie/XJYChart/raw/master/photos/icon.png) 
![release](https://img.shields.io/badge/XJYChart-v1.0.0-blue.svg)
[![Version](https://img.shields.io/cocoapods/v/XJYChart.svg?style=flat)](http://cocoapods.org/pods/XJYChart)
[![Platform](https://img.shields.io/cocoapods/p/XJYChart.svg?style=flat)](http://cocoapods.org/pods/XJYChart)
[![License](https://img.shields.io/cocoapods/l/XJYChart.svg?style=flat)](https://github.com/EyreFree/XJYChart/blob/master/LICENSE)

> XJYChart - A High-performance, Elegant, Easy-to-integrate Charting Framework.
 
## Overview

<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image3.PNG" align="left" height="535" width="300" ></a>
<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG" align="left" height="535" width="300" ></a>
<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG" align="left" height="535" width="300" ></a>
<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG" align="left" height="535" width="300" ></a>

## Charts

- [x] **LineChart**
- [x] **BarChart**
- [x] **PositiveNegativeBarChart**
- [x] **PieChart**
- [x] **CycleChart**

## Features

- [x] **Animation**
- [x] **Touch**
- [x] **Scroll**
- [x] **Beautiful**

![gif](https://github.com/JunyiXie/XJYChart/raw/master/photos/XJYChart.gif)

## Installation

### CocoaPods

XJYChart is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XJYChart"
```

Then, run the following command:

```bash
$ pod install
```

## How to Use

### XPositiveNegativeBarChart

```objectivec
XPositiveNegativeBarChart *barChart = [[XPositiveNegativeBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@100 bottomNumber:@(-170)];
```

### XLineChart

- colorMode

```diff
+ lineMode
+ CurveLine
+ BrokenLine
```

```objectivec
- (instancetype)initWithFrame:(CGRect)frame dataItemArray:(NSMutableArray<XLineChartItem *> *)dataItemArray dataDiscribeArray:(NSMutableArray<NSString *> *)dataDiscribeArray topNumber:(NSNumber *)topNumbser bottomNumber:(NSNumber *)bottomNumber;
```

### XLineChartItem

```objectivec
- (instancetype)initWithDataNumberArray:(NSMutableArray *)numberArray color:(UIColor *)color dataDescribe:(NSString *)dataDescribe;
```

LineGraphMode:
MutiLineGraph
AreaLineGraph

```objectivec
XLineChart *lineChart = [[XLineChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray dataDiscribeArray:[NSMutableArray arrayWithArray:@[@"January", @"February", @"March", @"April", @"May"]] topNumber:@200 bottomNumber:@0  graphMode:MutiLineGraph];
```

### Cycle Chart

```objectivec
//XCycleView
- (instancetype)initWithFrame:(CGRect)frame;
```

### BarChart

```objectivec
XBarChart *barChart = [[XBarChart alloc] initWithFrame:CGRectMake(0, 0, 375, 200) dataItemArray:itemArray topNumber:@150 bottomNumber:@(0)];
```

- BarChartdelegate

```objectivec
- (void)touchBarAtIdx:(NSUInteger)idx;
```

### PieChart

```objectivec
self.pieChartView = [[XPieChart alloc] init];
NSMutableArray *pieItems = [[NSMutableArray alloc] init];
NSArray *colorArray = @[RGB(145, 235, 253), RGB(198, 255, 150), RGB(254, 248, 150), RGB(253, 210, 147)];
NSArray *dataArray = @[@"iPhone6",@"iPhone6 Plus",@"iPhone6s",@"其他"];
XPieItem *item1 = [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:20.9] color:colorArray[0] dataDescribe:dataArray[0]];
[pieItems addObject:item1];
XPieItem *item2 = [[XPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:14.82] color:colorArray[1] dataDescribe:dataArray[1]];
[pieItems addObject:item2];  
self.pieChartView.dataItemArray = pieItems;
```

### ChartColor 

Provide many colors In XColor.h
...

## Update 

### Update 1.1.0

Added slippery graph And Chart Animations
Example 

```diff
+ .CurveLine
+ .AreaGraph
+ .StackAreaGraph
```

### Update 1.0.0

```diff
+ Add XCycleView   
```

- touch
- gradient

Use XIB or Code

```objectivec
//XCycleView
- (instancetype)initWithFrame:(CGRect)frame;
```

### Update 0.0.2

```diff
- Clear abandoned API
+ Add The positive and negative Bar Chart**
```

## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

XJYChart is available under the MIT license. See the LICENSE file for more info.
