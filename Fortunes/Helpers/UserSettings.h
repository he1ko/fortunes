//
// Created by Heiko Bublitz on 22.07.15.
// Copyright (c) 2015 Jemix. All rights reserved.
//




@interface UserSettings : NSObject


+ (NSString *)loadStringWithKey:(NSString *)key;
+ (NSArray *)loadArrayWithKey:(NSString *)key;

+ (NSInteger)loadNSIntegerWithKey:(NSString *)key;

+ (void)saveNSInteger:(NSInteger)number forKey:(NSString *)key;

+ (void)saveObject:(id)object forKey:(NSString *)key;

+ (int)loadFortuneListScrollPosition;
+ (void)saveFortuneListScrollPosition:(int)scrollPos;



@end