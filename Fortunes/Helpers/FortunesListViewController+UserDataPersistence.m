

#import "FortunesListViewController+UserDataPersistence.h"
#import "UserSettings.h"

static NSString *keyLastSection = @"lastTableViewControllerSection";
static NSString *keyTemplateScrollPos = @"scrollPosInSection_%d";


@implementation FortunesListViewController (UserDataPersistence)

- (void)saveLastSection:(FortuneListToolbarItemIndex)section {

    [UserSettings saveNSInteger:section forKey:keyLastSection];
}

- (FortuneListToolbarItemIndex)lastSection {

    return (FortuneListToolbarItemIndex)[UserSettings loadNSIntegerWithKey:keyLastSection];
}




- (void)saveTopFortuneIdx:(int)idx forSection:(FortuneListToolbarItemIndex)section {

    NSString *key = [NSString stringWithFormat:keyTemplateScrollPos, (int)section];
    [UserSettings saveNSInteger:idx forKey:key];
}

- (CGFloat)topFortuneIdxForSection:(FortuneListToolbarItemIndex)section {

    NSString *key = [NSString stringWithFormat:keyTemplateScrollPos, (int)section];
    return [UserSettings loadNSIntegerWithKey:key];
}






@end