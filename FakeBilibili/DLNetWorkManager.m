//
//  DLNetWorkManager.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/6.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "DLNetWorkManager.h"
#import "AFNetworking.h"

static NSString *kBaseUrl = @"http://www.raywenderlich.com/demos/weather_sample/";

@interface DLNetWorkManager ()

@property (nonatomic, strong) NSURL *baseUrl;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation DLNetWorkManager

+ (instancetype)shareInstance {
    static DLNetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DLNetWorkManager alloc] init];
    });
    return manager;
}

- (void)requestWithPath:(NSString *)path param:(NSDictionary *)param {
    [self.sessionManager.operationQueue cancelAllOperations];
    [self.sessionManager GET:[NSString stringWithFormat:@"%@.php", path]
                  parameters:param
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         if ([self.delegate respondsToSelector:@selector(responseSuccessWithObject:)]) {
                             [self.delegate responseSuccessWithObject:responseObject];
                         }
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"error is %@", error);
                     }];
}

- (void)requestWithPath:(NSString *)path {
    NSString *string = [NSString stringWithFormat:@"%@%@.php?format=json",kBaseUrl,path];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operattion = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operattion.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operattion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([self.delegate respondsToSelector:@selector(responseSuccessWithObject:)]) {
            [self.delegate responseSuccessWithObject:responseObject];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error is %@", error);
    }];
    
    [operattion start];
}

#pragma mark - getter & setter
- (NSURL *)baseUrl {
    if (_baseUrl == nil) {
        _baseUrl = [NSURL URLWithString:kBaseUrl];
    }
    return _baseUrl;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseUrl];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}

@end
