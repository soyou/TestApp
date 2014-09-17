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
static NSString * const kFeedbackDicValueKey = @"dicValue";
static NSString * const kFeedbackArrayValueKey = @"arrayValue";



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
}

- (void)readDefaultsValues {
    NSLog(@"Config과 Feedback 읽기");
    
    NSDictionary *serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
    // serverConfig를 이용해서 필요한 설정을 해본다.
    if (!serverConfig) {
        NSLog(@"Config empty");
    } else {
        NSNumber *booleandValue = serverConfig[kFeedbackBooleandValueKey];
        if (booleandValue && [booleandValue isKindOfClass:[NSNumber class]]) {
            NSLog(@"config의 boolean value = %@", [NSString stringWithFormat:@"%@", ([booleandValue boolValue]?@"YES":@"NO")]);
        } else {
            NSLog(@"config에 boolean value 없음");
        }
        
        NSNumber *numberValue = serverConfig[kFeedbackNumberValueKey];
        if (numberValue && [numberValue isKindOfClass:[NSNumber class]]) {
            NSLog(@"config의 number value = %d", [numberValue intValue]);
        } else {
            NSLog(@"config에 number value 없음");
        }
        
        NSString *stringValue = serverConfig[kFeedbackStringValueKey];
        if (stringValue && [stringValue isKindOfClass:[NSString class]]) {
            NSLog(@"config의 string value = %@", stringValue);
        } else {
            NSLog(@"config에 string value 없음");
        }
    }
    
    
    // Fetch the success and failure count values from NSUserDefaults to display.
    // Data validation for feedback values is a good idea, in case the application wrote out an unexpected value.
    NSDictionary *feedback = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kFeedbackKey];
    
    NSNumber *booleandValue = feedback[kFeedbackBooleandValueKey];
    if (booleandValue && [booleandValue isKindOfClass:[NSNumber class]]) {
        NSLog(@"feedback의 boolean value 적용 = %@", [NSString stringWithFormat:@"%@", ([booleandValue boolValue]?@"YES":@"NO")]);
        _feedbackBooleanType.on = [booleandValue boolValue];
    } else {
        NSLog(@"기본 boolean value 적용");
        _feedbackBooleanType.on = YES;
    }
    
    
    NSNumber *numberValue = feedback[kFeedbackNumberValueKey];
    if (numberValue && [numberValue isKindOfClass:[NSNumber class]]) {
        NSLog(@"feedback의 number value 적용 = %d", [numberValue intValue]);
        _feedbackNumberType.value = [numberValue integerValue];
    } else {
        NSLog(@"기본 number value 적용");
        _feedbackNumberType.value = 50;
    }
    _feedbackNumberTypeValueLabel.text = [NSString stringWithFormat:@"%1.0f", _feedbackNumberType.value];
    
    
    NSString *stringValue = feedback[kFeedbackStringValueKey];
    if (stringValue && [stringValue isKindOfClass:[NSString class]]) {
        NSLog(@"feedback의 string value 적용 = %@", stringValue);
        _feedbackStringType.text = stringValue;
    } else {
        NSLog(@"기본 string value 적용");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)feedbackWrite:(id)sender {
    NSLog(@"feedback Write");
    
    // userDefault에 write 한다.
    // Write the updated value into the feedback dictionary each time it changes.
    NSMutableDictionary *feedback = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kFeedbackKey] mutableCopy];
    if (!feedback) {
        feedback = [NSMutableDictionary dictionary];
    }
    NSLog(@"boolean type : %@", [NSString stringWithFormat:@"%@", (_feedbackBooleanType.on?@"YES":@"NO")]);
    feedback[kFeedbackBooleandValueKey] = @(_feedbackBooleanType.on);
    NSLog(@"number type : %1.0f", _feedbackNumberType.value);
    feedback[kFeedbackNumberValueKey] = @(_feedbackNumberType.value);
    NSLog(@"string type : %@", _feedbackStringType.text);
    feedback[kFeedbackStringValueKey] = _feedbackStringType.text;
    
    // 콜렉션 객체 삽입
    NSMutableDictionary *dicSample = [NSMutableDictionary dictionary];
    dicSample[kFeedbackBooleandValueKey] = @(_feedbackBooleanType.on);
    dicSample[kFeedbackNumberValueKey] = @(_feedbackNumberType.value);
    dicSample[kFeedbackStringValueKey] = _feedbackStringType.text;
    
    NSMutableArray *arraySample = [[NSMutableArray alloc] init];
    [arraySample addObject:@(_feedbackBooleanType.on)];
    [arraySample addObject:@(_feedbackNumberType.value)];
    [arraySample addObject:_feedbackStringType.text];
    
    feedback[kFeedbackDicValueKey] = dicSample;
    feedback[kFeedbackArrayValueKey] = arraySample;
    
    [[NSUserDefaults standardUserDefaults] setObject:feedback forKey:kFeedbackKey];
}


- (IBAction)feedbackNumberTypeValueChanged:(UISlider *)sender {
    _feedbackNumberTypeValueLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
}

- (IBAction)configWrite:(id)sender {
    NSLog(@"config Write");
    NSMutableDictionary *serverConfig = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey] mutableCopy];
    if (!serverConfig) {
        NSLog(@"Config object empty, and new object create");
        serverConfig = [NSMutableDictionary dictionary];
    }
    
    NSLog(@"boolean type : %@", [NSString stringWithFormat:@"%@", (_feedbackBooleanType.on?@"YES":@"NO")]);
    serverConfig[kFeedbackBooleandValueKey] = @(_feedbackBooleanType.on);
    NSLog(@"number type : %1.0f", _feedbackNumberType.value);
    serverConfig[kFeedbackNumberValueKey] = @(_feedbackNumberType.value);
    NSLog(@"string type : %@", _feedbackStringType.text);
    serverConfig[kFeedbackStringValueKey] = _feedbackStringType.text;
    
    [[NSUserDefaults standardUserDefaults] setObject:serverConfig forKey:kConfigurationKey];
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
