@class SingleFortune;

@interface FortuneMainDisplay : UIView

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune;

- (CGFloat)getTextMargin;

- (NSString *)getFontName;

- (void)setFont:(UIFont *)font;

- (void)updateFortune:(SingleFortune *)fortune;

@end