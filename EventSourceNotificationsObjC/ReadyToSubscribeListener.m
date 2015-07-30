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

#import "ReadyToSubscribeListener.h"
#import "MyEventSourceListener.h"

@implementation ReadyToSubscribeListener


-(void)OnReadyToSubscribe{
	MyEventSourceListener *eventSourceListener=[[MyEventSourceListener alloc] init];
	[[WLPush sharedInstance] registerEventSourceCallback:self.alias :self.adapterName
														:self.eventSourceName :eventSourceListener];
    UIAlertView *adapterResponseAlert = [[UIAlertView alloc] initWithTitle:@"Ready to subscribe"
                                                                   message: nil
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
    [adapterResponseAlert show];
}

@end
