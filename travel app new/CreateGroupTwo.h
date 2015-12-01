//
//  CreateGroupTwo.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateGroupTwo : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    int num;
    NSMutableArray *recipes;
}
@property (weak, nonatomic) IBOutlet UITextField *txtGroupName;
@property (weak, nonatomic) IBOutlet UITextField *txtMemberNumber;
@property (weak, nonatomic) IBOutlet UIButton *addRow;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;

- (IBAction)action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
