
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
    [bt setBackgroundColor:[UIColor whiteColor]];
    [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    return bt;
}


+ (id)secondaryButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetDarkText]];
    return bt;
}


+ (id)okButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetButtonGreen]];
    return bt;
}


+ (id)cancelButtonWithFrame:(CGRect)frame text:(NSString *)text {

    UIButton *bt = [[self alloc] initWithFrame:frame text:text];
    [bt setBackgroundColor:[UIColor presetButtonRed]];
    return bt;
}


@end
