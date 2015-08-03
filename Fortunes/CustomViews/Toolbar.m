
#import "Toolbar.h"

static float const defaultToolbarHeight = 48.0;

@interface Toolbar ()
- (void)setupAppearance;
@end

@implementation Toolbar


- (id)initWithImageNamesArray:(NSArray *)imageNames {

    self.imageNamesArray = imageNames;

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

        [self setupItems];
        [self setupAppearance];
    }
    return self;
}


- (void)setupItems {

    NSMutableArray *mItems = [[NSMutableArray alloc] initWithCapacity:[self.imageNamesArray count]];
    NSString *imageName;

    for (int i = 0; i < [self.imageNamesArray count]; i++) {

        imageName = self.imageNamesArray[(NSUInteger)i];
        mItems[(NSUInteger)i] = [self toolbarItemWithImageName:imageName];
    }

    self.items = mItems;
}



- (void)setupAppearance {

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
    NSUInteger count = 0;
    NSUInteger index = 0;

    for(UIBarButtonItem *bbti in self.items) {

        bt2 = (UIButton *)bbti.customView;
        bt2.alpha = 1.0;
        if(bt2 == bt) {
            index = count;
        }
        count++;
    }

    bt.alpha = 0.4;
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
