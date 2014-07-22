//
//  DemoViewController.h
//  OpQueue
//
//  Created by Dipen on 21/07/14.
//  Copyright (c) 2014 Dipen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *cvImages;
    
    NSMutableDictionary *dictOperations;
    NSOperationQueue *downloadQueue;
    NSArray *array;
}

@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end
