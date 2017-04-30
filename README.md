#### XJYChart

 A High-performance, Elegant And Easy-to-integrate Charting Framework.

![gif](https://github.com/JunyiXie/XJYChart/raw/master/photos/XJYChart.gif)



 Update 0.0.2

Clear abandoned API

 Update :
Add The positive and negative Bar Chart**

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)




###### Installation With CocoaPods
```
pod 'XJYChart'
```

> How to Use

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
XJYPieItem *item3 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:13.43] color:colorArray[2] dataDescribe:dataArray[2]];
[pieItems addObject:item3];
XJYPieItem *item4 = [[XJYPieItem alloc] initWithDataNumber:[NSNumber numberWithDouble:52] color:colorArray[3] dataDescribe:dataArray[3]];
[pieItems addObject:item4];
        
self.pieChartView.dataItemArray = pieItems;
        

```

###### ChartColor 
Provide many colors In XJYColor.h
XJYSkyBlue
XJYGrey
XJYLightBlue
...


###### Update 

###### Update 1.1 
Added slippery graph And Chart Animations
Example 

Directly Run To See XJYChart Example

![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image1.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image3.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image4.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image5.PNG)
![image](https://github.com/JunyiXie/XJYChart/raw/master/photos/image6.PNG)

