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
    CGFloat alertOffsetY;
}


- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor presetHighlight];

    alertOffsetY = 0.0;

    if(IS_OS_7_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO; // Avoid the top UITextView space, iOS7 (~bug?)
    }
}

- (void)viewWillAppear:(BOOL)animated {

    [self setupNavBarAppearance];

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

#pragma mark -
#pragma mark Alert Helpers

- (void)setAlertOffsetY:(CGFloat)offset {

    alertOffsetY = offset;
}

- (CGFloat)getAlertOffsetY {

    return alertOffsetY;
}



@end
