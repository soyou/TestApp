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

#pragma mark 기본
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 키보드 사라지게하는 코드
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


#pragma mark 버큰 클릭시 처리
- (IBAction)btnSend:(id)sender {
    NSString *msg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                         "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\""
                         "\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">"
                         "<plist version=\"1.0\">"
                         "<dict>"
                         "<key>UDID</key>"
                         "<string>%@</string>"
                         "<key>CommandUUID</key>"
                         "<string>%@</string>"
                         "<key>Status</key>"
                         "<string>Acknowledged</string>"
                         "</dict>"
                         "</plist>", _udid.text, _commandUuid.text];
	
	//---확인을 위해서 Debugger Console에 출력---
	NSLog(@"msg = %@",msg);
    _resultLabel.text = msg;
//    [self sendHTTP];
}



#pragma mark 통신 관련
-(void) sendHTTP {
    NSURL *url = [NSURL URLWithString:@"http://www.naver.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (data.length > 0 && connectionError == nil) {
                                   NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                   NSLog(@"Data = %@",text);
                               }
                           }
     ];
    
}
@end
