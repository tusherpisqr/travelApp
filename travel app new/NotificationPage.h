//
//  NotificationPage.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/10/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface NotificationPage : UIViewController<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>{
    NSMutableArray* notificationCounts;
    NSMutableArray* groupCounts;
    NSMutableData* responseData;
    long selectedID;
    long selectedNotificationID;
    NSMutableArray* dicts;
    long second;
}
@property (strong, nonatomic) IBOutlet UITableView *tableViewNotifications;
@property (strong, nonatomic) IBOutlet UITableView *tableViewGroups;



@end
