//
//  homeSearch.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/28/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface homeSearchTwo : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>{
    GMSMapView* mapView;
    NSMutableArray *recipes;
    NSMutableArray *searchResults;
    GMSCameraPosition* camera;
}
@property (weak, nonatomic) IBOutlet UIView *gmapView;

@property (nonatomic, strong) UITableView *tb;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
