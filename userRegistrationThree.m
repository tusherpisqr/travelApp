//
//  userRegistrationThree.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "userRegistrationThree.h"

@implementation userRegistrationThree
@synthesize  txtEmail,txtPassword,btnLogin;

-(void)viewDidLoad{
    [btnLogin addTarget:self
                 action:@selector(myAction)
       forControlEvents:UIControlEventTouchUpInside];
    ab=NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    
    [txtPassword resignFirstResponder];
    [txtEmail resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    ab=NO;
}

-(void)viewDidAppear:(BOOL)animated{
    ab=NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (ab==NO) {
        return NO;
    }
    else return YES;
    
}
- (void)myAction {
    
    
    
   
    NSString* device_token=@"123456";
    
    NSString* pass=txtPassword.text;
    NSString* email=txtEmail.text;
    
    
    NSString *post = [NSString stringWithFormat:@"device_token=%@&email=%@&device_type=%d&password=%@",device_token,email,1,pass];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/users/userLogin/"]];
    
    [requestT setHTTPMethod:@"POST"];
    
    [requestT setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [requestT setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [requestT setHTTPBody:postData];
    
    [self.view endEditing:YES];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestT delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
        
    } else {
        NSLog(@"Connection could not be made");
        
        
    }

    
    

}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *e;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:nil error:&e];
    
   
    NSDictionary* meta=[dict objectForKey:@"meta"];
    
    NSString* code=(NSString*)[[meta objectForKey:@"status"]stringValue];
    
    if ([code isEqualToString: @"401"]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Email already Exists"
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Close"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
        
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    if ([code isEqualToString: @"400"]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Email account is blocked"
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Close"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
        
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    if ([code isEqualToString: @"404"]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"User account not exist"
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Close"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
        
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    if([code isEqualToString: @"200"]){
        NSDictionary *dict2=(NSDictionary*)[dict objectForKey:@"response"];
        
        NSString* username=(NSString*)[dict2 objectForKey:@"username"];
        
         NSString* sessionId=(NSString*)[dict2 objectForKey:@"session_id"];
        
        NSString* password=(NSString*)[dict2 objectForKey:@"password"];
        
        NSString* email=(NSString*)[dict2 objectForKey:@"email"];
        
        NSString* device_token=(NSString*)[dict2 objectForKey:@"device_token"];
        
        NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
        
        [prefs2 setObject:username forKey:@"username"];
        
        [prefs2 setObject:password forKey:@"pass"];
        
        [prefs2 setObject:email forKey:@"email"];
        
        
        [prefs2 synchronize];
        
        ab=YES;
        
        [self performSegueWithIdentifier:@"alreadyAccount" sender:self];
        
        NSLog(@"success");
    }
}



@end
