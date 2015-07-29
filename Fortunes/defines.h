
/**
* device type detection
*/
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)? NO : YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


/**
* Language setting for testing purpose
*/
#define APP_LANGUAGE_ENGLISH YES;


/**
 *  Macro: UIColor* from HEX RGB Value. 0xFF0000 is 100% red;
 */
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define TextViewImplicitYMargin 10.0f

