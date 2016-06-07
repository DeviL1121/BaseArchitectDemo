//
//  WeatherReformer.h
//  FakeBilibili
//
//  Created by 李林 on 16/6/7.
//  Copyright © 2016年 DeviL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherReformer : NSObject

+ (NSDictionary *)reformRawData:(id)object;
+ (NSArray *)reformWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)fetchSingerWeatherInArray:(NSArray *)array forIndex:(NSInteger)index;

@end
