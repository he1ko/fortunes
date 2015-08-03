
#import "Toolbar.h"

static float const defaultToolbarHeight = 48.0;

@interface Toolbar ()
- (void)setupToolbar;
@end

@implementation Toolbar


- (id)init {

    CGRect toolbarFrame = [[UIScreen mainScreen] bounds];
    toolbarFrame.size.height = defaultToolbarHeight;

    /*!
        Position is set in delegates method positionForBar:
     */

    self = [super initWithFrame:toolbarFrame];

    if(self) {
        self.translucent = NO;
        self.opaque = YES;
        self.clipsToBounds = YES;

        [self setupToolbar];
    }
    return self;
}


- (void)setupToolbar {

}


- (void)setItemActive:(BOOL)active withIndex:(NSUInteger)index {

    UIBarButtonItem *item = self.items[index];
    CGFloat opacity = active ? 1.0f : 0.5f;
    [item.customView setAlpha:opacity];
}


- (UIBarButtonItem *)toolbarItemWithImageName:(NSString *)imgName {

    UIButton *imageItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageItem setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [imageItem addTarget:self action:@selector(itemTouch:) forControlEvents:UIControlEventTouchUpInside];
    [imageItem setFrame:CGRectMake(0.0, 0.0, defaultToolbarHeight, defaultToolbarHeight)];

    return [[UIBarButtonItem alloc] initWithCustomView:imageItem];
}


- (void)itemTouch:(id)sender {

    UIButton *bt = (UIButton *) sender;
    UIButton *bt2;
    NSUInteger index = 0;

    for(UIBarButtonItem *bbti in self.items) {

        bt2 = (UIButton *)bbti.customView;
        if(bt2 == bt) {
            NSLog(@"YES! %d", index);
            break;
        }
        index++;
    }

    [_toolbarDelegate toolbarItemTouchedWithIndex:index];
}


- (void) addTopLine:(UIColor*)color {

    UIView *topLine = [[UIView alloc] initWithFrame:self.frame];
    topLine.backgroundColor = color;
    [topLine setHeight:1.0];
    [topLine setY:0.0];
    [self addSubview:topLine];
}


@end
