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

    btFonts = [self buttonWithText:@"Schriftarten festlegen..."];
    [self.view addSubview:btFonts];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self.navigationItem setTitle:@"Einstellungen"];
}


- (UILabel *)descriptionLabel {

    NSString *descText = @"Du hättest DEIN FORTUNE oder alle Fortunes als Liste, die Quellenangaben gern in anderen Schriftarten? Büüde ... !";

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
