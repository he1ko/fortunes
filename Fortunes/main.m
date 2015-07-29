//
//  main.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {

        NSArray *languages = @[@"de", @"en"];
        bool useEnglish = APP_LANGUAGE_ENGLISH;

        if(useEnglish) {

            languages = [[languages reverseObjectEnumerator] allObjects];
        }

        [[NSUserDefaults standardUserDefaults] setObject:languages forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
