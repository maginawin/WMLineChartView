//
//  ViewController.m
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import "ViewController.h"
#import "WMLineChartViewCell.h"
#import "WMLineChartViewCellValue.h"
#import "WMLineChartView.h"

@interface ViewController () <WMLineChartViewDatasource>

// TEST
@property (strong, nonatomic) WMLineChartView *lineChartView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TEST
    [self test_lineChartViewCell];
}

#pragma mark - WMLineChartViewDatasource

- (NSInteger)lineChartViewCellNumbers {
    return 2;
}

- (CGFloat)lineChartView:(WMLineChartView *)lineChartView cellWidthAtIndex:(NSInteger)index {
    return 20.f;
}

- (WMLineChartViewCell *)lineChartView:(WMLineChartView *)lineChartView atIndex:(NSInteger)index {
    if (index < _datas.count - 1) {
        WMLineChartViewCell *cell = [[WMLineChartViewCell alloc] init];
        WMLineChartViewCellValue *value = [[WMLineChartViewCellValue alloc] init];
        value.start = [_datas[index] doubleValue] / 200.f;
        value.end = [_datas[index + 1] doubleValue] / 200.f;
        value.lineColor = [UIColor blueColor];
        value.lineWidth = 8.f;
        
        cell.value = value;
        
        return cell;
    }
    
    return nil;
}

#pragma mark - TEST

- (void)test_lineChartViewCell {
    
    _datas = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        NSNumber *data = [NSNumber numberWithInt:arc4random() % 200];
        [_datas addObject:data];
    }
    
    _lineChartView = [[WMLineChartView alloc] initWithFrame:CGRectMake(0, 64, 320, 240)];
    [self.view addSubview:_lineChartView];
    
    _lineChartView.datasource = self;
}

@end
