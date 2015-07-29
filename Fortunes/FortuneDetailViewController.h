//
//  FortuneDetailViewController.h
//  Fortunes
//
//  Created by Heiko Bublitz on 27.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "BaseViewController.h"

@interface FortuneDetailViewController : BaseViewController <UITextViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, strong) SingleFortune *fortune;

@end
