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

#import "MyChallengeHandler.h"
#import "LoginViewController.h"

@implementation MyChallengeHandler

-(id)initWithViewController:(MainViewController *)vc {
    self = [super initWithRealm:@"SampleAppRealm"];
    self.vc = vc;
    return self;
}

-(BOOL) isCustomResponse:(WLResponse *)response {
    NSLog(@"isCustomResponse");
    if(response && response.responseText){
        if ([response.responseText rangeOfString:@"j_security_check" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            NSLog(@"Detected j_security_check string - returns true");
            return true;
        }
    }
    return false;
}


-(void) handleChallenge:(WLResponse *)response {
    NSLog(@"ChallengeHandler");
    //[self.vc.loginBtn setEnabled:YES];
    //self.vc.challengeHandler = self;
    if([self.vc.navigationController.visibleViewController isKindOfClass:[LoginViewController class]]){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            LoginViewController*  loginController = (LoginViewController*) self.vc.navigationController.visibleViewController;
            [loginController.loginBtn setEnabled:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please try again"
                                                                           message: nil
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil];
            [alert show];
        });
    }
    else{
        [self.vc performSegueWithIdentifier:@"showLogin" sender:self.vc];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            LoginViewController*  loginController = (LoginViewController*) self.vc.navigationController.visibleViewController;
            loginController.challengeHandler = self;
            [loginController.loginBtn setEnabled:YES];
        });
    }
}

-(void) onSuccess:(WLResponse *)response {
    NSLog(@"Challenge succeeded");
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    [self submitSuccess:response];
}

-(void) onFailure:(WLFailResponse *)response {
    NSLog(@"Challenge failed");
    [self submitFailure:response];
}

@end
