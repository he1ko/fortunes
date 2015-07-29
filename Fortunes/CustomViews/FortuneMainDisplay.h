@class SingleFortune;

@interface FortuneMainDisplay : UIView

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune;
- (void)updateFortune:(SingleFortune *)fortune;

@end