//
//  UIViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIViewController+NavigationBar.h"


@interface BaseViewController ()

@end

@implementation BaseViewController {

@private

}


- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor presetHighlight];

    if(IS_OS_7_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO; // Avoid the top UITextView space, iOS7 (~bug?)
    }
}

- (void)viewWillAppear:(BOOL)animated {

    // tint color of navigation items:
    self.navigationController.navigationBar.tintColor = [UIColor preset_backGroundBlackWithAlpha:0.5];

    self.navigationController.navigationBar.barStyle  = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:1.0 alpha:0.8];

    [self addNavBarButtonWithImageName:@"MenuIcon" side:NAV_BAR_BUTTON_SIDE_LEFT];
}


- (void)leftNavigationButtonTouched {

    [super leftNavigationButtonTouched];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)rightNavigationButtonTouched {

    [super rightNavigationButtonTouched];
}


- (void)setRestAnswer:(JSONModel *)jsonModel {

    self.jsonModel = jsonModel;
}



@end
