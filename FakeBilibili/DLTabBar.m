//
//  DLTabBar.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLTabBar.h"
#import "Define.h"

#define kTabBarButtonWidth self.frame.size.width / 3
#define kTabBarButtonHeight 49

@interface DLTabBar ()

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation DLTabBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.centerButton];
        [self loadLayout];
    }
    return self;
}

- (void)loadLayout {
    [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.centerButton.currentBackgroundImage.size.width, self.centerButton.currentBackgroundImage.size.height));
        make.center.mas_equalTo(self);
    }];
}

- (void)layoutSubviews {
    NSInteger tabBarButtonIndex = 0;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subview.frame = CGRectMake(tabBarButtonIndex * kTabBarButtonWidth, 0, kTabBarButtonWidth, kTabBarButtonHeight);
            tabBarButtonIndex ++;
            if (tabBarButtonIndex == 1) {
                tabBarButtonIndex ++;
            }
        }
    }
    
}

#pragma mark - response
- (void)tapCenterButton {
    NSLog(@"点击中间按钮");
}


#pragma mark - getter & setter 
- (UIButton *)centerButton {
    if (_centerButton == nil) {
        _centerButton = [[UIButton alloc] init];
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_centerButton addTarget:self action:@selector(tapCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

@end
