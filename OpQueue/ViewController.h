//
//  ViewController.h
//  OpQueue
//
//  Created by Dipen on 21/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController //<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableDictionary *dictOperations;
    NSOperationQueue *downloadQueue, *serverDateTimeQueue;
    NSArray *array;
}

@property (nonatomic, strong) NSOperationQueue *downloadQueue, *serverDateTimeQueue;

@end
