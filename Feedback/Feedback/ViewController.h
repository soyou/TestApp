//
//  ViewController.h
//  Feedback
//
//  Created by soyou on 2014. 9. 12..
//  Copyright (c) 2014년 S-Core. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *feedbackBooleanType;
@property (strong, nonatomic) IBOutlet UISlider *feedbackNumberType;
@property (strong, nonatomic) IBOutlet UITextField *feedbackStringType;
@property (strong, nonatomic) IBOutlet UIButton *feedbackWriteButton;
@property (strong, nonatomic) IBOutlet UILabel *feedbackNumberTypeValueLabel;

- (IBAction)feedbackWrite:(id)sender;
- (IBAction)feedbackStringTypeEditingDidEnd:(id)sender;
- (IBAction)feedbackNumberTypeValueChanged:(UISlider *)sender;
@end
