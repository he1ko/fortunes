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

static NSInteger FAKE_SECTION_RESET = 99;

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
    UIButton *btResetAll;

    UILabel *lblDescription;
    NSArray *fontListViewControllers;

    MBProgressHUD *hud;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    fontListViewControllers = [self emptyFontListViewControllersArray];

    lblDescription = [self descriptionLabel];
    [self appendView:lblDescription];

    btMainFortune = [self buttonWithText:NSLocalizedString(@"Dein (großes) Fortune", @"Dein (großes) Fortune")];
    [btMainFortune setTag:FONT_APP_SECTION_MAIN_FORTUNE];
    [self appendView:btMainFortune];

    btListFortune = [self buttonWithText:NSLocalizedString(@"Fortunes in Listen", @"Fortunes in Listen")];
    [btListFortune setTag:FONT_APP_SECTION_LIST_FORTUNE];
    [self appendView:btListFortune];

    btListSource = [self buttonWithText:NSLocalizedString(@"Fortune-Quelle in Listen", @"Fortune-Quelle in Listen")];
    [btListSource setTag:FONT_APP_SECTION_LIST_SOURCE];
    [self appendView:btListSource];

    btResetAll = [self buttonWithText:NSLocalizedString(@"settings.buttons.reset", @"reset fonts")];
    [btResetAll setTag:FAKE_SECTION_RESET];
    [self appendView:btResetAll];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.navigationItem setTitle:NSLocalizedString(@"Settings", @"Settings")];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Controls

- (UILabel *)descriptionLabel {

    NSString *descText = NSLocalizedString(@"desriptionFontSettings", @"what can the user do with font settings?");

    UILabel *lblDesc = [self simpleLabelWithText:descText];
    lblDesc.textAlignment = NSTextAlignmentCenter;
    lblDesc.numberOfLines = 0;
    [lblDesc sizeToFit];

    /// sizeToFit might narrow the view but leaves origin.x unchanged --> center view again!
    [lblDesc setX:CGRectGetMidX(self.view.frame) - lblDesc.frame.size.width /2];

    return lblDesc;
}


- (UIButton *)buttonWithText:(NSString *)buttonText {

    UIButton * button = [self roundedButtonWithText:buttonText];
    [button addTarget:self action:@selector(fontsButtonTouch:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}


#pragma mark -
#pragma mark Selection of section to modify

- (void)fontsButtonTouch:(id)sender {

    UIView *bt = (UIView *)sender;

    if([bt tag] == FAKE_SECTION_RESET) {

        [self showHud];
        [[FontManager getInstance] resetFontNames];
        return;
    }

    FontsViewController *vcFonts = [self getFontVcForSection:(FontAppSection)[bt tag]];
    [self.navigationController pushViewController:vcFonts animated:YES];
}


- (void)showHud {

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelText = NSLocalizedString(@"settings.hud.title.reset", @"Schriftarten zurückgesetzt");
    hud.delegate = self;

    [self performSelector:@selector(hideHud) withObject:nil afterDelay:1.3];
}

- (void)hideHud {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (FontsViewController *)getFontVcForSection:(FontAppSection)section {

    FontsViewController *neededVc = fontListViewControllers[section];

    if([neededVc isEqual:[NSNull null]]) {

        neededVc = [[FontsViewController alloc] init];
        neededVc.fontSection = section;

        NSMutableArray *mFontListVcs = [fontListViewControllers mutableCopy];
        mFontListVcs[section] = neededVc;
        fontListViewControllers = mFontListVcs;
    }
    return neededVc;
}


- (NSArray *)emptyFontListViewControllersArray {

    return @[[NSNull null], [NSNull null], [NSNull null]];
}





@end
