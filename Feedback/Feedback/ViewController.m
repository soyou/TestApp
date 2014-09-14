//
//  ViewController.m
//  Feedback
//
//  Created by soyou on 2014. 9. 12..
//  Copyright (c) 2014년 S-Core. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// The Managed app configuration dictionary pushed down from an MDM server are stored in this key.
static NSString * const kConfigurationKey = @"com.apple.configuration.managed";
// The dictionary that is sent back to the MDM server as feedback must be stored in this key.
static NSString * const kFeedbackKey = @"com.apple.feedback.managed";


static NSString * const kFeedbackBooleandValueKey = @"booleandValue";
static NSString * const kFeedbackNumberValueKey = @"numberValue";
static NSString * const kFeedbackStringValueKey = @"stringValue";



- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Add Notification Center observer to be alerted of any change to NSUserDefaults.
    // Managed app configuration changes pushed down from an MDM server appear in NSUSerDefaults.
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      [self readDefaultsValues];
                                                  }];
    
    // Call readDefaultsValues to make sure default values are read at least once.
    [self readDefaultsValues];
    
    _feedbackNumberTypeValueLabel.text = [NSString stringWithFormat:@"%1.0f", _feedbackNumberType.value];
}

- (void)readDefaultsValues {
    NSLog(@"Config과 Feedback 읽기 및 쓰기");
    
    NSDictionary *serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
    // serverConfig를 이용해서 필요한 설정을 해본다.
    
    // Fetch the success and failure count values from NSUserDefaults to display.
    // Data validation for feedback values is a good idea, in case the application wrote out an unexpected value.
    NSDictionary *feedback = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kFeedbackKey];
    NSString *stringValue = feedback[kFeedbackStringValueKey];
    if (stringValue && [stringValue isKindOfClass:[NSString class]]) {
        _feedbackStringType.text = stringValue;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)feedbackWrite:(id)sender {
    // 각각의 UI의 값을 읽어온다.
    NSLog(@"UI값 읽기");
    if( _feedbackBooleanType.isOn ) {
        NSLog(@"boolean type : TRUE");
    } else {
        NSLog(@"boolean type : FALSE");
    }
    NSLog(@"number type : %1.0f", _feedbackNumberType.value);
    
    NSLog(@"string type : %@", _feedbackStringType.text);
    
    // userDefault에 write 한다.
    // Write the updated value into the feedback dictionary each time it changes.
    NSMutableDictionary *feedback = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kFeedbackKey] mutableCopy];
    if (!feedback) {
        feedback = [NSMutableDictionary dictionary];
    }
    feedback[kFeedbackBooleandValueKey] = @(_feedbackBooleanType.isOn);
    feedback[kFeedbackNumberValueKey] = @(_feedbackNumberType.value);
    feedback[kFeedbackStringValueKey] = _feedbackStringType.text;
    [[NSUserDefaults standardUserDefaults] setObject:feedback forKey:kFeedbackKey];
}


- (IBAction)feedbackNumberTypeValueChanged:(UISlider *)sender {
    _feedbackNumberTypeValueLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
}

- (IBAction)feedbackStringTypeEditingDidEnd:(id)sender {
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_feedbackStringType isFirstResponder] && [touch view] != _feedbackStringType ) {
        [_feedbackStringType resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
