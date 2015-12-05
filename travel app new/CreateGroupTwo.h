//
//  CreateGroupTwo.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SACalendar.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TRAutocompleteView.h"
#import "TRGoogleMapsAutocompleteItemsSource.h"
#import "TRGoogleMapsAutocompletionCellFactory.h"
@import GoogleMaps;


@interface CreateGroupTwo : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SACalendarDelegate,UIAlertViewDelegate,GMSMapViewDelegate>
{
    int num;
    NSMutableArray *recipes;
    SACalendar *calendar;
    UIView* newView;
    NSMutableData* responseData;
    __weak IBOutlet UIView *lowerView;
    TRAutocompleteView *_autocompleteView;
    BOOL ab;
}

@property ( nonatomic)  UITextField *textFie;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupName;
@property (weak, nonatomic) IBOutlet UITextField *txtMemberNumber;
@property (weak, nonatomic) IBOutlet UIButton *addRow;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
- (IBAction)addGroupAction:(id)sender;

- (IBAction)action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
