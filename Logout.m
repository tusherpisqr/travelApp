//
//  Logout.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/11/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "Logout.h"
#import "userRegistrationThree.h"

@interface Logout ()

@end

@implementation Logout

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* userName;
    
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString* email;
    
    email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    _lblUserName.text=userName;
    _lblEmail.text=email;
    ab=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)abc:(id)sender {
    NSString* sessionId;
    NSString* device_token=@"123456";
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
   
    NSString *post = [NSString stringWithFormat:@"device_token=%@&session_id=%@",device_token,sessionId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/users/userLogOut/"]];
    
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
    
    
    
    if ([code isEqualToString: @"100"]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Validation Error"
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
        
        
        NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
        
        [prefs2 setObject:@"" forKey:@"username"];
        
        [prefs2 setObject:@"" forKey:@"session_id"];
        
        [prefs2 setObject:@"" forKey:@"pass"];
        
        [prefs2 setObject:@"" forKey:@"email"];
        
        
        [prefs2 synchronize];
        
        
        ab=YES;
        [self performSegueWithIdentifier:@"logout" sender:self];

        
        NSLog(@"success");
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if (ab==NO) {
        return NO;
    }
    else return YES;
    
}
@end
