//
//  DVMAirQuality.m
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMAirQuality.h"
#import "DVMWeather.h"
#import "DVMPollution.h"

@implementation DVMAirQuality

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(id)weather pollution:(id)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;

    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    DVMWeather *weather = [[DVMWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    DVMPollution *pollution = [[DVMPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}


@end
