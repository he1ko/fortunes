//
//  FontAssignViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 28.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "FontAssignViewController.h"
#import "UIViewController+Layout.h"

static NSString *locSampleText = @"Font-sample-text";
static NSString *locButtonTextMyFortune = @"ButtonMyFortune";
static NSString *locButtonTextListFortune = @"ButtonListFortune";
static NSString *locButtonTextListSource = @"ButtonListSource";
static NSString *locButtonTextGoBack = @"ButtonGoBack";




@interface FontAssignViewController ()

- (UILabel *)mainFontNameLabel;

- (UILabel *)fontSampleLabel;

- (UILabel *)descriptionLabel;

- (UIButton *)btAssignToMainFortune:(NSString *)buttonText;

- (UIButton *)btAssignToListFortune:(NSString *)buttonText;

- (UIButton *)btAssignToListSource:(NSString *)buttonText;

- (void)saveFontName:(id)sender;

- (void)hideHud;
@end

@implementation FontAssignViewController {

@private
    UILabel *__mainFontNameLabel;
    UILabel *__sampleLabel;
    UILabel *__descriptionLabel;
    UIButton *__btAssignToMainFortune;
    UIButton *__btAssignToListFortune;
    UIButton *__btAssignToListSource;
    MBProgressHUD *HUD;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    __mainFontNameLabel = [self mainFontNameLabel];
    [self.view addSubview:__mainFontNameLabel];

    __sampleLabel = [self fontSampleLabel];
    [self.view addSubview:__sampleLabel];

    __descriptionLabel = [self descriptionLabel];
    [self.view addSubview:__descriptionLabel];

    __btAssignToMainFortune = [self btAssignToMainFortune:NSLocalizedString(locButtonTextMyFortune, @"Button Text")];
    [self.view addSubview:__btAssignToMainFortune];

    __btAssignToListFortune = [self btAssignToListFortune:NSLocalizedString(locButtonTextListFortune, @"Button Text")];
    [self.view addSubview:__btAssignToListFortune];

    __btAssignToListSource = [self btAssignToListSource:NSLocalizedString(locButtonTextListSource, @"Button Text")];
    [self.view addSubview:__btAssignToListSource];

    [self addRightNavigationButtonWithText:NSLocalizedString(locButtonTextGoBack, @"Back button Text")];
}


- (UILabel *)mainFontNameLabel {

    UILabel *lblMain = [self simpleLabelWithText:_fontName];
    [self alignView:lblMain atTopOfRect:[self visibleViewFrame]];
    [lblMain setY:(float) (lblMain.frame.origin.y + 20.0)];
    return lblMain;
}

- (UILabel *)fontSampleLabel {

    UILabel *lblSample = [self fullWidthLabelWithText:NSLocalizedString(@"Font-sample-text", @"Font Sample")];
    [self alignView:lblSample atTopOfRect:[self visibleViewFrame]];
    [lblSample setY:(float) (CGRectGetMaxY(__mainFontNameLabel.frame) + 20.0)];
    lblSample.backgroundColor = [UIColor whiteColor];
    lblSample.textColor = [UIColor blackColor];
    lblSample.font = [UIFont fontWithName:_fontName size:lblSample.font.pointSize];
    lblSample.textAlignment = NSTextAlignmentCenter;
    [lblSample setHeight:lblSample.frame.size.height * 3];
    return lblSample;
}


- (UILabel *)descriptionLabel {

    UILabel *lblDesc = [self simpleLabelWithText:NSLocalizedString(@"Question-which-area-to-set-font-for", @"Description")];
    [lblDesc setY:(float) (CGRectGetMaxY(__sampleLabel.frame) + 20.0)];
    lblDesc.numberOfLines = 0;
    [lblDesc sizeToFit];

    return lblDesc;
}


- (UIButton *)btAssignToMainFortune:(NSString *)buttonText {

    UIButton *bt = [self roundedButtonWithText:buttonText];
    [bt setTag:FONT_APP_SECTION_MAIN_FORTUNE];
    [bt addTarget:self action:@selector(saveFontName:) forControlEvents:UIControlEventTouchUpInside];
    [bt setY:(float) (CGRectGetMaxY(__descriptionLabel.frame) + 20.0)];

    return bt;
}


- (UIButton *)btAssignToListFortune:(NSString *)buttonText {

    UIButton *bt = [self roundedButtonWithText:buttonText];
    [bt setTag:FONT_APP_SECTION_LIST_FORTUNE];
    [bt addTarget:self action:@selector(saveFontName:) forControlEvents:UIControlEventTouchUpInside];
    [bt setY:(float) (CGRectGetMaxY(__btAssignToMainFortune.frame) + 20.0)];

    return bt;
}


- (UIButton *)btAssignToListSource:(NSString *)buttonText {

    UIButton *bt = [self roundedButtonWithText:buttonText];
    [bt setTag:FONT_APP_SECTION_LIST_SOURCE];
    [bt addTarget:self action:@selector(saveFontName:) forControlEvents:UIControlEventTouchUpInside];
    [bt setY:(float) (CGRectGetMaxY(__btAssignToListFortune.frame) + 20.0)];

    return bt;
}


- (void)saveFontName:(id)sender {

    if([sender isKindOfClass:[UIView class]]) {

        UIView *senderView = (UIView *)sender;
        [[FontManager getInstance] updateFontName:_fontName forSection:[sender tag]];

        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = NSLocalizedString(@"FontSaved", @"Schriftart gespeichert");
        HUD.detailsLabelText = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"ButtonMyFortune", @"Mein Fortune"), _fontName];

        HUD.delegate = self;
        [HUD show:YES];
        [self performSelector:@selector(hideHud) withObject:nil afterDelay:2.0];
    }
    else {
        [NSException raise:@"Speichern nicht möglich!" format:@""];
    }
}


- (void)hideHud {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}


@end
