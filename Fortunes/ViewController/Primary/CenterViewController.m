//
//  CenterViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "CenterViewController.h"
#import "UIViewController+Layout.h"
#import "UserSettings.h"
#import "FortuneMainDisplay.h"

@implementation CenterViewController {

@private
    FortuneMainDisplay *fortuneDisplay;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [self loadFortune];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    NSString *fontName = [self fontNameFromUserSettings];
    if(![fontName isEqualToString:[fortuneDisplay getFontName]]) {

        [fortuneDisplay setFontName:fontName];
    }
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
    if (fortuneDisplay == nil) {
        fortuneDisplay = [self fortuneDisplay:(SingleFortune *) self.jsonModel];
        [self.view addSubview:fortuneDisplay];
    }
    else {
        [fortuneDisplay updateFortune:(SingleFortune *) self.jsonModel];
    }

}


- (FortuneMainDisplay*)fortuneDisplay:(SingleFortune *)fortune {

    FortuneMainDisplay *fortuneMain = [[FortuneMainDisplay alloc] initWithFrame:[self visibleViewFrame] andFortune:fortune];

    NSString *fontName = [self fontNameFromUserSettings];
    if(![fontName isEqualToString:[fortuneDisplay getFontName]]) {

        [fortuneMain setFontName:fontName];
    }

    fortuneMain.userInteractionEnabled = YES;
    return fortuneMain;
}


- (NSString *)fontNameFromUserSettings {

    NSString *lblFontName = [UserSettings loadFontNameForSection:FONT_APP_SECTION_MAIN_FORTUNE];
    if(lblFontName == nil || [lblFontName isEqualToString:@""]) {
        return nil;
    }
    return lblFontName;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint touchLocation = [[touches anyObject] locationInView:self.view];
    CGPoint viewPoint = [fortuneDisplay convertPoint:touchLocation fromView:self.view];

    if ([fortuneDisplay pointInside:viewPoint withEvent:event]) {
        [self loadFortune];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
