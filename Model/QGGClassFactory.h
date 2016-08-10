//
//  QGGClassFactory.h
//  QGGDraft
//
//  Created by taizi on 15/12/6.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGGClassFactory : NSObject
+(id) instanceWithClassName:(NSString*) className;
+ (UIViewController*)instaneWithVCName:(NSString*)vcName;
@end
