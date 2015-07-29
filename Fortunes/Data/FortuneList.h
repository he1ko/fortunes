//
//  FortuneList.h
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "JSONModel.h"
#import "SingleFortune.h"

@interface FortuneList : JSONModel

@property(nonatomic, strong) NSArray<SingleFortune> *fortunes;

@end
