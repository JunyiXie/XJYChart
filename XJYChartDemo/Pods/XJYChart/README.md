
## XJYChart

<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG" align="left" height="472" width="260" ></a>
<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG" align="left" height="472" width="260" ></a>
<a href="url"><img src="https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG" align="left" height="472" width="260" ></a>

[![Version](https://img.shields.io/cocoapods/v/XJYChart.svg?style=flat)](http://cocoapods.org/pods/XJYChart)
[![Platform](https://img.shields.io/cocoapods/p/XJYChart.svg?style=flat)](http://cocoapods.org/pods/XJYChart)
[![License](https://img.shields.io/cocoapods/l/XJYChart.svg?style=flat)](https://github.com/EyreFree/XJYChart/blob/master/LICENSE)

> XJYChart - A High-performance, Elegant, Easy-to-integrate Charting Framework.
> The Best iOS Objc Charts.

- [x] **chart more beautiful**
- [x] **support chart scroll**
- [x] **support chart area fill**
- [x] **support chart animation**
- [x] **support chart touch**
- [x] **support chart highlight**
 


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

**Qucikly Use**

Eg:
- [AreaLineExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/AreaLineTableViewCell.m)

- [BarChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/BarChartCell.m)

- [CycleChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/CycleTableViewCell.m)

- [LineChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/LineChartCell.m)

- [PieChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/PieChartCell.m)

- [PositiveNegativeBarChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/PositiveNegativeBarChartCell.m)

- [StackAreaLineChartExample](https://github.com/JunyiXie/XJYChart/blob/master/XJYChartDemo/XJYChartDemo/View/StackAreaTableViewCell.m)

**Initialization**
```objectivec
- (instancetype)initWithFrame:(CGRect)frame 
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray 
            dataDiscribeArray:(NSMutableArray<NSString*>*)dataDiscribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XLineGraphMode)graphMode
           chartConfiguration:(XLineChartConfiguration*)configuration;
```

- frame: The frame rectangle for the view
- dataItemArray: data for lines
- topNumber: ordinate coordinate top number
- bottomNumber: ordinate bottom top number
- graphMode: which kind of line chart you want to use.eg: MutiLineGraph,AreaLineGraph,StackAreaLineGraph
- chartConfiguration: detail configuration for chart. like lineMode, shadow

**Chart Data**
```objectivec
- (instancetype)initWithDataNumberArray:(NSMutableArray*)numberArray
                                  color:(UIColor*)color;
```
- numberArray: values in line
- color: line fill color

**Chart Configuration**
```objectivec
XNormalLineChartConfiguration* configuration =
   [[XNormalLineChartConfiguration alloc] init];
configuration.lineMode = CurveLine;
configuration.isShowShadow = YES;
```


## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

XJYChart is available under the MIT license. See the LICENSE file for more info.


