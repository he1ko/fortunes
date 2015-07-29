//
//  FortuneInfo.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "FortuneInfo.h"
#import "SingleFortune.h"

@implementation FortuneInfo

- (id)initWithFrame:(CGRect)frame andFortune:(SingleFortune *)fortune {

    self = [super initWithFrame:frame];

    if (self) {

        self.backgroundColor = [UIColor darkGrayColor];
        self.fortune = fortune;
    }

    return self;
}


- (void)setupSourceLabels {


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
