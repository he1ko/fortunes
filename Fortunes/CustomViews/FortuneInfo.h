//
//  FortuneInfo.h
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleFortune;

@interface FortuneInfo : UIView

@property(nonatomic, strong) SingleFortune *fortune;

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune;
@end
