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

#import "MyUnsubscribeListener.h"

@implementation MyUnsubscribeListener



-(void) onSuccess:(WLResponse *)response{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsubscribed successfully"
                                                                   message: nil
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
    [alert show];
}

-(void)onFailure:(WLFailResponse *)response{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to unsubscribe"
                                                                   message: nil
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
    [alert show];
}

@end
