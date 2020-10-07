//
//  DVMWeather.h
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DVMWeather : NSObject

@property (nonatomic, readonly)NSInteger temperature;
@property (nonatomic, readonly)NSInteger humidity;
@property (nonatomic, readonly)NSInteger windSpeed;

-(instancetype)initWithTemperature:(NSInteger)temperature
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed;

@end

@interface DVMWeather (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end


