//
//  DVMCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVMAirQuality;

@interface DVMCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *, NSError *))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void (^) (NSArray<NSString *> *, NSError *))completion;
+(void)fetchSupportedCitiesInState:(NSString *)country
                        completion:(NSString *)state
                        completion:(void (^) (NSArray<NSString *> *, NSError *))completion;

+(void)fetchDataForCity:(NSString *)country
             completion:(NSString *)state
             completion:(NSString *)city
             completion:(void (^) (DVMAirQuality *_Nullable))completion;

@end

