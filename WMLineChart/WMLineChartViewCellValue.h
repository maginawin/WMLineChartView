//
//  WMLineChartViewCellValue.h
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMLineChartViewCellValue : NSObject

@property (assign, nonatomic) CGFloat start;
@property (assign, nonatomic) CGFloat end;
@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineWidth;

@end
