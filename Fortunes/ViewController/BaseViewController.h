//
//  UIViewController.h
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "RESTClient.h"

@interface BaseViewController : UIViewController

@property(nonatomic, strong) JSONModel *jsonModel;

- (void)addRightNavigationButtonWithText:(NSString *)text;

- (void)removeRightNavigationButtonWithText:(NSString *)text;

- (void)rightNavigationButtonTouched;

- (void)leftNavigationButtonTouched;

- (void)setRestAnswer:(JSONModel *)jsonModel;

@end
