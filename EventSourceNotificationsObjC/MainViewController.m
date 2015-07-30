/**
* Copyright 2015 IBM Corp.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/


#import "MainViewController.h"
#import "MyConnectListener.h"
#import "MyChallengeHandler.h"
#import "ReadyToSubscribeListener.h"
#import "MySubscribeListener.h"
#import "MyUnsubscribeListener.h"

@interface MainViewController ()



@end

@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wlpush = [[WLPush sharedInstance] init];
    self.alias = @"iOSPushAlias";
    
    ReadyToSubscribeListener *readyToSubscribeListener = [[ReadyToSubscribeListener alloc] init];
    readyToSubscribeListener.alias = self.alias;
    readyToSubscribeListener.adapterName = @"PushAdapter";
    readyToSubscribeListener.eventSourceName = @"PushEventSource";
    [self.wlpush setOnReadyToSubscribeListener:readyToSubscribeListener];
    
    NSLog(@"Connecting to MobileFirst Server...");
    MyConnectListener *connectListener = [[MyConnectListener alloc] init];
    [[WLClient sharedInstance] registerChallengeHandler:[[MyChallengeHandler alloc] initWithViewController:self] ];
    [[WLClient sharedInstance] wlConnectWithDelegate:connectListener];
}

- (IBAction)isPushSupported:(id)sender {
    if ([self.wlpush isPushSupported]){
        [self alertTrue];
    } else {
        [self alertFalse];
    }
}


- (IBAction)isSubscribed:(id)sender {
    if ([self.wlpush isSubscribed:self.alias]){
        [self alertTrue];
    } else {
        [self alertFalse];
    }
}

- (IBAction)subscribe:(id)sender {
    MySubscribeListener *mySubscribeListener = [[MySubscribeListener alloc] init];
    [self.wlpush subscribe:self.alias :nil :mySubscribeListener];
}

- (IBAction)unsubscribe:(id)sender {
    MyUnsubscribeListener *myUnsubscribeListener = [[MyUnsubscribeListener alloc] init];
    [self.wlpush unsubscribe:self.alias :myUnsubscribeListener];
}


- (void)alertTrue{
    UIAlertView *adapterResponseAlert = [[UIAlertView alloc] initWithTitle:@"true"
                                                                   message: nil
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
    [adapterResponseAlert show];
}

- (void) alertFalse{
    UIAlertView *adapterResponseAlert = [[UIAlertView alloc] initWithTitle:@"false"
                                                                   message: nil
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
    [adapterResponseAlert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
