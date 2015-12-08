//
//  GroupListTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/8/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupListTwo.h"
#import "GroupDetailsTwo.h"

@implementation GroupListTwo

-(void)viewDidLoad{
    groupCounts= [NSArray arrayWithObjects:  nil];
    groupDetails=[NSArray arrayWithObjects: @"Group One", @"Group Two", @"Group Three", nil];
    groupStarts=[NSArray arrayWithObjects: @"20-12-15", @"20-01-15", @"23-12-13", nil];
    
    NSString* sessionId;
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    NSString* groupId;
    
    
    
    
    
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@",sessionId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/getGroupList/"]];
    
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
    
    return [groupCounts count];    //count number of row from counting array hear cataGorry is An Array
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
    
   
    NSDictionary* ab=[groupCounts objectAtIndex:indexPath.row];
    
    NSString* theUrl=[ab valueForKey:@"create_by_avatar"];
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:theUrl]];
    
    cell.imageView.image=[UIImage imageWithData:imageData];
    
     NSString* titleText=[ab valueForKey:@"title"];
    cell.textLabel.text = titleText;
    
     NSString* userName=[ab valueForKey:@"create_by_username"];
    cell.detailTextLabel.text=userName;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSDictionary* ab=[groupCounts objectAtIndex:indexPath.row];
    
    
    NSString* group_id=(NSString*)[ab objectForKey:@"group_id"];

    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    
    [prefs2 setObject:group_id forKey:@"group_id"];
    
    
  
    
    [prefs2 synchronize];

    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetails"])
    {
        GroupDetailsTwo *vc = [segue destinationViewController];
        
        
        //        [vc setLongitude:[NSNumber numberWithDouble:longitude]];
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
       
        
        
        groupCounts=[dict objectForKey:@"response"];
        
        [self.tableView reloadData];
        
        NSLog(@"success");
    }
}


@end
