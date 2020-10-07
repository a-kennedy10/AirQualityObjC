//
//  DVMPollution.m
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DVMPollution.h"

@implementation DVMPollution

-(instancetype)initWithAirQualityIndex:(NSInteger)airQualityIndex
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = airQualityIndex;
    }
    return self;
}

@end

@implementation DVMPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger airQualityIndex = [dictionary[@"aqius"] integerValue];
    
    return [self initWithAirQualityIndex:airQualityIndex];
}

@end


