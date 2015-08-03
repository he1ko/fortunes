
#import "RESTClient.h"
#import "UIViewController+toolbar.h"
#import "UIViewController+Layout.h"
#import "UIViewController+Alert.h"

@interface BaseViewController : UIViewController

@property(nonatomic, strong) JSONModel *jsonModel;

- (void)setRestAnswer:(JSONModel *)jsonModel;

- (void)setAlertOffsetY:(CGFloat)offset;

- (CGFloat)getAlertOffsetY;
@end
