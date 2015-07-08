/*
 *
 COPYRIGHT LICENSE: This information contains sample code provided in source code form. You may copy, modify, and distribute
 these sample programs in any form without payment to IBM® for the purposes of developing, using, marketing or distributing
 application programs conforming to the application programming interface for the operating platform for which the sample code is written.
 Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES,
 EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY,
 FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE.
 IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.
 
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
