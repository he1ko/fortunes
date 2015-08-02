//
//  RESTClient.h
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "JSONModelLib.h"
#import "FortuneList.h"

@class UIViewController;

@interface RESTClient : NSObject

+ (void)loadFortunesList:(UIViewController *)sender;

+ (void)loadRandomFortune:(UIViewController *)sender;

+ (NSString *)getDataFrom:(NSString *)url;
@end
