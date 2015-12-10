//
//  GroupDetailsTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/7/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupDetailsTwo.h"
#import "cellDetail.h"

@implementation GroupDetailsTwo

@synthesize gmapView,btnJoin,isHidden,lblMapStartDate,btnCancelRequest,lblRequestPending,lblChatNumber,lblShareNumber;

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
    self.navigationItem.hidesBackButton=NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    dictiorneries=[[NSMutableArray alloc]init];
    double a=-32.8683;
    double b=151.2086;
    [btnJoin setHidden:YES];
    [btnCancelRequest setHidden:YES ];
    [lblRequestPending setHidden:YES];
    camera = [GMSCameraPosition cameraWithLatitude:a
                                         longitude:b
                                              zoom:10];
    mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
    
    mapView.myLocationEnabled = YES;
    
    tableView.allowsSelection=NO;
   
    
    [gmapView addSubview:mapView];
       if ([isHidden isEqualToString:@"Yes"]) {
        [
         btnJoin setHidden:YES];    }
    if ([isHidden isEqualToString:@"No"]) {
        [
         btnJoin setHidden:NO];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // or you have
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
    static NSString *simpleTableIdentifier = @"cellDetail";
    
    cellDetail *cell = (cellDetail *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellDetail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    
    
    
    NSString* theUrl=group_avatar;
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:theUrl]];
    
    cell.imgView.image=[UIImage imageWithData:imageData];

    
    NSDictionary* ab=[members objectAtIndex:indexPath.row];
    
    
    
    
    NSString* userName=[NSString stringWithFormat:@"member Name: %@",[ab valueForKey:@"username"]];
    cell.title.text = userName;
    
    NSString* userId=[NSString stringWithFormat:@"member Id: %@",[ab valueForKey:@"user_id"]];
    cell.titleDetail.text=userId;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
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
    
    
    
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&e];
    
    [dictiorneries addObject:dict];
    NSDictionary* meta=[dict objectForKey:@"meta"];
    
    NSString* code=(NSString*)[[meta objectForKey:@"status"]stringValue];
   int p=1;
    if ([dictiorneries count]==2) {
        if ([code isEqualToString: @"200"]) {
            [btnCancelRequest setHidden:NO];
                      [btnJoin setHidden:YES];
                        [lblRequestPending setHidden:NO];
            p=2;
        }
    }
    
    
    if ([dictiorneries count]==3) {
        if ([code isEqualToString: @"200"]) {
            [btnCancelRequest setHidden:YES];
            [btnJoin setHidden:NO];
            [lblRequestPending setHidden:YES];
            p=3;
        }
    }
    

    if ([code isEqualToString: @"100"]&&[dictiorneries count]==1) {
        
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
    
    
    if([code isEqualToString: @"200"]&&[dictiorneries count]==1){

        
        NSDictionary *dict2=(NSDictionary*)[dict objectForKey:@"response"];
        

        
        
        NSString* travelDate=(NSString*)[dict2 objectForKey:@"travel_date"];
        
        NSString* shareNum=(NSString*)[dict2 objectForKey:@"no_of_share"];
        
        NSString* status=(NSString*)[dict2 objectForKey:@"group_status"];
        group_status=(int)[status longLongValue];
        
        NSString* Admin=(NSString*)[dict2 objectForKey:@"is_admin"];
        int ad=(int)[Admin longLongValue];
        
        if (ad==0) {
            isAdmin=NO;
        }
        else{
            isAdmin=YES;
        }
        group_avatar=(NSString*)[dict2 objectForKey:@"admin_avatar"];
        
        NSString* noOfChat=(NSString*)[dict2 objectForKey:@"no_of_chat"];
        
        
        NSArray* location=[dict2 objectForKey:@"location_list"];
        
        members=[dict2 objectForKey:@"group_members"];
        
        [tableView reloadData];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *orignalDate   =  [dateFormatter dateFromString:travelDate];
        
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSString *finalString = [dateFormatter stringFromDate:orignalDate];
        
        lblMapStartDate.text=finalString;
        lblChatNumber.text=[NSString stringWithFormat:@"%@",noOfChat];
        lblShareNumber.text=[NSString stringWithFormat:@"%@",shareNum];;
        
        if (isAdmin==NO) {
            if (group_status==0) {
                [btnJoin setHidden:NO];
            }
            if (group_status==2) {
                [btnCancelRequest setHidden:NO];
                [lblRequestPending setHidden:NO];
            }
        }
        
//        [mapView removeFromSuperview];
//       
//        GMSCameraPosition *cameraPosition=[GMSCameraPosition cameraWithLatitude:18.5203 longitude:73.8567 zoom:12];
//        mapView =[GMSMapView mapWithFrame:gmapView.bounds camera:cameraPosition];
//       
//        mapView.myLocationEnabled=YES;
//         [gmapView addSubview:mapView];
//        GMSMarker *marker=[[GMSMarker alloc]init];
//        marker.position=CLLocationCoordinate2DMake(18.5203, 73.8567);
//        marker.icon=[UIImage imageNamed:@"aaa.png"] ;
//        marker.groundAnchor=CGPointMake(0.5,0.5);
//        marker.map=mapView;
//        GMSMutablePath *path = [GMSMutablePath path];
//        [path addCoordinate:CLLocationCoordinate2DMake(@(18.520).doubleValue,@(73.856).doubleValue)];
//        [path addCoordinate:CLLocationCoordinate2DMake(@(18.7).doubleValue,@(73.856).doubleValue)];
//        
//        GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//        rectangle.strokeWidth = 2.f;
//        rectangle.map = mapView;
        
        
        
                NSLog(@"success");
    }
    
    if (p==3) {
        [dictiorneries removeObjectAtIndex:1];
        [dictiorneries removeObjectAtIndex:1];
    }
}

- (IBAction)joinGroup:(id)sender {
    NSString* sessionId;
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    NSString* groupId;
    
    groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"group_id"];
    
    
    
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicator.alpha = 1.0;
//    [self.view addSubview:activityIndicator];
//    activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
//    [activityIndicator startAnimating];//to start animating

    
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@",sessionId,groupId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/join_to_group/"]];
    
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
- (IBAction)cancelRequest:(id)sender {
    NSString* sessionId;
    
    sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
    NSString* groupId;
    
    groupId = [[NSUserDefaults standardUserDefaults] objectForKey:@"group_id"];
    
     NSString *post = [NSString stringWithFormat:@"session_id=%@&group_id=%@",sessionId,groupId];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/cancelRequest/"]];
    
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




@end
