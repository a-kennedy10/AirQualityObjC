//
//  DVMPollution.h
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DVMPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithAirQualityIndex:(NSInteger)airQualityIndex;


@end

@interface DVMPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end


