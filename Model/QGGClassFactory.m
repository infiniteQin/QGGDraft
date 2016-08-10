//
//  QGGClassFactory.m
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGClassFactory.h"


@implementation QGGClassFactory

+(id) instanceWithClassName:(NSString*) className {
    Class class = NSClassFromString(className);
    return [[class alloc] init];
}

+ (UIViewController*)instaneWithVCName:(NSString*)vcName {
    Class class = NSClassFromString(vcName);
    if ([class isSubclassOfClass:[UIViewController class]]) {
        UIViewController *vc = [[class alloc] initWithNibName:vcName bundle:nil];
        return vc;
    }
    return nil;
}

@end
