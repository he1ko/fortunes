

#import "HomeViewController.h"

@implementation HomeViewController {

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
