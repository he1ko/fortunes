//
//  LeftViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftNavItem.h"
#import "NavController.h"
#import "HomeViewController.h"
#import "ImpressumViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "FortunesListViewController.h"
#import "FortunesBySourceViewController.h"
#import "SettingsViewController.h"

@interface LeftViewController ()

- (LeftNavItem *)navItemWithFrame:(CGRect)frame tag:(LeftNavItemTag)tag text:(NSString *)text;

- (void)setupNavItems;
- (void)itemTouched:(id)sender;
- (void)changeTo:(UIViewController *)vc;
- (void)setupControllerArray;
- (void)setItemsUnselected;
@end


@implementation LeftViewController {

@private
    NSArray *leftItems;
    NSArray *viewControllers;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor presetItemBackground];

    [self setupControllerArray];
    [self setupNavItems];
}


- (LeftNavItem *)navItemWithFrame:(CGRect)frame tag:(LeftNavItemTag)tag text:(NSString *)text {

    LeftNavItem *item = [[LeftNavItem alloc] initWithFrame:frame andTag:tag andText:text];
    [item addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:item];

    return item;
}


- (void)setupNavItems {

    NSMutableArray *mItems = [[NSMutableArray alloc] initWithCapacity:5];

    CGRect itemFrame = self.view.frame;
    itemFrame.size.height = itemHeight;

    itemFrame.origin.y = 50.0f;
    [mItems addObject:[self navItemWithFrame:itemFrame tag:LeftNavItemTagHome text:NSLocalizedString(@"mainFortune", @"full screen Fortune display")]];

    itemFrame.origin.y += itemHeight;
    [mItems addObject:[self navItemWithFrame:itemFrame tag:LeftNavItemTagFortunesList text:NSLocalizedString(@"listOfFortunes", @"all fortunes as a table")]];

    itemFrame.origin.y += itemHeight;
    [mItems addObject:[self navItemWithFrame:itemFrame tag:LeftNavItemTagFortunesBySource text:NSLocalizedString(@"fortunesBySource", @"fortunes selecteable by sources")]];

    itemFrame.origin.y += itemHeight;
    [mItems addObject:[self navItemWithFrame:itemFrame tag:LeftNavItemTagSettings text:NSLocalizedString(@"Settings", @"app settings")]];

    itemFrame.origin.y += itemHeight;
    [mItems addObject:[self navItemWithFrame:itemFrame tag:LeftNavItemTagImpressum text:NSLocalizedString(@"imprint", @"imprint")]];

    leftItems = mItems;

    [self itemTouched:leftItems[1]];
}


- (void) itemTouched:(id)sender {

    LeftNavItem *item;

    if([sender isKindOfClass:[LeftNavItem class]]) {

        item = (LeftNavItem *) sender;

        [self setItemsUnselected];
        [leftItems[(NSUInteger) item.tag] setSelected:YES];

    /*
         0 - LeftNavItemTagHome,
         1 - LeftNavItemTagFortunesList,
         2 - LeftNavItemTagFortunesBySource,
         3 - LeftNavItemTagSettings,
         4 - LeftNavItemTagImpressum
    */

        [self changeTo:viewControllers[(NSUInteger) item.tag]];
    }
}


- (void)changeTo:(UIViewController *)vc {

    UINavigationController *nav = [[NavController alloc] initWithRootViewController:vc];

    [self.mm_drawerController
            setCenterViewController:nav
                 withCloseAnimation:YES
                         completion:nil];
}



- (void)setupControllerArray {

    NSMutableArray *mControllers = [[NSMutableArray alloc] initWithCapacity:5];

    if(viewControllers[0] == nil) {
        mControllers[0] = [[HomeViewController alloc] init];
    }
    mControllers[1] = [[FortunesListViewController alloc] init];
    mControllers[2] = [[FortunesBySourceViewController alloc] init];
    mControllers[3] = [[SettingsViewController alloc] init];
    mControllers[4] = [[ImpressumViewController alloc] init];

    viewControllers = mControllers;
}



-(void)setFirstController:(UIViewController *)vc {

    NSMutableArray *mControllers = [viewControllers mutableCopy];
    mControllers[0] = vc;
    viewControllers = mControllers;
}


- (void)setItemsUnselected {

    for(LeftNavItem *item in leftItems) {

        [item setSelected:NO];
    }
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}


@end
