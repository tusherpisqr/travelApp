//
//  NotificationPage.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/10/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationPage : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray* notificationCounts;
    NSMutableArray* groupCounts;
}
@property (strong, nonatomic) IBOutlet UITableView *tableViewNotifications;
@property (strong, nonatomic) IBOutlet UITableView *tableViewGroups;

@end
