
/*! @discussion UILabel that resizes by itself.

 - Height is given and fixed --> Font size will be adopted
 - Font size is given and fixed --> Height will be adopted

 Width is set while initialization by initWithFrame ( .. andResizeMode)
 and will never be changed automatically.

 ResizeMode decides which property is fixed and which one should be adjusted.

 - AUTOLABEL_RESIZE_FONT: Font will be adjusted to given height.
 - AUTOLABEL_RESIZE_HEIGHT: Frame height will be adjusted to given font size.

    Usage example:

    lblSample = [[LabelAutoSize alloc] initWithFrame:self.view.frame resizeMode:mode];];
    lblSample.text = @"Lorem Ipsum ... my hovercraft is full of eals!";
    lblSample.font = [UIFont FontWithName:@"Arial" size:33.0f];

    set Layout properties. Colors, Border, ...

    [lblSample adjust];

    lblSample.center = self.view.center;

 */


typedef NS_ENUM(NSInteger, AutoLabelResizeMode) {

    AUTOLABEL_RESIZE_FONT,
    AUTOLABEL_RESIZE_HEIGHT
};


@interface LabelAutoSize : UILabel

- (id)initWithFrame:(CGRect)frame resizeMode:(AutoLabelResizeMode)resizeMode;
- (void)adjust;

@end
