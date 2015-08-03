
#import "DefaultButton.h"

@implementation DefaultButton


- (id)initWithFrame:(CGRect)frame text:(NSString *)text {

    self = [super initWithFrame:frame];

    if (self) {
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }

    return self;
}

+ (id)primaryButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor clearColor]];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addBorder:[UIColor whiteColor] width:1.0 toButton:bt];
    return bt;
}


+ (id)secondaryButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetItemBGOthers]];
    return bt;
}


+ (id)okButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetButtonGreen]];
    [self addBorder:[UIColor whiteColor] width:1.0 toButton:bt];
    return bt;
}


+ (id)cancelButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetButtonRed]];
    [self addBorder:[UIColor whiteColor] width:1.0 toButton:bt];
    return bt;
}


+ (UIButton *)addBorder:(UIColor *)color width:(CGFloat)width toButton:(UIButton *)bt {

    bt.layer.borderColor = [[UIColor whiteColor] CGColor];
    bt.layer.borderWidth = 1.0;
    return bt;
}


@end
