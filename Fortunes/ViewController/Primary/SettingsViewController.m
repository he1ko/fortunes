//
//  SettingsViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIViewController+Layout.h"
#import "FontsViewController.h"

@interface SettingsViewController ()

- (UILabel *)descriptionLabel;

- (UIButton *)buttonWithText:(NSString *)buttonText;
- (void)fontsButtonTouch;

@end


@implementation SettingsViewController {

@private
    UIButton *btFonts;
    UILabel *lblDescription;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    lblDescription = [self descriptionLabel];
    [self.view addSubview:lblDescription];

    btFonts = [self buttonWithText:NSLocalizedString(@"changeFonts", @"button text for changing font settings")];
    [self.view addSubview:btFonts];

    NSLog(@"Button: %d", (int)btFonts.titleLabel.font.pointSize);
    NSLog(@"Label: %d", (int)lblDescription.font.pointSize);
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.navigationItem setTitle:NSLocalizedString(@"Settings", @"Settings")];
}


- (UILabel *)descriptionLabel {

    NSString *descText = NSLocalizedString(@"desriptionFontSettings", @"what can the user do with font settings?");

    UILabel *lblDesc = [self simpleLabelWithText:descText];
    lblDesc.numberOfLines = 0;
    [lblDesc sizeToFit];

    return lblDesc;
}


- (UIButton *)buttonWithText:(NSString *)buttonText {

    UIButton * button = [self roundedButtonWithText:buttonText];
    [button setY:(float) (CGRectGetMaxY(lblDescription.frame) + 20.0)];
    [button addTarget:self action:@selector(fontsButtonTouch) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (void)fontsButtonTouch {

    FontsViewController *vcFonts = [[FontsViewController alloc] init];
    [self.navigationController pushViewController:vcFonts animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
