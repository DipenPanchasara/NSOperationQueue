//
//  Operations.m
//  OpQueue
//
//  Created by Dipen on 21/07/14.
//  Copyright (c) 2014 Dipen. All rights reserved.
//

#define kRequestTimeOut     30
#define kAPIstatus          @"status"
#define RESPONSE_STATUS_OK  @"OK"
#define RESPONSE_STATUS_ERR @"ERROR"

#import "Operations.h"

//@interface ImageDownloader ()

//@property (nonatomic, strong) NSMutableData *activeDownload;
//@property (nonatomic, strong) NSURLConnection *imageConnection;

//@end

@implementation Operations

//@synthesize imageURL, filePath, image;

- (id)initWithObject:(id)objectType andAction:(NSInteger)action
{
    self = [super init];
    if(self)
        
    {
        self.currentAction = action;
        _object = objectType;
//        self.imageURL = URL;

    }
    return self;
}

#pragma mark
- (void)main
{
    switch (self.currentAction) {
        case IMAGE_DOWLOAD:
        {
//            [self setImageURL:(NSURL *)_object];
            [self downloadImageWithURL:(NSURL *)_object];
        }
            break;
        case API_CALL:
            [self postAsyncRequestJSONData:(NSDictionary *)_object];
            break;
        default:
            break;
    }
}

- (void)downloadImageWithURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSHTTPURLResponse *response = nil;
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    if(image)
    {
        // *** Save Image to Documents Directory ***
        NSString *filePath = [DOC_DIR stringByAppendingPathComponent:[url lastPathComponent]];
        if([[url pathExtension] isEqualToString:@"png"])
        {
            if([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES])
                if(self.successHandler)
                    self.successHandler(image);
        }
        else
        {
            if([UIImageJPEGRepresentation(image, 1.0f) writeToFile:filePath atomically:YES])
                if(self.successHandler)
                    self.successHandler(image);
        }
    }
    else
    {
        if(self.erroHandler)
            self.erroHandler([NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]]);
    }
}

- (void)postAsyncRequestJSONData:(NSDictionary *)postVars
{
    NSURL *url = [NSURL URLWithString:@"Your URL Here"];
    
    NSString *contentType = @"application/json";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSError *err = nil;
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:postVars options:NSJSONWritingPrettyPrinted error:&err];
    
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField: @"Content-Length"];
    
    [request setTimeoutInterval:kRequestTimeOut];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *resData = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:&response
                                                        error:&error];
    if (error != nil) {
        if(self.erroHandler)
            self.erroHandler([NSHTTPURLResponse localizedStringForStatusCode:[response statusCode]]);
    }
    else
    {
        if(self.successHandler)
            self.successHandler(resData);
    }
}


- (void)cancelDownload
{
    [self cancel];
}

@end
