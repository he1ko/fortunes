#import "HomeViewController.h"
#import "FortuneMainDisplay.h"
#import "UIViewController+NavigationBar.h"

@implementation HomeViewController {

}


- (void)viewDidLoad {

    [super viewDidLoad];

    [self setNavigationTitle:NSLocalizedString(@"home.nav.title", @"random wisdom")];
}


- (void)loadFortune {

    [self alertLoadingIndicator];

    /*!
        RESTClient calls delegate method setRestAnswer:(JSONModel *)jsonModel
        on remote access completion:
     */
    [RESTClient loadRandomFortune:self];
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint touchLocation = [[touches anyObject] locationInView:self.view];
    CGPoint viewPoint = [self.fortuneDisplay convertPoint:touchLocation fromView:self.view];

    if ([[self fortuneDisplay] pointInside:viewPoint withEvent:event]) {
        [self loadFortune];
    }
}



@end
