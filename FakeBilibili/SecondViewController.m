//
//  SecondViewController.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/2.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "SecondViewController.h"
#import "Define.h"
#import "DLSecondTableCell.h"
#import "DLNetWorkManager.h"
#import "MetaDate.h"
#import "WeatherReformer.h"

#define kTextFieldHeight 40

static NSString *kTableViewCellIdentifie = @"SecondTableCellIdentifier";
@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate, DLNetWorkingDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIView *tableHeader;
@property (nonatomic, strong) UIView *tableFooter;
@property (nonatomic, strong) DLNetWorkManager *manager;
@property (nonatomic, strong) MetaDate *metaData;

@property (nonatomic, strong) NSArray *weatherArray;

@end

@implementation SecondViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setting];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.button];
    [self.view addSubview:self.tableView];
    [self.tableView.tableHeaderView addSubview:self.tableHeader];
    [self.tableView.tableFooterView addSubview:self.tableFooter];
    [self loadLayout];
    
//    @weakify(self)
//    [[self.textField.rac_textSignal
//     map:^id(NSString *text) {
//         return [self isValidTextField:text] ? [UIColor whiteColor] : [UIColor darkGrayColor];
//     }]
//     subscribeNext:^(UIColor *color) {
//         @strongify(self)
//         self.textField.backgroundColor = color;
//     }];
    
    RACSignal *validTextFieldSignal = [self.textField.rac_textSignal
                                       map:^id(NSString *text) {
                                           return @([self isValidTextField:text]);
                                       }];
    
    RAC(self.textField, backgroundColor) = [validTextFieldSignal
                                            map:^id(NSNumber *textValid) {
                                                return [textValid boolValue] ? [UIColor whiteColor] : [UIColor darkGrayColor];
                                            }];
    
    [[[self.button rac_signalForControlEvents:UIControlEventTouchUpInside]
     flattenMap:^RACStream *(id value) {
         return [self requestSignal];
     }]
     subscribeNext:^(NSNumber *validKeyword) {
         NSLog(@"result is %@", validKeyword);
         if ([validKeyword boolValue]) {
             [self didTappedButton:self.button];
         }
     }];
}

- (void)loadLayout {
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kPadding);
        make.left.mas_equalTo(self.view).mas_offset(kPadding);
        make.bottom.mas_equalTo(self.view).mas_offset(-kPadding);
        make.right.mas_equalTo(self.view).mas_offset(-kPadding);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, kTextFieldHeight));
        make.top.mas_equalTo(self.view).mas_offset(STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT);
        make.left.mas_equalTo(self.view);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, kTextFieldHeight));
        make.top.mas_equalTo(self.textField);
        make.left.mas_equalTo(self.textField.mas_right);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - kTextFieldHeight)));
        make.top.mas_equalTo(self.textField.mas_bottom);
        make.left.mas_equalTo(self.view);
    }];
    [self.tableHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    [self.tableFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.weatherArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLSecondTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifie forIndexPath:indexPath];
    NSDictionary *weatherDictionary = [self.metaData fetchSingerWeatherArray:self.weatherArray fonIndex:indexPath.row];
    cell.weather = weatherDictionary[@"value"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - DLNetWorkingDelegate
- (void)responseSuccessWithObject:(id)object {
    self.weatherArray = [self.metaData reformMetaData:[self.metaData reformRawData:object]];
    [self.tableView reloadData];
    self.button.enabled = YES;
}

#pragma mark - event response
- (void)didTappedButton:(UIButton *)button {
    NSDictionary *param = @{@"format":@"json"};
    [self.manager requestWithPath:@"weather" param:param];
    self.button.enabled = NO;
    //    [self.manager requestWithPath:@"weather"];
    
}

#pragma mark - private method
- (void)setting {
    [self setNavigation];
}

- (void)setNavigation {
    self.title = @"Assitstant";
}

- (BOOL)isValidTextField:(NSString *)text {
    return text.length > 2;
}

- (RACSignal *)requestSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self validRequestKeyword:self.textField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

- (void)validRequestKeyword:(NSString *)keyword complete:(void (^)(BOOL success))completeBlock {
    if ([keyword isEqualToString:@"weather"]) {
        completeBlock(YES);
    }
    else {
        completeBlock(NO);
    }
}

#pragma mark - getter & setter 
- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor cyanColor];
    }
    return _backgroundView;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor darkGrayColor];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

- (UIButton *)button {
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        _button.layer.cornerRadius = 5;
        [_button setBackgroundColor:[UIColor darkGrayColor]];
         NSString *title = @"确定";
        NSAttributedString *normalAttrTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                                                                                      NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        [_button setAttributedTitle:normalAttrTitle forState:UIControlStateNormal];
        NSAttributedString *highlightAttrtitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                                                                                            NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [_button setAttributedTitle:highlightAttrtitle forState:UIControlStateHighlighted];
//        [_button addTarget:self action:@selector(didTappedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        [_tableView registerClass:[DLSecondTableCell class] forCellReuseIdentifier:kTableViewCellIdentifie];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)tableHeader {
    if (_tableHeader == nil) {
        _tableHeader = [[UIView alloc] init];
        _tableHeader.backgroundColor = [UIColor blueColor];
    }
    return _tableHeader;
}

- (UIView *)tableFooter {
    if (_tableFooter == nil) {
        _tableFooter = [[UIView alloc] init];
        _tableFooter.backgroundColor = [UIColor blueColor];
    }
    return _tableFooter;
}

- (DLNetWorkManager *)manager {
    if (_manager == nil) {
        _manager = [DLNetWorkManager shareInstance];
        _manager.delegate = self;
    }
    return _manager;
}

- (MetaDate *)metaData {
    if (_metaData == nil) {
        _metaData = [MetaDate shareInstance];
    }
    return _metaData;
}

@end
