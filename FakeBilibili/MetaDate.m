//
//  MetaDate.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/7.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "MetaDate.h"
#import "WeatherReformer.h"

@interface MetaDate ()

@end

@implementation MetaDate

+ (instancetype)shareInstance {
    static MetaDate *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[MetaDate alloc] init];
    });
    return data;
}

- (NSDictionary *)reformRawData:(id)rawData {
    NSDictionary *data = [WeatherReformer reformRawData:rawData];
    return data;
}

- (NSArray *)reformMetaData:(NSDictionary *)metaData {
    NSArray *weatherArray = [WeatherReformer reformWithDictionary:(NSDictionary *)metaData];
    return weatherArray;
}

- (NSArray *)fetchSingerWeatherArray:(NSArray *)array fonIndex:(NSInteger)index {
    NSArray *singerWeather = [WeatherReformer fetchSingerWeatherInArray:array forIndex:index];
    return singerWeather[0];
}

@end
