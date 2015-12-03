//
//  CreateGroupTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "CreateGroupTwo.h"


@implementation CreateGroupTwo

@synthesize txtDate,txtGroupName,txtMemberNumber,tableView,addRow;

-(void)viewDidLoad{
    num=0;
    [addRow addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [[self tableView] setEditing:YES animated:YES];
    recipes = [[NSMutableArray alloc]init];
 
    
 
    txtGroupName.delegate=self;
    txtDate.delegate=self;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self adjustHeightOfTableview];
}



- (void)adjustHeightOfTableview
{
    CGFloat height = self.tableView.contentSize.height;
    CGFloat oldHeight=self.tableView.frame.size.height;
    CGFloat maxHeight = self.tableView.superview.frame.size.height - self.tableView.frame.origin.y-300;
    
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
    [txtGroupName becomeFirstResponder];
    
}

// Prints out the month and year displaying on the calendar
-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
    NSLog(@"%02/%i",month,year);
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
       
    return NO;
}
-(void)add{
    
    newView = [[UIView alloc] initWithFrame:self.view.bounds];
    newView.backgroundColor=[UIColor grayColor];
    CGRect frame=CGRectMake(0, 100, newView.frame.size.width, 50);
    _textFie=[[UITextField alloc]initWithFrame:frame];
    _textFie = [[UITextField alloc]initWithFrame:CGRectMake(0, 67
                                                            , newView.frame.size.width, 50)];
    _textFie.borderStyle = UITextBorderStyleNone;
    _textFie.backgroundColor = [UIColor whiteColor];
    [newView addSubview:_textFie];
    
    _autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:_textFie
                                                         usingSource:[[TRGoogleMapsAutocompleteItemsSource alloc] initWithMinimumCharactersToTrigger:2 apiKey:@"AIzaSyD0gbTbmU7DyoIdCWwJqQR_m1apZZtUBNo"]
                                                         cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc] initWithCellForegroundColor:[UIColor lightGrayColor] fontSize:14]
                                                        presentingIn:self];
    
    
    
    _autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        NSLog(@"Autocompleted with: %@", item.completionText);
        [recipes addObject:item.completionText];
        
        [tableView reloadData];
        [self adjustHeightOfTableview];
        [newView removeFromSuperview];
    };

    [self.view addSubview:newView];
    
       
    
}


- (IBAction)addGroupAction:(id)sender {
    
    NSString* device_token=@"123456";
    
    NSString *aValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_id"];
   
   
    
    NSString* session_id=@"241702411";
   
    CLLocationCoordinate2D center;
    center=[self getLocationFromAddressString:@"Chittagong"];
    double  latFrom=center.latitude;
    double  lonFrom=center.longitude;
    
    NSString *post = [NSString stringWithFormat:@"session_id=%@&longitude=%f&latitude=%f&zoom=%d",session_id,lonFrom,latFrom,10];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc] init] ;
    
    [requestT setURL:[NSURL URLWithString:@"http://travel.cityu.me/travelgroups/addGroup/"]];
    
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

    
    
    for (NSString* name in recipes) {
        CLLocationCoordinate2D center;
        center=[self getLocationFromAddressString:name];
        double  latFrom=center.latitude;
        double  lonFrom=center.longitude;
        
        NSLog(@"View Controller get Location Logitute : %f",latFrom);
        NSLog(@"View Controller get Location Latitute : %f",lonFrom);
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
    
    
   
    
    }


@end
