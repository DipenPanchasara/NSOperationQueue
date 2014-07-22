//
//  ViewController.m
//  OpQueue
//
//  Created by Dipen on 21/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "DemoViewController.h"
#import "Operations.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize downloadQueue, serverDateTimeQueue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        // Do any additional setup after loading the view, typically from a nib.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *directory = DOC_DIR;
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error]) {
        BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@/%@", directory, file] error:&error];

        if (!success || error) {
            // it failed.
            NSLog(@"%@",file);
        }
    }
    
    
    self.downloadQueue = [[NSOperationQueue alloc] init];
    self.serverDateTimeQueue = [[NSOperationQueue alloc] init];
    [self.serverDateTimeQueue setMaxConcurrentOperationCount:5];
    
    array = [[NSArray alloc] initWithObjects:@"http://a568.phobos.apple.com/us/r30/Purple4/v4/1b/c8/0a/1bc80aea-d63d-0c20-8800-e55038b41453/mzl.eqnecgto.100x100-75.png",
             @"http://a122.phobos.apple.com/us/r30/Purple4/v4/ae/b2/a8/aeb2a89e-1925-43a4-6b9c-03d82a08db83/mzl.ubwpnmsk.100x100-75.png",
             @"http://a1792.phobos.apple.com/us/r30/Purple4/v4/3a/c4/b0/3ac4b095-496e-a2a5-7c0d-20ec03faa415/mzl.aacuufqa.100x100-75.png",
             @"http://a1269.phobos.apple.com/us/r30/Purple4/v4/29/e9/66/29e96676-f267-a590-37fb-9202e5a7d0ca/mzl.bknecdsp.100x100-75.png",
             @"http://a362.phobos.apple.com/us/r30/Purple2/v4/f0/15/2c/f0152ce2-f9a7-d599-e3c2-f975d1ae62f5/mzl.azfpmgmh.100x100-75.png",
             @"http://a1958.phobos.apple.com/us/r30/Purple4/v4/d9/79/e9/d979e9d7-25ef-206f-cd4d-1f2a55d76fc8/mzl.oyljxfjm.100x100-75.png",
             @"http://a405.phobos.apple.com/us/r30/Purple/v4/fc/9c/cc/fc9ccca5-43f6-43d0-c1f2-0dca2244a923/mzl.edouujqd.100x100-75.png",
             @"http://a389.phobos.apple.com/us/r30/Purple/v4/cb/86/36/cb86364b-c26f-44ae-b903-07f86d09e226/mzl.gtfuajrk.100x100-75.png",
             @"http://a1970.phobos.apple.com/us/r30/Purple4/v4/21/19/13/2119132e-de27-5419-27ff-cd01c017613a/mzl.smhzbsuv.100x100-75.png",
             @"http://a985.phobos.apple.com/us/r30/Purple2/v4/09/3a/44/093a442d-c382-feb8-e20b-4fade9db0e18/mzl.cpfafrns.100x100-75.png",
             @"http://a1664.phobos.apple.com/us/r30/Purple2/v4/10/76/fd/1076fd87-136b-83a4-69ac-e0725fa726f2/mzl.qwcyuism.100x100-75.png",
             @"http://a1492.phobos.apple.com/us/r30/Purple/v4/c2/c4/34/c2c434e2-9362-56ba-9213-19e05bdf1366/mzl.ssnerjzf.100x100-75.png",
             @"http://a898.phobos.apple.com/us/r30/Purple2/v4/4c/d0/b6/4cd0b65a-77ed-57a9-4617-07ce170df990/mzl.ypvnwazh.100x100-75.png",
             @"http://a1338.phobos.apple.com/us/r30/Purple/v4/19/d4/98/19d4986a-6528-ab98-1c0b-ac1d4a8e4e47/mzl.gdamjwas.100x100-75.png",
             @"http://a576.phobos.apple.com/us/r30/Purple6/v4/e5/13/99/e51399d1-d069-d1e3-3ef1-d8f1e463056b/mzl.ffrdsnvf.100x100-75.png",
             @"http://a256.phobos.apple.com/us/r30/Purple4/v4/b4/18/04/b41804a4-dafc-4c47-1e20-524e2c858359/mzl.malngihe.100x100-75.png",
             @"http://a559.phobos.apple.com/us/r30/Purple4/v4/13/db/ac/13dbacd4-202b-5a32-0991-3616d32d8f80/mzl.wosgbgeo.100x100-75.png",
             @"http://a1026.phobos.apple.com/us/r30/Purple3/v4/38/28/59/38285902-1b88-5680-eb4a-40df572f6f54/mzl.cfikmcmc.100x100-75.png",
             @"http://a1486.phobos.apple.com/us/r30/Purple6/v4/bf/6c/02/bf6c02d0-9650-d6ae-d19e-1e6eddf55bce/mzl.ogvlqywp.100x100-75.png",
             @"http://a525.phobos.apple.com/us/r30/Purple4/v4/35/7d/cc/357dccc3-4cf3-cf86-789d-8ea771138857/mzl.suptdinm.100x100-75.png",
             @"http://a484.phobos.apple.com/us/r30/Purple4/v4/18/f7/c4/18f7c4d7-8be0-2c55-3389-001d79ff6bc8/mzl.atkfmgta.100x100-75.png",
             @"http://a945.phobos.apple.com/us/r30/Purple/v4/e8/c6/bf/e8c6bf5b-5f1e-8931-bdf9-2c2ba5a694fc/mzl.qjpzlkth.100x100-75.png",
             @"http://a433.phobos.apple.com/us/r30/Purple/v4/6b/59/50/6b59500f-0e7b-d93e-ce72-32a13b684b53/mzl.vazwocma.100x100-75.png",
             @"http://a696.phobos.apple.com/us/r30/Purple6/v4/f1/64/87/f1648707-c069-eb27-2f12-163cb897d2ad/mzl.dqetqqfm.100x100-75.png",
             @"http://a1585.phobos.apple.com/us/r30/Purple/v4/fd/dc/91/fddc91e7-c6b2-2552-bf24-d0dce3ef72b6/mzl.onvampds.100x100-75.png",
             @"http://a221.phobos.apple.com/us/r30/Purple4/v4/f5/68/69/f56869ca-ecc7-b078-2ad9-9dd759a675b7/mzl.kanjtbmh.100x100-75.png",
             @"http://a210.phobos.apple.com/us/r30/Purple6/v4/e1/ae/7d/e1ae7da5-0968-e04b-6fd4-eca2cbb6b9c4/mzl.vnquvizn.100x100-75.png",
             @"http://a266.phobos.apple.com/us/r30/Purple2/v4/07/8c/6d/078c6d31-fbf5-e9c4-d8d7-ae9d16780677/mzl.egrmyfex.100x100-75.png",
             @"http://a618.phobos.apple.com/us/r30/Purple/v4/fb/7a/63/fb7a6389-ebde-3d03-2ce6-2334ea8d1cd8/mzl.ukyrpktf.100x100-75.png",
             @"http://a524.phobos.apple.com/us/r30/Purple4/v4/55/43/7d/55437d7d-bba7-1bd0-c862-edd627948796/mzl.wyfpveqk.100x100-75.png",
             @"http://a1501.phobos.apple.com/us/r30/Purple/v4/f8/41/17/f84117cc-a5a9-0f8f-1c64-deedcf1f27e4/mzl.uxgzvffn.100x100-75.png",
             @"http://a1821.phobos.apple.com/us/r30/Purple/v4/c6/f8/4a/c6f84a08-5032-dbae-d45f-ca0f6a172acb/mzl.iayoexpe.100x100-75.png",
             @"http://a762.phobos.apple.com/us/r30/Purple4/v4/a1/00/36/a100366c-cb55-38cf-307e-bf43e699fc07/mzl.qvostqsi.100x100-75.png",
             @"http://a1176.phobos.apple.com/us/r30/Purple4/v4/ec/b2/e8/ecb2e803-f835-8619-5a69-6ca218de2986/mzl.cpbrcnoc.100x100-75.png",
             @"http://a1158.phobos.apple.com/us/r30/Purple/v4/c3/f0/2a/c3f02ad0-4679-be27-0188-8c5df46ef0d7/mzl.qzsmgsnm.100x100-75.png",
             @"http://a1213.phobos.apple.com/us/r30/Purple4/v4/47/76/07/477607d8-0788-469d-94d6-5aed5c596e8d/mzl.xyjnqbbu.100x100-75.png",
             @"http://a1922.phobos.apple.com/us/r30/Purple2/v4/06/ac/88/06ac888c-5dca-a6ae-b5c0-ff9f3e372091/mzl.omguwrgg.100x100-75.png",
             @"http://a335.phobos.apple.com/us/r30/Purple4/v4/5b/e9/62/5be962be-9f59-9a4a-938c-1a01eb60fc87/mzl.svywihxz.100x100-75.png",
             @"http://a764.phobos.apple.com/us/r30/Purple6/v4/44/db/29/44db29c9-d7cf-a261-75b5-7862957b9398/mzl.gzegzotc.100x100-75.png",
             @"http://a1153.phobos.apple.com/us/r30/Purple4/v4/19/c3/2f/19c32f01-5264-c6f5-d072-306f925e484c/mzl.khdfxqey.100x100-75.png",
             @"http://a196.phobos.apple.com/us/r30/Purple/v4/e6/b9/00/e6b900c7-bb83-e58a-9fe2-c7ff7c849a7b/mzl.odzsmabn.100x100-75.png",
             @"http://a87.phobos.apple.com/us/r30/Purple6/v4/88/31/e4/8831e430-a09a-b25b-67e7-34ff66682c37/mzl.kkuyxkza.100x100-75.png",
             @"http://a786.phobos.apple.com/us/r30/Purple/v4/f9/c7/44/f9c744ab-3156-87a6-880d-56ac6ce25377/mzl.gehkirnd.100x100-75.png",
             @"http://a844.phobos.apple.com/us/r30/Purple4/v4/15/ed/95/15ed9537-598d-fe24-909c-57c003d023ac/mzl.einyxdji.100x100-75.png",
             @"http://a80.phobos.apple.com/us/r30/Purple4/v4/d0/22/3f/d0223fe7-8bd0-28fa-65dd-9e059e8b2f27/mzl.wqpvuqfk.100x100-75.png",
             @"http://a268.phobos.apple.com/us/r30/Purple4/v4/17/92/0d/17920d86-2d9a-7cfe-5bf9-cacdddbc3009/mzl.ayzwcruo.100x100-75.png",
             @"http://a1910.phobos.apple.com/us/r30/Purple4/v4/89/b1/51/89b1517d-7f7d-a276-4533-5e9d22ad6746/mzl.hyaxttzn.100x100-75.png",
             @"http://a559.phobos.apple.com/us/r30/Purple2/v4/a6/07/a6/a607a618-5fb6-246a-e94a-462bbfa8ca6a/mzl.wfamopmy.100x100-75.png",
             @"http://a411.phobos.apple.com/us/r30/Purple/v4/cc/79/07/cc79074d-df84-2097-92c5-2f9c14049169/mzl.xullraer.100x100-75.png",
             @"http://a881.phobos.apple.com/us/r30/Purple/v4/1a/7b/19/1a7b1932-80c8-adc9-8a5d-3b3e8a573ba1/mzl.xaplqdck.100x100-75.png",
             @"http://a1167.phobos.apple.com/us/r30/Purple4/v4/dd/22/4e/dd224e5f-c462-4e42-585e-ad6e5e961d78/mzl.zjfbxvfs.100x100-75.png",
             @"http://a1056.phobos.apple.com/us/r30/Purple/v4/db/88/dd/db88dd11-d983-8cdd-03eb-0908d828b72a/mzl.yaojkuqk.100x100-75.png",
             @"http://a1426.phobos.apple.com/us/r30/Purple4/v4/00/8a/ae/008aae34-37be-b222-50de-2bf34e5b4b60/mzl.cibjtxtv.100x100-75.png",
             @"http://a202.phobos.apple.com/us/r30/Purple/v4/c4/fc/75/c4fc7528-8c33-5405-d9b3-652200e906dd/mzl.gbejkzkk.100x100-75.png",
             @"http://a231.phobos.apple.com/us/r30/Purple/v4/10/3b/a3/103ba304-7595-8ac7-cc1a-a56742a8369e/mzl.brcofjbf.100x100-75.png",
             @"http://a1747.phobos.apple.com/us/r30/Purple4/v4/ff/36/8d/ff368d16-7211-ab59-8649-3cb588f02c5f/mzl.xxvefyvu.100x100-75.png",
             @"http://a139.phobos.apple.com/us/r30/Purple4/v4/3c/3d/dd/3c3ddd55-be3e-d8e1-278e-6652f9747102/mzl.zxptizcl.100x100-75.png",
             @"http://a1473.phobos.apple.com/us/r30/Purple/v4/f2/4d/6e/f24d6e86-21fe-f332-d89c-2c063eb53cba/mzl.jocnmjjr.100x100-75.png",
             @"http://a1615.phobos.apple.com/us/r30/Purple4/v4/80/c8/b1/80c8b1bd-c78d-9195-4b19-a42ca53edcbc/mzl.zyrepefg.100x100-75.png",
             @"http://a1983.phobos.apple.com/us/r30/Purple6/v4/1f/00/ca/1f00caed-74fe-6d38-d092-b6031ee53303/mzl.nnofnfhj.100x100-75.png",
             @"http://a1081.phobos.apple.com/us/r30/Purple/v4/e9/04/69/e90469e0-548b-ad1c-a1ec-84f9d942a3b9/mzl.lvdwyaoz.100x100-75.png",
             @"http://a818.phobos.apple.com/us/r30/Purple4/v4/00/2e/58/002e58f3-2f39-4f4e-7442-127f94ba540e/mzl.zzxhsenl.100x100-75.png",
             @"http://a157.phobos.apple.com/us/r30/Purple4/v4/33/76/ee/3376ee67-bbb4-7a8f-de8b-1ca154cd0cf5/mzl.ddjprimd.100x100-75.png",
             @"http://a1712.phobos.apple.com/us/r30/Purple/v4/59/41/db/5941db05-7448-f52f-f0b9-ec7249e2cf7d/mzl.ptzqaneu.100x100-75.png",
             @"http://a210.phobos.apple.com/us/r30/Purple4/v4/4d/a5/80/4da58002-7f0c-3b06-495e-149834c6114e/mzl.ueddckia.100x100-75.png",
             @"http://a1223.phobos.apple.com/us/r30/Purple/c0/ad/6f/mzl.isborlrs.100x100-75.png",
             @"http://a1018.phobos.apple.com/us/r30/Purple/v4/2f/32/35/2f323549-e67f-e7da-ff3e-bc6803bc8ae3/mzl.fqswoccq.100x100-75.png",
             @"http://a1677.phobos.apple.com/us/r30/Purple6/v4/41/fa/3f/41fa3fae-a624-40a3-f3ee-c169af7e102e/mzl.cjktshkt.100x100-75.png",
             @"http://a33.phobos.apple.com/us/r30/Purple/v4/c4/cd/ea/c4cdea91-01f2-3f0f-15f6-81c4ccbc5c31/mzl.jmuthusy.100x100-75.png",
             @"http://a1716.phobos.apple.com/us/r30/Purple4/v4/a8/53/63/a85363bf-eed5-c9b9-39b4-f256eebe3324/mzl.piguhwix.100x100-75.png",
             @"http://a1707.phobos.apple.com/us/r30/Purple4/v4/20/a3/af/20a3af1b-7d37-ec2d-7287-b892cc9c89e0/mzl.yimkyjjb.100x100-75.png",
             @"http://a1635.phobos.apple.com/us/r30/Purple6/v4/2b/d0/ce/2bd0ce43-7ab8-9650-697f-78eed2a3aae0/mzl.kxczuyve.100x100-75.png",
             @"http://a1955.phobos.apple.com/us/r30/Purple2/v4/e7/b8/6f/e7b86fc3-eb1d-fb89-ac79-bdafe6806620/mzl.hhjmxuzo.100x100-75.png",
             @"http://a375.phobos.apple.com/us/r30/Purple/v4/91/60/b6/9160b6fb-0684-9b16-5374-c51e278d8371/mzl.lyyeukym.100x100-75.png",
             @"http://a205.phobos.apple.com/us/r30/Purple4/v4/0c/da/98/0cda9815-970c-683e-f36a-2a39b313940a/mzl.wlnbfpyi.100x100-75.png", nil];
    
    dictOperations = [[NSMutableDictionary alloc] init];
    

    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stopDownload:(id)sender
{
    [self.downloadQueue cancelAllOperations];
    [dictOperations removeAllObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
 
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    
    UIButton *btnRequest = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRequest setTitle:@"Send" forState:UIControlStateNormal];
    [btnRequest setFrame:CGRectMake(260, 5, 50, 25)];
    [btnRequest setTag:indexPath.row];
    [btnRequest addTarget:self action:@selector(sendRequestForIndex:) forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:btnRequest];
    
    if([array count] > 0)
    {
        NSString *filePath = [DOC_DIR stringByAppendingPathComponent:[array[indexPath.row] lastPathComponent]];
        if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self downloadImageForURL:[NSURL URLWithString:array[indexPath.row]] AtIndexPath:indexPath];
            }
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }
        else
        {
            [cell.imageView setImage:[UIImage imageWithContentsOfFile:filePath]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SecondViewController *objSVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    DemoViewController *objSVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objSVC];
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

- (void)downloadImageForURL:(NSURL *)url AtIndexPath:(NSIndexPath *)indexPath
{
    if(![dictOperations objectForKey:indexPath])
    {
        Operations *obj = [[Operations alloc] initWithObject:url andAction:IMAGE_DOWLOAD];
        
        [dictOperations setObject:obj forKey:indexPath];
        
        [obj setSuccessHandler:^(id result) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.imageView.image = result;
            });
            [dictOperations removeObjectForKey:indexPath];
            
        }];
        
        [obj setErroHandler:^(NSString *err) {
            NSLog(@"ERROR : %@ ",err);
            [dictOperations removeObjectForKey:indexPath];
        }];
        
        [self.downloadQueue addOperation:obj];
    }
}


- (void)loadImagesForOnscreenRows
{
    if ([array count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            [self downloadImageForURL:[NSURL URLWithString:array[indexPath.row]] AtIndexPath:indexPath];
        }
    }
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - call Block
- (void)sendRequestForIndex:(id)index
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[index tag] inSection:0]];
    for(id object in [cell.contentView subviews])
    {
        if([object isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)object;
            [btn setTitle:@"Wait..." forState:UIControlStateNormal];
        }
    }
    
    NSDictionary *dictParams = [NSDictionary dictionaryWithObjectsAndKeys:@"param1", @"key", nil];
    Operations *obj = [[Operations alloc] initWithObject:dictParams andAction:API_CALL];
    
    [obj setSuccessHandler:^(id result) {
        NSError *err = nil;
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&err]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[index tag] inSection:0]];
            for(id object in [cell.contentView subviews])
            {
                if([object isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton *)object;
                    [btn setTitle:@"Sent" forState:UIControlStateNormal];
                }

            }
        });
    }];
    
    [obj setErroHandler:^(NSString *err) {
            NSLog(@"ERROR : %@",err);
    }];
    
    [self.serverDateTimeQueue addOperation:obj];
}

- (void)sendRequestFor:(NSInteger)index
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    for(id object in [cell.contentView subviews])
    {
        if([object isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)object;
            [btn setTitle:@"Wait..." forState:UIControlStateNormal];
        }
    }
    
    NSDictionary *dictParams = [NSDictionary dictionaryWithObjectsAndKeys:@"param1", @"key", nil];
    Operations *obj = [[Operations alloc] initWithObject:dictParams andAction:API_CALL];
    [obj setSuccessHandler:^(id result) {
        NSError *err = nil;
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&err]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            for(id object in [cell.contentView subviews])
            {
                if([object isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton *)object;
                    [btn setTitle:@"Sent" forState:UIControlStateNormal];
                }
            }
        });
    }];
    
    [obj setErroHandler:^(NSString *err) {
        NSLog(@"ERROR : %@",err);
    }];
    
    [self.serverDateTimeQueue addOperation:obj];
}

@end
