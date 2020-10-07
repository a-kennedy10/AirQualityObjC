//
//  DVMAirQuality.h
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
// 38665520-a636-48a0-a132-5bc4293e3709

#import <Foundation/Foundation.h>
@class DVMPollution;
@class DVMWeather;



@interface DVMAirQuality : NSObject

@property (nonatomic, copy, readonly)NSString *city;
@property (nonatomic, copy, readonly)NSString *state;
@property (nonatomic, copy, readonly)NSString *country;
@property (nonatomic, copy, readonly)DVMWeather *weather;
@property (nonatomic, copy, readonly)DVMPollution *pollution;

-(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(DVMWeather *)weather
                  pollution:(DVMPollution *)pollution;

@end

@interface DVMAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end


