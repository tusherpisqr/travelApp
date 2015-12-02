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

@interface CreateGroupTwo : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SACalendarDelegate,UIAlertViewDelegate>
{
    int num;
    NSMutableArray *recipes;
    SACalendar *calendar;
    UIView* newView;
    NSMutableData* responseData;
    __weak IBOutlet UIView *lowerView;
}
@property (weak, nonatomic) IBOutlet UITextField *txtGroupName;
@property (weak, nonatomic) IBOutlet UITextField *txtMemberNumber;
@property (weak, nonatomic) IBOutlet UIButton *addRow;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
- (IBAction)addGroupAction:(id)sender;

- (IBAction)action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
