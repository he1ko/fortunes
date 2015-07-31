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
- (void)fontsButtonTouch:(id)sender;

@end


@implementation SettingsViewController {

@private
    UIButton *btMainFortune;
    UIButton *btListFortune;
    UIButton *btListSource;

    UILabel *lblDescription;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    lblDescription = [self descriptionLabel];
    [self appendView:lblDescription];

    btMainFortune = [self buttonWithText:NSLocalizedString(@"Dein (großes) Fortune", @"Dein (großes) Fortune")];
    [btMainFortune setTag:FONT_APP_SECTION_MAIN_FORTUNE];
    [self appendView:btMainFortune];

    btListFortune = [self buttonWithText:NSLocalizedString(@"Fortunes in Listen", @"Fortunes in Listen")];
    [btListFortune setTag:FONT_APP_SECTION_LIST_FORTUNE];
    [self appendView:btListFortune];

    btListSource = [self buttonWithText:NSLocalizedString(@"Fortune-Quelle in Listen", @"Fortune-Quelle in Listen")];
    [btListSource setTag:FONT_APP_SECTION_LIST_FORTUNE];
    [self appendView:btListSource];
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
    [button addTarget:self action:@selector(fontsButtonTouch:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}


- (void)fontsButtonTouch:(id)sender {

    UIView *bt = (UIView *)sender;
    FontsViewController *vcFonts = [[FontsViewController alloc] init];

    vcFonts.fontSection = (FontAppSection)[bt tag];
    [self.navigationController pushViewController:vcFonts animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
