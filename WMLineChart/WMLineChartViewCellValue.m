//
//  WMLineChartViewCellValue.m
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import "WMLineChartViewCellValue.h"

@implementation WMLineChartViewCellValue

- (CGFloat)lineWidth {
    if (_lineWidth < 0.5f) {
        _lineWidth = 0.5f;
    }
    
    return _lineWidth;
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor darkGrayColor];
    }
    
    return _lineColor;
}

@end
