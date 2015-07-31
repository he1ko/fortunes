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

@interface BaseViewController ()

@end

@implementation BaseViewController {

@private

}


- (void)viewDidLoad {

    [super viewDidLoad];

    if(IS_OS_7_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO; // Avoid the top UITextView space, iOS7 (~bug?)
    }
}

- (void)viewWillAppear:(BOOL)animated {

    self.view.backgroundColor = [UIColor presetHighlight];

    // tint color of navigation items:
    self.navigationController.navigationBar.tintColor = [UIColor preset_backGroundBlackWithAlpha:0.5];

    self.navigationController.navigationBar.barStyle  = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:1.0 alpha:0.8];

    // [self.navigationItem setTitle:NSLocalizedString(@"Fortunes", @"Fortunes")];

    UIBarButtonItem *menuIcon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MenuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftNavigationButtonTouched)];
    [self.navigationItem setLeftBarButtonItem:menuIcon animated:YES];
}


- (void)addRightNavigationButtonWithText:(NSString *)text {

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationButtonTouched)];
    [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
}

- (void)removeRightNavigationButtonWithText:(NSString *)text {

    [self.navigationItem setRightBarButtonItem:nil animated:NO];
}




- (void)rightNavigationButtonTouched {

    [self.navigationController popViewControllerAnimated:YES];
}


- (void)leftNavigationButtonTouched {

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)setRestAnswer:(JSONModel *)jsonModel {

    self.jsonModel = jsonModel;
}



@end
