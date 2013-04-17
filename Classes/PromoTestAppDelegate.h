//
//  PromoTestAppDelegate.h
//  PromoTest
//
//  Created by WeiJian Wu on 13-04-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PromoTestViewController;

@interface PromoTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PromoTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PromoTestViewController *viewController;

@end

