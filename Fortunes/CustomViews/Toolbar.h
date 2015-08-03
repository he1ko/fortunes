

@protocol FortuneListToolbar;


@interface Toolbar : UIToolbar

@property(nonatomic, strong) id <FortuneListToolbar> toolbarDelegate;

@property(nonatomic, strong) NSArray *imageNamesArray;

- (id)initWithImageNamesArray:(NSArray *)imageNames;

- (void)setItemActive:(BOOL)active withIndex:(NSUInteger)index;

- (UIBarButtonItem *)toolbarItemWithImageName:(NSString *)imgName;

- (void)disableItemAtIndex:(NSUInteger)index;

- (void)addTopLine:(UIColor *)color;

@end


@protocol FortuneListToolbar
- (void)toolbarItemTouchedWithIndex:(NSUInteger)itemIndex;
@end