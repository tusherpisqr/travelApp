//
//  GroupDetailsTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/7/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupDetailsTwo.h"

@implementation GroupDetailsTwo

@synthesize gmapView,btnJoin,startDate,lblMapStartDate;

-(void)viewDidLoad{
    
    double a=-32.8683;
    double b=151.2086;
    camera = [GMSCameraPosition cameraWithLatitude:a
                                         longitude:b
                                              zoom:10];
    mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    
    
   // [j]
    
    [gmapView addSubview:mapView];
    [btnJoin setHidden:YES];
    if (startDate!=nil) {
        lblMapStartDate.text=startDate;
    }
    
    NSString* sessionId;
    
     sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    NSString* groupId;
    
     groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"group_id"];
    
   
    
   
    
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@",sessionId,groupId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/groupDetailsByGroupId/"]];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [members count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:MyIdentifier] ;
    }
    
    
    NSDictionary* ab=[members objectAtIndex:indexPath.row];
    
    
    
    NSString* userName=[NSString stringWithFormat:@"member Name: %@",[ab valueForKey:@"username"]];
    cell.textLabel.text = userName;
    
    NSString* userId=[NSString stringWithFormat:@"member Id: %@",[ab valueForKey:@"user_id"]];
    cell.detailTextLabel.text=userId;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
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
        NSDictionary *dict2=(NSDictionary*)[dict objectForKey:@"response"];
        
        NSString* travelDate=(NSString*)[dict2 objectForKey:@"travel_date"];
        
        
        
        NSArray* location=[dict2 objectForKey:@"location_list"];
        
        members=[dict2 objectForKey:@"group_members"];
        
        [tableView reloadData];
        
        lblMapStartDate.text=travelDate;
       
        
        
        
                NSLog(@"success");
    }
}

@end
