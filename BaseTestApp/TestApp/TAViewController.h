//
//  TAViewController.h
//  TestApp
//
//  Created by soyou on 2014. 9. 5..
//  Copyright (c) 2014년 S-Core. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAViewController : UIViewController<NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) IBOutlet UITextField *udid;
@property (strong, nonatomic) IBOutlet UITextField *commandUuid;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)btnSend:(id)sender;
- (IBAction)textFiledReturn:(id)sender;

@end
