//
//  DLNetWorkManager.h
//  FakeBilibili
//
//  Created by 李林 on 16/6/6.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DLNetWorkingDelegate <NSObject>

- (void)responseSuccessWithObject:(id)object;

@end

@interface DLNetWorkManager : NSObject

@property (nonatomic, weak) id <DLNetWorkingDelegate> delegate;

+ (instancetype)shareInstance;
- (void)requestWithPath:(NSString *)path;
- (void)requestWithPath:(NSString *)path param:(NSDictionary *)param;

@end
