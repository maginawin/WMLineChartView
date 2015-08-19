//
//  WMLineChartViewCell.m
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import "WMLineChartViewCell.h"
#import "WMLineChartViewCellValue.h"

@interface WMLineChartViewCell ()

@property (strong, nonatomic) CAShapeLayer *mLayer;
@property (strong, nonatomic) UIBezierPath *mPath;

@end

@implementation WMLineChartViewCell

- (void)setValue:(WMLineChartViewCellValue *)value {
    if (!_mLayer) {
        _mLayer = [CAShapeLayer layer];
        
        [self.layer addSublayer:_mLayer];
    }
    
    if (!_mPath) {
        _mPath = [[UIBezierPath alloc] init];
    }
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    [_mPath removeAllPoints];
    
    [_mPath moveToPoint:CGPointMake(0.f, (1 - value.start) * height)];
    [_mPath addLineToPoint:CGPointMake(width, (1 - value.end) * height)];

    _mLayer.path = _mPath.CGPath;
    _mLayer.strokeColor = value.lineColor.CGColor;
    _mLayer.lineWidth = value.lineWidth;
    _mLayer.strokeStart = 0.f;
    _mLayer.strokeEnd = 1.f;
    _mLayer.lineCap = kCALineCapRound;
}

@end
