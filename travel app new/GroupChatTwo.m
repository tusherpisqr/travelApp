//
//  GroupChatTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/15/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupChatTwo.h"
#import "cellDetail.h"
#import "cellDetailTwo.h"
@interface GroupChatTwo ()

@end

@implementation GroupChatTwo
@synthesize tableView,txtMessage,btnSend;
- (void)viewDidLoad {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [super viewDidLoad];
    txtMessage.delegate=self;
    NSString* sessionId;
    messages=[[NSMutableArray alloc]init];
    count=0;
    state=1;
    
   NSNumber* groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedGroupID"];
    
    NSString* groupIDstring=[NSString stringWithFormat:@"%lld",[groupId longLongValue]];

    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@",sessionId,groupIDstring];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/message/getMessageFromGroup/"]];
    
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

    // Do any additional setup after loading the view.
}
- (IBAction)sendMessageAction:(id)sender {
    NSString* sessionId;
    
    NSNumber* groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedGroupID"];
    
    NSString* groupIDstring=[NSString stringWithFormat:@"%lld",[groupId longLongValue]];
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    
    NSString* msg=txtMessage.text;
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@&message=%@",sessionId,groupIDstring,msg];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/message/sendMessageToGroup/"]];
    
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -95; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [messages count];
    
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y < 0){
       // NSLog(@"new");
        NSString* sessionId;
        count=1;
        NSNumber* groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedGroupID"];
        
        NSString* groupIDstring=[NSString stringWithFormat:@"%lld",[groupId longLongValue]];
        
        sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
        
        NSString* firstMessageId;
        firstMessageId=[[messages firstObject]valueForKey:@"msgId"];
        
        NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@&first_message_id=%@",sessionId,groupIDstring,firstMessageId];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
        
        [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/message/getPreviousMessageFromGroup/"]];
        
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
    if (velocity.y > 0){
        //old
        NSString* sessionId;
        count=0;
        NSNumber* groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedGroupID"];
        
        NSString* groupIDstring=[NSString stringWithFormat:@"%lld",[groupId longLongValue]];
        
        sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
        
        NSString* lastMessageId;
        lastMessageId=[[messages lastObject]valueForKey:@"msgId"];
        
        NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@&last_message_id=%@",sessionId,groupIDstring,lastMessageId];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
        
        [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/message/getNewAvailableMessageFromGroup/"]];
        
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* ab=[messages objectAtIndex:indexPath.row];
    NSString* avatar=[ab valueForKey:@"avatar"];
    NSString* msg=[ab valueForKey:@"msg"];
    NSString* userId=[ab valueForKey:@"user_id"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:avatar]];
    
    NSString* userID;
    
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
       
    if ([userID  isEqual:userId]) {
        static NSString *simpleTableIdentifier = @"cellDetailTwo";
        
        cellDetailTwo *cell = (cellDetailTwo *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellDetailTwo" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        if ([avatar isEqualToString:@""]) {
            cell.imgView.image=[UIImage imageNamed:@"logo-tours.png"];
        }
        else{
            cell.imgView.image=[UIImage imageWithData:imageData];
        }
        
        cell.title.text=msg;
        cell.titleDetail.text=@"";
        return cell;
        

    }
    else{
        static NSString *simpleTableIdentifier = @"cellDetail";
        
        cellDetail *cell = (cellDetail *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellDetail" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        if ([avatar isEqualToString:@""]) {
            cell.imgView.image=[UIImage imageNamed:@"logo-tours.png"];
        }
        else{
            cell.imgView.image=[UIImage imageWithData:imageData];
        }
        
        cell.title.text=msg;
        cell.titleDetail.text=@"";
        return cell;
        

    }
    
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
        
        if ([[dict objectForKey:@"response"] isKindOfClass:[NSString class]]) {
            NSString* sessionId;
            count=0;
            NSNumber* groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedGroupID"];
            
            NSString* groupIDstring=[NSString stringWithFormat:@"%lld",[groupId longLongValue]];
            
            sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
            
            NSString* lastMessageId;
            lastMessageId=[[messages lastObject]valueForKey:@"msgId"];
            
            NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@&last_message_id=%@",sessionId,groupIDstring,lastMessageId];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            
            NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
            
            [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/message/getNewAvailableMessageFromGroup/"]];
            
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
        else{
            
            NSArray* data=[dict objectForKey:@"response"];
            for (NSDictionary* ab in data) {
                int yes=0;
                for (NSDictionary* ac in messages) {
                    if ([[ac valueForKey:@"msg"]isEqualToString:[ab valueForKey:@"msg"]]) {
                        yes=1;
                    }
                }
                if (yes==0) {
                    if (count==0) {
                        [messages addObject:ab];
                    }
                    if (count==1) {
                        [messages insertObject:ab atIndex:0];
                    }
                    
                }
            }
            
           
      
           
        [self.tableView reloadData];
        }
        
        NSLog(@"success");
    }
    
    
}


@end
