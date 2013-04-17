//
//  PromoTestViewController.h
//  PromoTest
//
//  Created by WeiJian Wu on 13-04-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoTestViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;   

@end

