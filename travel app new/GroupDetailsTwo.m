//
//  GroupDetailsTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/7/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "GroupDetailsTwo.h"

@implementation GroupDetailsTwo

@synthesize gmapView,btnJoin;

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

}
@end
