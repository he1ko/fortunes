//
//  HomeViewController.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+Layout.h"
#import "FortuneMainDisplay.h"

@implementation HomeViewController {

@private
    SingleFortune *fortune;
    FortuneMainDisplay *fortuneDisplay;
    UIButton *favouriteButton;
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

    if(favouriteButton) {
        [favouriteButton removeFromSuperview];
        favouriteButton = nil;
    }

    favouriteButton = [fortune favImageButton];
    [self alignView:favouriteButton atTopOfRect:[self contentCanvas]];
    [favouriteButton setX:[self contentCanvas].size.width - favouriteButton.frame.size.width];
    [favouriteButton addTarget:self action:@selector(favouriteButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:favouriteButton];
}


- (void)favouriteButtonTouch {

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


- (void)fortuneFavouriteStateChanged {

    NSLog(@"Fav-Status changed...!");
    UIButton *btFav = [fortune favImageButton];
    [favouriteButton setImage:[btFav imageForState:UIControlStateNormal] forState:UIControlStateNormal];
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
