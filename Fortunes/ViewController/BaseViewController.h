
#import "RESTClient.h"

@interface BaseViewController : UIViewController

@property(nonatomic, strong) JSONModel *jsonModel;

- (void)setRestAnswer:(JSONModel *)jsonModel;

@end
