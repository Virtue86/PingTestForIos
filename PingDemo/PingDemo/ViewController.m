//
//  ViewController.m
//  PingDemo
//
//  Created by Virtue on 2018/5/2.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import "GBPing.h"


@interface ViewController ()<GBPingDelegate>
@property (strong, nonatomic) GBPing *ping;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setTitle:@"点击开始测试" forState:0];
    [testBtn setTitleColor:[UIColor redColor] forState:0];
    testBtn.frame = CGRectMake(50, 200, self.view.frame.size.width - 100, 30);
    [testBtn addTarget:self action:@selector(testPing) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testPing {
    self.ping = [GBPing new];
    self.ping.host = @"baidu.com";
    //    self.ping.host = @"192.168.1.140";
    
    self.ping.delegate = self;
    self.ping.timeout = 1;
    self.ping.pingPeriod = 0.9;
    
    // setup the ping object (this resolves addresses etc)
    [self.ping setupWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            // start pinging
            [self.ping startPinging];
            
            // stop it after 5 seconds 发送多次数据包停止
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"stop it");
                [self.ping stop];
                self.ping = nil;
            });
        } else {
            NSLog(@"failed to start");
        }
    }];
    
    
}

#pragma mark GBPingDelegate
-(void)ping:(GBPing *)pinger didReceiveReplyWithSummary:(GBPingSummary *)summary {
    NSLog(@"REPLY>  %@", summary);
}

-(void)ping:(GBPing *)pinger didReceiveUnexpectedReplyWithSummary:(GBPingSummary *)summary {
    NSLog(@"BREPLY> %@", summary);
}

-(void)ping:(GBPing *)pinger didSendPingWithSummary:(GBPingSummary *)summary {
    NSLog(@"SENT>   %@", summary);
}

-(void)ping:(GBPing *)pinger didTimeoutWithSummary:(GBPingSummary *)summary {
    NSLog(@"TIMOUT> %@", summary);
}

-(void)ping:(GBPing *)pinger didFailWithError:(NSError *)error {
    NSLog(@"FAIL>   %@", error);
}

-(void)ping:(GBPing *)pinger didFailToSendPingWithSummary:(GBPingSummary *)summary error:(NSError *)error {
    NSLog(@"FSENT>  %@, %@", summary, error);
}
@end
