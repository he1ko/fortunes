
#import "BaseViewController.h"

@class FortuneMainDisplay;


@interface BigFortuneViewController : BaseViewController <FavouriteFortune>

@property(nonatomic, strong) SingleFortune *fortune;
@property(nonatomic, strong) FortuneMainDisplay *fortuneDisplay;
- (void)loadFortune;

@end