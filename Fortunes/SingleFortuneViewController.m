
#import "SingleFortuneViewController.h"


@implementation SingleFortuneViewController {

}


- (void)loadFortune {

    [self alertLoadingIndicator];

    /*!
        RESTClient calls delegate method setRestAnswer:(JSONModel *)jsonModel
        on remote access completion:
     */
    [RESTClient loadRandomFortune:self];
}


@end