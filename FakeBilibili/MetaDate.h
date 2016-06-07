//
//  MetaDate.h
//  FakeBilibili
//
//  Created by 李林 on 16/6/7.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaDate : NSObject

//@property (nonatomic, strong) NSDictionary *weather;
+ (instancetype)shareInstance;

- (NSDictionary *)reformRawData:(id)rawData;
- (NSArray *)reformMetaData:(NSDictionary *)metaData;
- (NSDictionary *)fetchSingerWeatherArray:(NSArray *)array fonIndex:(NSInteger)index;

@end
