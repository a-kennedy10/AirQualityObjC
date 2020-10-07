//
//  DVMCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//
// URL: https://api.airvisual.com/

#import "DVMCityAirQualityController.h"
#import "DVMAirQuality.h"

static NSString *const baseURLString = @"https://api.airvisual.com/";
static NSString *const versionComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apikey = @"38665520-a636-48a0-a132-5bc4293e3709";

@implementation DVMCityAirQualityController

+(void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apikey];
    [queryItems addObject:apiKeyQuery];
    
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if(!data)
        {
            NSLog(@"Error, no data returned from task");
            completion(nil, error);
            return;
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            
            NSMutableArray *countries = [NSMutableArray new];
            for (NSDictionary *countryDictionary in dataDictionary)
            {
                NSString *country = [[NSString alloc] initWithString:countryDictionary[@"country"]];
                [countries addObject:country];
            }
            completion(countries, nil);
        }
    }]resume];
}

+(void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apikey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            NSMutableArray *states = [NSMutableArray new];
            for (NSDictionary *stateDictionary in dataDictionary)
            {
                NSString *state = stateDictionary[@"state"];
                [states addObject:state];
            }
            completion(states, nil);
        }
    }] resume];
}

+(void)fetchSupportedCitiesInState:(NSString *)country completion:(NSString *)state completion:(void (^)(NSArray<NSString *> * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apikey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
        }
        
        if (data)
        {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDictionary in dataDictionary)
            {
                NSString *city = cityDictionary[@"city"];
                [cities addObject:city];
            }
            completion(cities, nil);
        }
    }]resume];
}

+(void)fetchDataForCity:(NSString *)country completion:(NSString *)state completion:(NSString *)city completion:(void (^)(NSArray<DVMAirQuality *> * _Nonnull, NSError * _Nonnull))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apikey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (error)
    {
        NSLog(@"%@", error, [error localizedDescription]);
        completion(nil, error);
        return;
    }
    
    if (!data)
    {
        NSLog(@"%@", error);
    }
    
    if (data)
    {
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        
        DVMAirQuality *cityAQI = [[DVMAirQuality alloc] initWithDictionary:dataDictionary];
        completion(cityAQI, nil);
        
        }
    }]resume];
}
    
    
@end
