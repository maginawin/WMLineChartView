//
//  WMLineChartView.m
//  WMLineChart
//
//  Created by wangwendong on 15/8/19.
//  Copyright (c) 2015年 wangwendong. All rights reserved.
//

#import "WMLineChartView.h"
#import "WMLineChartViewCell.h"

const CGFloat kLineChartViewNormalCellWidth = 44.f;

@interface WMLineChartView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mScrollView;
@property (strong, nonatomic) NSMutableArray *mCells;

@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation WMLineChartView

- (void)setDatasource:(id<WMLineChartViewDatasource>)datasource {
    _datasource = datasource;
    
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mCells = [NSMutableArray array];
    }
    
    _mScrollView.bounces = NO;
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.showsVerticalScrollIndicator = NO;
    _mScrollView.delegate = self;
    
    _currentIndex = 0;
    
    [self reloadData];
}

- (void)reloadData {
    NSInteger cellNumbers = [_datasource lineChartViewCellNumbers];
    CGFloat cellWidth = kLineChartViewNormalCellWidth;
    CGFloat totalWidth = 0;
    
    for (UIView *view in _mCells) {
        [view removeFromSuperview];
    }
    [_mCells removeAllObjects];
    _currentIndex = 0;
    
    
    for (NSInteger i = _currentIndex; i < cellNumbers; i++) {
        if ([_datasource respondsToSelector:@selector(lineChartView:cellWidthAtIndex:)]) {
            cellWidth = [_datasource lineChartView:self cellWidthAtIndex:i];
        }
        
        totalWidth += cellWidth;
        WMLineChartViewCell *cell = [_datasource lineChartView:self atIndex:i];
        
        if (!cell) {
            return;
        }
        
        CGRect cellFrame = CGRectMake(totalWidth - cellWidth, 0, cellWidth, CGRectGetHeight(self.bounds));
        cell.frame = cellFrame;
        [_mCells addObject:cell];
        [_mScrollView addSubview:cell];
        
        if (totalWidth > CGRectGetWidth(self.bounds) + cellWidth) {
            _mScrollView.contentSize = CGSizeMake(totalWidth, 0);
            break;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat cellWidth = [_datasource lineChartView:self cellWidthAtIndex:_currentIndex];
    WMLineChartViewCell *frontCell = _mCells[_currentIndex];
    
    if (frontCell) {
        CGFloat xBorder = cellWidth + frontCell.frame.origin.x;
        
        CGPoint scrollViewPoint = scrollView.contentOffset;
        if (scrollViewPoint.x > xBorder) {
            [frontCell removeFromSuperview];
            [_mCells removeObject:frontCell];
            
            _currentIndex += 1;
            NSInteger cellNumbers = [_datasource lineChartViewCellNumbers];
            
            if (_currentIndex + _mCells.count < cellNumbers) {
                WMLineChartViewCell *lastCell = [_datasource lineChartView:self atIndex:_currentIndex + _mCells.count];
                WMLineChartViewCell *endCell = (WMLineChartViewCell *)_mCells.lastObject;
                CGRect cellFrame = CGRectMake(endCell.frame.origin.x + CGRectGetWidth(lastCell.bounds), 0, CGRectGetWidth(lastCell.bounds), CGRectGetHeight(lastCell.bounds));
                endCell.frame = cellFrame;
                [_mCells addObject:lastCell];
                [_mScrollView addSubview:lastCell];
            }
        }
    }
}

@end
