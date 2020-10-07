//
//  DVMWeather.m
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMWeather.h"

@implementation DVMWeather

-(instancetype)initWithTemperature:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed
{
    self = [super init];
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation DVMWeather (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"]integerValue];
    NSInteger humidity = [dictionary[@"hu"]integerValue];
    NSInteger windSpeed = [dictionary[@"ws"]integerValue];
    
    return [self initWithTemperature:temperature humidity:humidity windSpeed:windSpeed];
    
}

@end
