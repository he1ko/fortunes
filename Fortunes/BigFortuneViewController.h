
#import "BaseViewController.h"


@interface BigFortuneViewController : BaseViewController <FavouriteFortune>

@property(nonatomic, strong) SingleFortune *fortune;

- (void)loadFortune;

@end