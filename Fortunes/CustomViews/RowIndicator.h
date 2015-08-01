
@interface RowIndicator : UIImageView

- (id)initInFrame:(CGRect)parentFrame;

- (void)setRowNumber:(int)rowNum;

- (void)show:(BOOL)visible;

- (void)setYPos:(CGFloat)yPos;

@end
