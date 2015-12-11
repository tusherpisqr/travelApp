//
//  NotificationPage.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/10/15.
//  Copyright © 2015 tusher. All rights reserved.
//


#import "NotificationPage.h"
#import "cellDetail.h"
#import "CustomTableViewCell.h"


@interface NotificationPage ()

@end

@implementation NotificationPage

@synthesize tableViewGroups,tableViewNotifications;

-(void)viewWillAppear:(BOOL)animated{
    notificationCounts=[[NSMutableArray alloc]init];
    groupCounts=[[NSMutableArray alloc]init];
    
    tableViewNotifications.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewGroups.separatorStyle=UITableViewCellSeparatorStyleNone;
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    second=0;
    
    NSString* sessionId;
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/getNotificationBySessionId/"]];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag==0) {
       return [notificationCounts count];
    }
    else{
       return [groupCounts count];
    }
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    
    if (cell==nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (tableView.tag==0) {
        
        
        NSDictionary* a=[notificationCounts objectAtIndex:indexPath.row];
        
        NSString *invite_by=[a valueForKey:@"invite_by"];
        long invite=[invite_by longLongValue];
        
        NSString* group_id=[a valueForKey:@"group_id"];
       long groupID=[group_id longLongValue];
        
        long ID=[[a valueForKey:@"id"]longLongValue];
        
        NSString* message=[a valueForKey:@"title"];
        
        long invite_to=[[a valueForKey:@"invite_to"]longLongValue];
        
        NSString* description=[a valueForKey:@"description"];
        
        long type=[[a valueForKey:@"type"]longLongValue];
        
        NSString* icon=[a valueForKey:@"icon"];
        
        // Add utility buttons
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSNumber* iD=[NSNumber numberWithInt:indexPath.row];
        [leftUtilityButtons addObject:iD];
         iD=[NSNumber numberWithLong:ID];
        [leftUtilityButtons addObject:iD];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
         NSMutableArray *rightUtilityButtonsTwo = [NSMutableArray new];
        
        
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                    title:@"Accept"];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Reject"];
        [rightUtilityButtonsTwo sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Okey"];
        
        
        if(type==1||type==2){
        cell.leftUtilityButtons = leftUtilityButtons;
        cell.rightUtilityButtons = rightUtilityButtons;
        cell.delegate = self;
        }
        if (type==3) {
            cell.rightUtilityButtons = rightUtilityButtonsTwo;
            cell.delegate = self;
        }
        cell.textLabel.text=message;
        
        

    }
    if (tableView.tag==1) {
        
        NSDictionary* a=[groupCounts objectAtIndex:indexPath.row];
        
        NSString* avater=[a valueForKey:@"avatar"];
        
        long group_id=[[a valueForKey:@"group_id"]longLongValue];
        
        NSString* title=[a valueForKey:@"title"];
        
        NSString* dateTime=[a valueForKey:@"date"];
        
        NSString* userName=[a valueForKey:@"username"];
        
        long user_id=[[a valueForKey:@"user_id"]longLongValue];
        
        long msg_id=[[a valueForKey:@"msgid"]longLongValue];
        
        NSString* message=[a valueForKey:@"msg"];

      cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=message;
    }
    
    return cell;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSArray* abc=cell.leftUtilityButtons;
            
            
            selectedID=[abc[0] longLongValue];
            NSString* sessionId;
            
            sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
            
            NSString* notification_ID=[NSString stringWithFormat:@"%@",abc[1]];
            
             NSString* flag=@"1";
            
            NSString *post = [NSString stringWithFormat:@"session_id=%@&notification_id=%@&flag=%@",sessionId,notification_ID,flag];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            
            NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
            
            [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/approvalGroupRequestByNotificationId"]];
            
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

            
            break;
        }
        case 1:
        {
            [notificationCounts removeObjectAtIndex:selectedID];
            [tableViewNotifications reloadData];
            NSString* sessionId;
            
            sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
            
            NSString* notification_ID=[NSString stringWithFormat:@"%ld",selectedNotificationID];
            
            NSString* flag=@"2";
            
            NSString *post = [NSString stringWithFormat:@"session_id=%@&notification_id=%@&flag=%@",sessionId,notification_ID,flag];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            
            NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
            
            [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/approvalGroupRequestByNotificationId"]];
            
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
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag==0) {
        
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
    
    second++;
    
    
    if ([code isEqualToString: @"100"] && second==1) {
        
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
    
    
    if([code isEqualToString: @"200"] &&second==1){
        
        
        
        NSDictionary* output=[dict objectForKey:@"response"];
       notificationCounts=[[NSMutableArray alloc ]initWithArray:[output valueForKey:@"notification"]];
        groupCounts=[[NSMutableArray alloc ]initWithArray:[output valueForKey:@"groups"]];
        
        [tableViewGroups reloadData];
        [tableViewNotifications reloadData];

        
        NSLog(@"success");
    }
    if (second>1) {
        [notificationCounts removeObjectAtIndex:(int)selectedID];
        [tableViewNotifications reloadData];

    }
}



@end
