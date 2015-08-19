//
//  WMLineChartView.h
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMLineChartViewCell;

@protocol WMLineChartViewDatasource;

@interface WMLineChartView : UIView

@property (weak, nonatomic) id<WMLineChartViewDatasource> datasource;

- (void)reloadData;

@end

@protocol WMLineChartViewDatasource <NSObject>

@required

- (WMLineChartViewCell *)lineChartView:(WMLineChartView *)lineChartView atIndex:(NSInteger)index;

- (NSInteger)lineChartViewCellNumbers;

@optional

- (CGFloat)lineChartView:(WMLineChartView *)lineChartView cellWidthAtIndex:(NSInteger)index;

//- (CGFloat)lineChartView:(WMLineChartView *)lineChartView cellHeightAtIndex:(NSInteger)index;

@end