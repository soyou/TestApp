//
//  TAViewController.m
//  TestApp
//
//  Created by soyou on 2014. 9. 5..
//  Copyright (c) 2014년 S-Core. All rights reserved.
//

#import "TAViewController.h"

@interface TAViewController ()

@end

@implementation TAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSend:(id)sender {
    NSLog(@"버튼 클릭");
}

- (IBAction)textFiledReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_udid isFirstResponder] && [touch view] != _udid ) {
        [_udid resignFirstResponder];
    }
    if ([_commandUuid isFirstResponder] && [touch view] != _commandUuid ) {
        [_commandUuid resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
