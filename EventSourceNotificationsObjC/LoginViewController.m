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


#import "LoginViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBtn setEnabled:NO];
}

- (IBAction)login:(id)sender {
    [self.challengeHandler submitLoginForm:@"j_security_check"
                         requestParameters:@{@"j_username": self.username.text, @"j_password": self.password.text}
                            requestHeaders:nil requestTimeoutInMilliSeconds:0 requestMethod:@"POST"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
