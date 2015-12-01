//
//  homeSearch.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/28/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "homeSearchTwo.h"

@implementation homeSearchTwo
@synthesize gmapView,tb,searchBar;
-(void)viewDidLoad{
    NSLog(@"abc");
    // Do any additional setup after loading the view.
    camera = [GMSCameraPosition cameraWithLatitude:-32.8683
                                                            longitude:151.2086
                                                                 zoom:10];
    mapView = [GMSMapView mapWithFrame:gmapView.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    
    
    
    [gmapView addSubview:mapView];
    
//    NSString *str=@"https://github.com/David-Haim/CountriesToCitiesJSON/blob/master/countriesToCities.json";
//    NSURL *url=[NSURL URLWithString:str];
//    NSData *data=[NSData dataWithContentsOfURL:url];
//    NSError *error=nil;
//    id response=[NSJSONSerialization JSONObjectWithData:data options:
//                 NSJSONReadingMutableContainers error:&error];
//    
//    NSLog(@"Your JSON Object: %@ Or Error is: %@", response, error);
//    
//    NSError* e;
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:nil error:&e];
//    
    
  

    

     recipes = [NSMutableArray arrayWithObjects:@"Dhaka",@"Chittagong",@"Dahagram",  nil];
    tb = [[UITableView alloc] initWithFrame:CGRectMake(0,55,414,115) style:UITableViewStylePlain] ;
    
    tb.dataSource = self;
    tb.delegate = self;
    searchBar.delegate=self;
    //[self.view addSubview:tb];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView  {
    
    tableView.frame = self.tb.frame;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [recipes count];
        
    }
}
//Table one : Table name: Add group Table Fields: Group Name, Number of members, Dates, LocationID
//Table two:LocationID, location order, latitude, longitude, zoom

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    }
    
    return cell;
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

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    controller.active = YES;
    
    
}



- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    controller.active=NO;
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
       
    }
    
}


@end
