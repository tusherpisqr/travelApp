//
//  GroupDetailsTwo.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/7/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface GroupDetailsTwo : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    GMSMapView* mapView;
    NSMutableArray *recipes;
    NSMutableArray *searchResults;
    GMSCameraPosition* camera;
    GMSPlacesClient* client;
    NSMutableData* responseData;
    NSArray* members;
    BOOL isAdmin;
    int group_status;
    NSString* group_avatar;
    
    IBOutlet UITableView *tableView;
}

@property (weak, nonatomic) IBOutlet UIView *gmapView;
@property (weak, nonatomic) IBOutlet UIButton *btnJoin;
@property (strong, nonatomic) IBOutlet UILabel *lblMapStartDate;
@property(strong) NSString* isHidden;
@property (strong, nonatomic) IBOutlet UILabel *lblRequestPending;
@property (strong, nonatomic) IBOutlet UIButton *btnCancelRequest;
@property (strong, nonatomic) IBOutlet UILabel *lblChatNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblShareNumber;

@end
