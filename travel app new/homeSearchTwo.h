//
//  homeSearch.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/28/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAutocompleteView.h"
@import GoogleMaps;

@interface homeSearchTwo : UIViewController<UITextFieldDelegate>{
    GMSMapView* mapView;
    NSMutableArray *recipes;
    NSMutableArray *searchResults;
    GMSCameraPosition* camera;
    GMSPlacesClient* client;
    TRAutocompleteView *_autocompleteView;
    
}
@property (weak, nonatomic) IBOutlet UIView *gmapView;

@property (strong, nonatomic) NSNumber *latitude;

@property (strong, nonatomic) NSNumber *longitude;

@property (strong, nonatomic) NSString *locationString;

@property (weak, nonatomic) IBOutlet UITextField *textFie;


@end
