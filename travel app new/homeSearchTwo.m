//
//  homeSearch.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/28/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "homeSearchTwo.h"
#import "TRGoogleMapsAutocompleteItemsSource.h"
#import "TRGoogleMapsAutocompletionCellFactory.h"

@implementation homeSearchTwo
@synthesize gmapView,textFie;
-(void)viewDidLoad{
    NSLog(@"abc");
    // Do any additional setup after loading the view.
    camera = [GMSCameraPosition cameraWithLatitude:-32.8683
                                                            longitude:151.2086
                                                                 zoom:10];
    mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    
    
    
    [gmapView addSubview:mapView];
    
    _autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:textFie
                                                         usingSource:[[TRGoogleMapsAutocompleteItemsSource alloc] initWithMinimumCharactersToTrigger:2 apiKey:@"AIzaSyD0gbTbmU7DyoIdCWwJqQR_m1apZZtUBNo"]
                                                         cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc] initWithCellForegroundColor:[UIColor lightGrayColor] fontSize:14]
                                                        presentingIn:self];
  

    

     recipes = [NSMutableArray arrayWithObjects:@"Dhaka",@"Chittagong",@"Dahagram",  nil];
    
   _autocompleteView.topMargin = -5;
    
    
    _autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        NSLog(@"Autocompleted with: %@", item.completionText);
        [self getLocationFromAddressString:item.completionText];
    };
    
    //[self.view addSubview:tb];
}

//Table one : Table name: Add group Table Fields: Group Name, Number of members, Dates, LocationID
//Table two:LocationID, location order, latitude, longitude, zoom

-(void) getLocationFromAddressString: (NSString*) addressStr {
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
    
    [mapView removeFromSuperview];
    camera = [GMSCameraPosition cameraWithLatitude:latitude
                                         longitude:longitude
                                              zoom:10];
    mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    
    
    
    [gmapView addSubview:mapView];
    
  
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        NSString* txt=[searchResults objectAtIndex:indexPath.row];
        if ([txt isEqualToString:@"Dhaka"]) {
            
            [mapView removeFromSuperview];
            camera = [GMSCameraPosition cameraWithLatitude:23.810332
                                                 longitude:90.412518
                                                      zoom:10];
            mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
            mapView.myLocationEnabled = YES;
            
            
            
            [gmapView addSubview:mapView];
            self.searchDisplayController.active=NO;
            
        }
        if ([txt isEqualToString:@"Chittagong"]) {
            [mapView removeFromSuperview];
            camera = [GMSCameraPosition cameraWithLatitude:22.347537
                                                 longitude:91.812332
                                                      zoom:10];
            mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
            mapView.myLocationEnabled = YES;
            
            
            
            [gmapView addSubview:mapView];
            self.searchDisplayController.active=NO;
            
        }
        if ([txt isEqualToString:@"Dahagram"]) {
            [mapView removeFromSuperview];
            camera = [GMSCameraPosition cameraWithLatitude:26.303381
                                                 longitude:88.946175
                                                      zoom:10];
            mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
            mapView.myLocationEnabled = YES;
            
            
            
            [gmapView addSubview:mapView];
            self.searchDisplayController.active=NO;
            
        }
        
        
    }
}








@end
