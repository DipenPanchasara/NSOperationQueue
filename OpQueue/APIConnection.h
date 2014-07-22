//
//  APIConnection.h
//  GeoDate
//
//  Created by I-VERVE7 on 13/06/13.
//  Copyright (c) 2013 iVerve. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface APIConnection : NSOperation
{
    NSData *responseData;
}

@property (nonatomic, retain) NSData *responseData;
@property (nonatomic, copy) void(^errorHandler)(NSString *err);


#pragma mark - Initiate the request
- (id)initWithAction:(NSMutableDictionary *)params;

#pragma mark - POST Data
- (void)postRequestJSONData:(NSDictionary *)postVars;

@end
