@class SingleFortune;

@interface FortuneMainDisplay : UIView

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune;

- (NSString *)getFontName;

- (void)setFontName:(NSString *)fontName;

- (void)updateFortune:(SingleFortune *)fortune;

@end