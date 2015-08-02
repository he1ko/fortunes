
#import "RESTClient.h"
#import "UIViewController+toolbar.h"
#import "UIViewController+Layout.h"

@interface BaseViewController : UIViewController

@property(nonatomic, strong) JSONModel *jsonModel;

- (void)setRestAnswer:(JSONModel *)jsonModel;

@end
