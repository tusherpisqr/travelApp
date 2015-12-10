//
//  GroupListTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/8/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupListTwo.h"
#import "GroupDetailsTwo.h"
#import "cellDetail.h"

@implementation GroupListTwo

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil]; // ios 6
}


-(void)viewDidLoad{
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    groupCounts= [[NSArray alloc]  init];
    
    NSString* sessionId;
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // or you have the previous 'None' style...
    
    
    
    
    
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
    
    return [groupCounts count];

}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cellDetail";
    
    cellDetail *cell = (cellDetail *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellDetail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
   
    
        NSDictionary* ab=[groupCounts objectAtIndex:indexPath.row];
        
        NSString* theUrl=[ab valueForKey:@"create_by_avatar"];
        
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:theUrl]];
        
        cell.imgView.image=[UIImage imageWithData:imageData];
        
        NSString* titleText=[ab valueForKey:@"title"];
        cell.title.text = titleText;
        
        NSString* userName=[ab valueForKey:@"create_by_username"];
        cell.titleDetail.text=userName;
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
   
   
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
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
       // GroupDetailsTwo *vc = [segue destinationViewController];
        //[vc setIsHidden:@"No"];
        
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
