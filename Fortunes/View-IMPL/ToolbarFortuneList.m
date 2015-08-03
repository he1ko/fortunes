
#import "ToolbarFortuneList.h"

@implementation ToolbarFortuneList


- (void)setupToolbar {

    self.barTintColor = [UIColor presetHighlight];

    NSMutableArray *mItems = [[NSMutableArray alloc] initWithCapacity:4];

    mItems[TOOLBAR_ITEM_INDEX_ALL_FORTUNES] = [self toolbarItemWithImageName:@"AllFortunes"];
    mItems[TOOLBAR_ITEM_INDEX_FAVOURITES] = [self toolbarItemWithImageName:@"favourites-remove"];
    mItems[TOOLBAR_ITEM_INDEX_TOP] = [self toolbarItemWithImageName:@"ArrowTop"];
    mItems[TOOLBAR_ITEM_INDEX_BOTTOM] = [self toolbarItemWithImageName:@"ArrowEnd"];

    self.items = mItems;

    [self addTopLine:[UIColor colorWithWhite:1.0 alpha:0.6]];

}


@end
