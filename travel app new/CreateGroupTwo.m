//
//  CreateGroupTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "CreateGroupTwo.h"
#import "homeSearchTwo.h"

@implementation CreateGroupTwo

@synthesize txtDate,txtGroupName,txtMemberNumber,tableView,addRow;

-(void)viewDidLoad{
    [self.navigationItem setHidesBackButton:YES animated:YES];
    num=0;
    [addRow addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [[self tableView] setEditing:YES animated:YES];
    recipes = [[NSMutableArray alloc]init];
 
     ab=NO;
 
    txtGroupName.delegate=self;
    txtDate.delegate=self;
    _textFie.delegate=self;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  //  [self adjustHeightOfTableview];
}



- (void)adjustHeightOfTableview
{
    CGFloat height = self.tableView.contentSize.height;
    CGFloat oldHeight=self.tableView.frame.size.height;
    CGFloat maxHeight = ( lowerView.frame.origin.y- self.tableView.frame.origin.y);
    
    int g=0;
    
    if (height > maxHeight)
    {
        height = maxHeight;
        g=1;
    
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.tableView.frame;
        
        frame.size.height = height;
        self.tableView.frame = frame;
        if(g==0){
            CGRect frameT=lowerView.frame;
            CGFloat y=lowerView.frame.origin.y;
            y+=height-oldHeight;
            frameT.origin.y=y;
            lowerView.frame=frameT;
        }
        
        
    }];
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSInteger sourceRow = sourceIndexPath.row;
    NSInteger destRow = destinationIndexPath.row;
    id object = [recipes objectAtIndex:sourceRow];
    
    [recipes removeObjectAtIndex:sourceRow];
    [recipes insertObject:object atIndex:destRow];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txtDate) {
        [self popCalendar];
    }
}
-(void)popCalendar {
    newView = [[UIView alloc] initWithFrame:self.view.bounds];
    newView.backgroundColor=[UIColor grayColor];
    calendar = [[SACalendar alloc]initWithFrame:CGRectMake(0, 100, newView.frame.size.width, 400)];
    
    calendar.delegate = self;
    
    [newView addSubview:calendar];
    [self.view addSubview:newView];
}

// Prints out the selected date
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString* date=[NSString stringWithFormat:@"%d/%d/%d", day,month,year];
   
    txtDate.text=date;
    
    [self->newView removeFromSuperview];
   [self.view endEditing:YES];
    
}

// Prints out the month and year displaying on the calendar
-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
       
    return NO;
}
-(void)add{
    
    newView = [[UIView alloc] initWithFrame:self.view.bounds];
    newView.center=self.view.center;
    newView.backgroundColor=[UIColor whiteColor];
    CGRect frame=CGRectMake(100, 100, newView.frame.size.width, 50);
    _textFie=[[UITextField alloc]initWithFrame:frame];
    _textFie = [[UITextField alloc]initWithFrame:CGRectMake(0, 67
                                                            , newView.frame.size.width, 50)];
    _textFie.borderStyle = UITextBorderStyleRoundedRect;
    _textFie.backgroundColor = [UIColor whiteColor];
    _textFie.placeholder=@"Search cities";
    [_textFie becomeFirstResponder];
    [newView addSubview:_textFie];
    
    _autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:_textFie
                                                         usingSource:[[TRGoogleMapsAutocompleteItemsSource alloc] initWithMinimumCharactersToTrigger:2 apiKey:@"AIzaSyBbzjhDtPMh6z0h1LqqijxifTEsEXMbaTw"]
                                                         cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc] initWithCellForegroundColor:[UIColor lightGrayColor] fontSize:14]
                                                        presentingIn:self];
    
    
    
    _autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        NSLog(@"Autocompleted with: %@", item.completionText);
        [recipes addObject:item.completionText];
        
        [tableView reloadData];
        [self adjustHeightOfTableview];
        
        [newView removeFromSuperview];
        newView=nil;
    };

    [self.view addSubview:newView];
}


- (IBAction)addGroupAction:(id)sender {
    

    
    NSString *aValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
   
   
    
    NSString* session_id=aValue;
   
    
   
    
    NSMutableArray *order_by=[[NSMutableArray alloc] init];
    NSMutableArray *lats=[[NSMutableArray alloc]init];
    NSMutableArray *longs=[[NSMutableArray alloc]init];
    NSMutableArray *zoom=[[NSMutableArray alloc]init];
    NSMutableArray *places=[[NSMutableArray alloc]init];
    NSMutableArray *country_name=[[NSMutableArray alloc]init];
    
    NSString* group_name=txtGroupName.text;
    
    NSString* descr=txtGroupName.text;
    NSString* date=txtDate.text;
    NSString* groupmember=txtMemberNumber.text;
    
    if (group_name.length>0&&descr.length>0&&date.length>0&&groupmember.length>0) {
        NSString *kpost = [NSString stringWithFormat:@"session_id=%@&title=%@&description=%@&travel_date=%@&member_limit=%@",session_id,group_name,descr,date,groupmember];
        
        NSMutableString *post=[[NSMutableString alloc]initWithString:kpost];
        
        int orderby=1;
        
        for (NSString* name in recipes) {
            CLLocationCoordinate2D center;
            center=[self getLocationFromAddressString:name];
            double  latFrom=center.latitude;
            double  lonFrom=center.longitude;
            
            NSLog(@"View Controller get Location Logitute : %f",latFrom);
            NSLog(@"View Controller get Location Latitute : %f",lonFrom);
            
            //        NSString *kposttwo = [NSString stringWithFormat:@"order_by[]=%@&longitude[]=%@&latitude[]=%@&zoom[]=%@",[NSNumber numberWithInt:orderby],[NSNumber numberWithDouble:latFrom],[NSNumber numberWithDouble:lonFrom],[NSNumber numberWithInt:10]];
            //
            //        [post appendString:kposttwo];
            
            NSMutableString* country=[[NSMutableString alloc]initWithString:name];
            
            NSRange ab=[name rangeOfString:@"," options:NSBackwardsSearch];
            int abc=ab.location;
            
            country=[country substringFromIndex:abc+2];
            [country_name addObject:country];
            [places addObject:name];
            [order_by addObject:[NSNumber numberWithInt:orderby]];
            [lats addObject:[NSNumber numberWithDouble:latFrom]];
            [longs addObject:[NSNumber numberWithDouble:lonFrom]];
            [zoom addObject:[NSNumber numberWithInt:10]];
            orderby++;
        }
        
        int i=0;
        for (NSString* order in order_by) {
            NSString *kposttwo = [NSString stringWithFormat:@"&place_id[%d]=%@&country[%d]=%@&location_name[%d]=%@&order_by[%d]=%@&longitude[%d]=%@&latitude[%d]=%@&zoom[%d]=%@",i,@"abc",i,country_name[i],i,places[i],i,order_by[i],i,lats[i],i,longs[i],i,zoom[i]];
            
            [post appendString:kposttwo];
            i++;
            
        }
        
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
        
        [requestT setURL:[NSURL URLWithString:@"http://travelapp.cityu.me/travelgroups/addGroup/"]];
        
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
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Please insert group name, date and member number"
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
    
    
    

}

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}

- (IBAction)action:(UIStepper *)sender {
    double value = [sender value];
    
    [txtMemberNumber setText:[NSString stringWithFormat:@"%d", (int)value]];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [recipes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        [self adjustHeightOfTableview];
       

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [recipes count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"ss"] ;
    }
    
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    return cell;
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
        
        NSString* group_id=(NSString*)[dict2 objectForKey:@"id"];
        
      
        
       
        
        NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
        
        [prefs2 setObject:group_id forKey:@"group_id"];
        
        
        ab=YES;
        
        [prefs2 synchronize];
        
      
        
        [self performSegueWithIdentifier:@"showGroup" sender:self];
        NSLog(@"success");
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showGroup"])
    {
            
        
        
    }
}

@end
