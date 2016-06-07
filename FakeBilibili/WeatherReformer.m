//
//  WeatherReformer.m
//  FakeBilibili
//
//  Created by 李林 on 16/6/7.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import "WeatherReformer.h"

@implementation WeatherReformer

+ (NSDictionary *)reformRawData:(id)object {
    NSDictionary *dictionary = (NSDictionary *)object[@"data"];
    
    return dictionary;
}

+ (NSArray *)reformWithDictionary:(NSDictionary *)dictionary {
    NSArray *weather = dictionary[@"weather"];
    return weather;
}

+ (NSArray *)fetchSingerWeatherInArray:(NSArray *)array forIndex:(NSInteger)index {
    NSDictionary *singerDictionary = array[index];
    return singerDictionary[@"weatherDesc"];
}

@end
