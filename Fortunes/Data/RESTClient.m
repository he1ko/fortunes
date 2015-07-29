//
//  RESTClient.m
//  Fortunes
//
//  Created by Heiko Bublitz on 21.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "RESTClient.h"
#import "BaseViewController.h"

static NSString *urlBaseRestServer = @"http://www.bestellbutton.de/REST";
static NSString *endpointRandomFortune = @"fortunesList/random";
static NSString *endpointAllFortunes = @"fortunesList";


@implementation RESTClient

+ (void)loadFortunesList:(BaseViewController *)sender {

    NSString *url = [NSString stringWithFormat:@"%@/%@", urlBaseRestServer, endpointAllFortunes];

    FortuneList *fortuneList = [[FortuneList alloc]initFromURLWithString:url
        completion:^(JSONModel *model, JSONModelError *err) {

            if(err) {
                NSLog(@"Error: %@", err.localizedDescription);
            }
            else {
                [sender setRestAnswer:model];
            }
        }];
}

+ (void)loadRandomFortune:(BaseViewController *)sender {

    NSString *url = [NSString stringWithFormat:@"%@/%@", urlBaseRestServer, endpointRandomFortune];

    SingleFortune *fortune = [[SingleFortune alloc]initFromURLWithString:url
        completion:^(JSONModel *model, JSONModelError *err) {

            if(err) {
                NSLog(@"Error: %@", err.localizedDescription);
                NSLog(@"%@", [model toJSONString]);
            }
            else {
                [sender setRestAnswer:model];
            }
        }];
}


+ (NSString *) getDataFrom:(NSString *)url {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;

    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];

    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %d", url, (int)[responseCode statusCode]);
        return nil;
    }

    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


+ (void)translateText:(NSString *)text sender:(UIViewController *)sender {

    NSString *langString = @"de|en";
    NSString *textEscaped = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *langStringEscaped = [langString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/language/translate?q=%@&v=1.0&langpair=%@",
                                               textEscaped, langStringEscaped];


}


@end
