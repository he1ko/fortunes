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
#import "CenterViewController.h"
#import "ImpressumViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "FortunesListViewController.h"
#import "FortunesBySourceViewController.h"
#import "SettingsViewController.h"

@interface LeftViewController ()

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



- (void)setupNavItems {

    CGRect itemFrame = self.view.frame;
    itemFrame.size.height = itemHeight;
    CGFloat originY = 50.0f;

    NSMutableArray *mItems = [[NSMutableArray alloc] initWithCapacity:5];

    LeftNavItem *itemHome = [[LeftNavItem alloc] initWithFrame:itemFrame andTag:LeftNavItemTagHome andText:@"Dein Fortune!"];
    [itemHome setY:originY];
    [itemHome addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [itemHome setSelected:YES];
    [self.view addSubview:itemHome];
    [mItems addObject:itemHome];

    originY += itemHeight;

    LeftNavItem *itemFortuneList = [[LeftNavItem alloc] initWithFrame:itemFrame andTag:LeftNavItemTagFortunesList andText:@"Alle Fortunes"];
    [itemFortuneList setY:originY];
    [itemFortuneList addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:itemFortuneList];
    [mItems addObject:itemFortuneList];

    originY += itemHeight;

    LeftNavItem *itemFortunesBySource = [[LeftNavItem alloc] initWithFrame:itemFrame andTag:LeftNavItemTagFortunesBySource andText:@"Fortunes nach Quellen"];
    [itemFortunesBySource setY:originY];
    [itemFortunesBySource addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:itemFortunesBySource];
    [mItems addObject:itemFortunesBySource];

    originY += itemHeight;

    LeftNavItem *itemSettings = [[LeftNavItem alloc] initWithFrame:itemFrame andTag:LeftNavItemTagSettings andText:@"Einstellungen"];
    [itemSettings setY:originY];
    [itemSettings addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:itemSettings];
    [mItems addObject:itemSettings];

    originY += itemHeight;

    LeftNavItem *itemImpressum = [[LeftNavItem alloc] initWithFrame:itemFrame andTag:LeftNavItemTagImpressum andText:@"Impressum"];
    [itemImpressum setY:originY];
    [itemImpressum addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:itemImpressum];
    [mItems addObject:itemImpressum];

    leftItems = mItems;

    // [self itemTouched:itemSettings];
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
        mControllers[0] = [[CenterViewController alloc] init];
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
