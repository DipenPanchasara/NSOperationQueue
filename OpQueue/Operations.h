//
//  Operations.h
//  OpQueue
//
//  Created by Dipen on 21/07/14.
//  Copyright (c) 2014 Dipen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operations : NSOperation


@property (nonatomic, retain) id object;
//@property (nonatomic, retain) NSURL *imageURL;
//@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic, readwrite) NSInteger currentAction;
//@property (nonatomic, retain) NSString *filePath;
//@property (nonatomic ,retain) UIImage *image;
@property (nonatomic, copy) void(^erroHandler)(NSString *err);
@property (nonatomic, copy) void(^successHandler)(id response);

//- (id)initWithURL:(NSURL *)URL;
- (id)initWithObject:(id)objectType andAction:(NSInteger)action;
- (void)cancelDownload;


@end
