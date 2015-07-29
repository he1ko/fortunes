//
//  CenterViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "CenterViewController.h"
#import "UIViewController+Layout.h"
#import "LabelAutoSize.h"
#import "UserSettings.h"

@implementation CenterViewController {

@private
    LabelAutoSize *lblFortune;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [self loadFortune];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    NSString *fontName = [self fontNameFromUserSettings];
    if([fontName isEqualToString:lblFortune.font.fontName]) {
        return;
    }
    lblFortune.font = [UIFont fontWithName:fontName size:lblFortune.font.pointSize];
    [self adjustLabelSize];
}


- (void)loadFortune {

    [RESTClient loadRandomFortune:self];
}


- (void)setRestAnswer:(JSONModel *)jsonModel {

    [super setRestAnswer:jsonModel];

    if([self.jsonModel isKindOfClass:[SingleFortune class]]) {

        [self setupFortune];
    }
}


- (void)setupFortune {

    /// main fortune display

    if(lblFortune == nil) {

        lblFortune = [self fortuneLabel];
        [self.view addSubview:lblFortune];
    }

    SingleFortune *fortune = (SingleFortune *)self.jsonModel;

    lblFortune.text = [fortune cleanText];
    [self adjustLabelSize];
}


- (void)adjustLabelSize {

    [lblFortune adjust];

    /// move Label to center of visible area
    CGRect frVisible = [self visibleViewFrame];
    CGPoint lblCenter = self.view.center;
    lblCenter.y = CGRectGetMidY(frVisible);
    lblFortune.center = lblCenter;
}


- (LabelAutoSize*)fortuneLabel {

    CGFloat labelMarginAll = 40.0f;

    CGRect frVisible = [self visibleViewFrame];
    CGRect frLabel = frVisible;

    frLabel.origin.x += labelMarginAll;
    frLabel.origin.y += labelMarginAll;
    frLabel.size.width -= labelMarginAll * 2;
    frLabel.size.height -= labelMarginAll * 2;

    LabelAutoSize *lbl = [[LabelAutoSize alloc] initWithFrame:frLabel resizeMode:AUTOLABEL_RESIZE_FONT];
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];

    NSString *lblFontName = [self fontNameFromUserSettings];
    if(lblFontName != nil) {
        [lbl setFont:[UIFont fontWithName:lblFontName size:22.0f]];
    }

    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.userInteractionEnabled = YES;

    [self.view addSubview:lbl];

    return lbl;
}


- (NSString *)fontNameFromUserSettings {

    NSString *fontSettingsKey = [UserSettings userDefaultsKeyForSection:FONT_APP_SECTION_MAIN_FORTUNE];
    NSString *lblFontName = [UserSettings loadStringWithKey:fontSettingsKey];

    if(lblFontName == nil || [lblFontName isEqualToString:@""]) {
        return nil;
    }
    return lblFontName;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    if ([touch view] == lblFortune) {
        [self loadFortune];
        return;
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
