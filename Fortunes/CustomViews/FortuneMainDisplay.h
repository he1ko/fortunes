@class SingleFortune;

@interface FortuneMainDisplay : UIView

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune;

- (void)setFont:(UIFont *)font;

- (void)updateFortune:(SingleFortune *)fortune;

@end