//
//  GroupDetailsTwo.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/7/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface GroupDetailsTwo : UIViewController{
    GMSMapView* mapView;
    NSMutableArray *recipes;
    NSMutableArray *searchResults;
    GMSCameraPosition* camera;
    GMSPlacesClient* client;
}

@property (weak, nonatomic) IBOutlet UIView *gmapView;
@property (weak, nonatomic) IBOutlet UIButton *btnJoin;


@end
