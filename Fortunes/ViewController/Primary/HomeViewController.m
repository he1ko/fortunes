//
//  HomeViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "HomeViewController.h"
#import "UIViewController+Layout.h"
#import "FortuneMainDisplay.h"
#import "UIViewController+NavigationBar.h"

@implementation HomeViewController {

@private
    SingleFortune *fortune;
    FortuneMainDisplay *fortuneDisplay;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    [self loadFortune];
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    UIFont *font = [self fontFromUserSettings];
    [fortuneDisplay setFont:font];
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

    fortune = (SingleFortune *)self.jsonModel;
    fortune.favDelegate = self;

    /// main fortune display
    if (fortuneDisplay == nil) {
        fortuneDisplay = [self fortuneDisplay];
        [self.view addSubview:fortuneDisplay];
    }
    else {
        [fortuneDisplay updateFortune:fortune];
    }

    [self setFavouriteButton];
}


- (void)setFavouriteButton {

    [self addNavBarButtonWithImageName:[fortune favImageButtonName] side:NAV_BAR_BUTTON_SIDE_RIGHT];
}


- (void)favouriteStateChangedTo:(BOOL)isFav {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;

    hud.labelText = @"Deine Favoriten";

    if(isFav) {
        hud.detailsLabelText = NSLocalizedString(@"home.fav.added.message", @"Fortune als Favorit gespeichert.");
    }
    else {
        hud.detailsLabelText = NSLocalizedString(@"home.fav.removed.message", @"Fortune aus Deinen Favoriten entfernt.");
    }

    [self performSelector:@selector(hideHud) withObject:nil afterDelay:1.8];
}


- (void)hideHud {

    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)rightNavigationButtonTouched {

    [fortune switchFavouriteState];
    [self setFavouriteButton];
}



- (FortuneMainDisplay*)fortuneDisplay {

    FortuneMainDisplay *fortuneMain = [[FortuneMainDisplay alloc] initWithFrame:[self visibleViewFrame] andFortune:fortune];

    UIFont *font = [self fontFromUserSettings];
    [fortuneMain setFont:font];

    fortuneMain.userInteractionEnabled = YES;
    return fortuneMain;
}


- (UIFont *)fontFromUserSettings {

    return [[FontManager getInstance] fontForSection:FONT_APP_SECTION_MAIN_FORTUNE];
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
