//
// Created by Heiko Bublitz on 03.08.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//

#import "BigFortuneViewController.h"
#import "FortuneMainDisplay.h"
#import "SingleFortune+Favourites.h"
#import "UIViewController+NavigationBar.h"


@implementation BigFortuneViewController {

@private
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


/*!
    override in Implementation ...
 */
- (void)loadFortune {

    NSLog(@"%s - OVERRIDE THIS IN %@.m", sel_getName(_cmd), [self class]);
}


- (void)setRestAnswer:(JSONModel *)jsonModel {

    [super setRestAnswer:jsonModel];

    [self hideAlert];

    if([self.jsonModel isKindOfClass:[SingleFortune class]]) {

        [self setupFortune];
    }
}


- (void)setupFortune {

    _fortune = (SingleFortune *)self.jsonModel;
    _fortune.favDelegate = self;

    /// main fortune display
    if (fortuneDisplay == nil) {
        fortuneDisplay = [self fortuneDisplay];
        [self.view addSubview:fortuneDisplay];
        [self setFavouriteButton];
    }
    else {
        [fortuneDisplay updateFortune:_fortune];
        [fortuneDisplay setX:self.view.frame.size.width];
        [self fadeInFortune];
    }
}


- (void)fadeInFortune {

    CGFloat fortuneX = self.view.center.x - fortuneDisplay.frame.size.width /2;

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // [fortuneDisplay setAlpha:1.0];
                         [fortuneDisplay setX:fortuneX];
                     }
                     completion:^(BOOL finished) {
                         [self setFavouriteButton];
                     }
    ];
}


- (void)setFavouriteButton {

    [self addNavBarButtonWithImageName:[_fortune favImageButtonName] side:NAV_BAR_BUTTON_SIDE_RIGHT];
}


- (void)favouriteStateChangedTo:(BOOL)isFav {

    NSString *alertTitle = NSLocalizedString(@"HUD.title.yourFavourites", @"HUD.title.yourFavourites");
    NSString *alertSubtitle;

    if(isFav) {
        alertSubtitle = NSLocalizedString(@"home.fav.added.message", @"Fortune als Favorit gespeichert.");
    }
    else {
        alertSubtitle = NSLocalizedString(@"home.fav.removed.message", @"Fortune aus Deinen Favoriten entfernt.");
    }

    [self alertWithTitle:alertTitle subtitle:alertSubtitle duration:1.5];
}


- (void)rightNavigationButtonTouched {

    [_fortune switchFavouriteState];
    [self setFavouriteButton];
}



- (FortuneMainDisplay*)fortuneDisplay {

    FortuneMainDisplay *fortuneMain = [[FortuneMainDisplay alloc] initWithFrame:[self visibleViewFrame] andFortune:_fortune];

    UIFont *font = [self fontFromUserSettings];
    [fortuneMain setFont:font];

    fortuneMain.backgroundColor = [UIColor clearColor];

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