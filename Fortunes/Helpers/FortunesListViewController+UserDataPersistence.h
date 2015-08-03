

#import "FortunesListViewController.h"

@interface FortunesListViewController (UserDataPersistence)

- (void)saveLastSection:(FortuneListToolbarItemIndex)section;
- (FortuneListToolbarItemIndex)lastSection;

- (void)saveTopFortuneIdx:(int)idx forSection:(FortuneListToolbarItemIndex)section;

- (CGFloat)topFortuneIdxForSection:(FortuneListToolbarItemIndex)section;
@end