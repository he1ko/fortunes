

@protocol FortuneListToolbar;


@interface Toolbar : UIToolbar

@property(nonatomic, strong) id <FortuneListToolbar> toolbarDelegate;

- (void)setItemActive:(BOOL)active withIndex:(NSUInteger)index;

- (UIBarButtonItem *)toolbarItemWithImageName:(NSString *)imgName;

- (void)addTopLine:(UIColor *)color;

@end


@protocol FortuneListToolbar
- (void)toolbarItemTouchedWithIndex:(NSUInteger)itemIndex;
@end