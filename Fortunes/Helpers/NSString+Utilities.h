

@interface NSString (Utilities)


+ (BOOL)isEmpty:(NSString *)s;

- (NSString *)repairMultipleSpaces;

- (NSString *)removeTabs;

- (NSString *)removeNewlineCharacters;

- (NSString *)trim;

- (NSString *)removeLeadingAndTrailingQuotes;
@end