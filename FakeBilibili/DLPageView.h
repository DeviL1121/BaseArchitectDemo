//
//  DLPageView.h
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLPageViewDelegate <NSObject>

@optional
- (void)filpPageToIndex:(NSInteger)index;

@end

@interface DLPageView : UIView

@property (nonatomic, weak) id <DLPageViewDelegate> delegate;
- (instancetype)initWithData:(NSMutableArray *)dataArray;
- (void)indicatorChangeToIndex:(NSInteger)index;
@end
