//
//  userRegistration.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/28/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "userRegistrationTwo.h"

#import "homeSearchTwo.h"

@implementation userRegistrationTwo

@synthesize txtUser,txtPassword,txtEmail,btnRegister;

-(void)viewDidLoad{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    ab=NO;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)dismissKeyboard {
    [txtUser resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtEmail resignFirstResponder];
}

-(void)saveInside{
    
   
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
    
    if ([code isEqualToString: @"404"]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Email doesnot matches"
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

    
    if([code isEqualToString: @"200"]){
        NSDictionary *dict2=(NSDictionary*)[dict objectForKey:@"response"];
        
        NSString* username=(NSString*)[dict2 objectForKey:@"username"];
        
     
        
        NSString* password=(NSString*)[dict2 objectForKey:@"password"];
        
        NSString* email=(NSString*)[dict2 objectForKey:@"email"];
        
        NSString* device_token=(NSString*)[dict2 objectForKey:@"device_token"];
        
        NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
        
        [prefs2 setObject:username forKey:@"username"];
        
         [prefs2 setObject:password forKey:@"pass"];
        
         [prefs2 setObject:email forKey:@"email"];
        

        ab=YES;

        
        [prefs2 synchronize];


       
        [self performSegueWithIdentifier:@"eef" sender:self];
        
        NSLog(@"success");
    }
}

- (void)someMethod {
    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeController"];
    [self.navigationController pushViewController: myController animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"storyDetailsSegway"]) {
            }
}
- (IBAction)abc:(id)sender {
    NSString* device_token=@"123456";
    NSString* name=txtUser.text;
    NSString* pass=txtPassword.text;
    NSString* email=txtEmail.text;
    
    
    NSString *post = [NSString stringWithFormat:@"device_token=%@&username=%@&email=%@&flag=%d&device_type=%d&password=%@&avatar=%@",device_token,name,email,2,1,pass,@"ss"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/users/userRegister/"]];
    
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (ab==YES) {
        return YES;
    }
    else{
        return NO;
    }
}
@end
