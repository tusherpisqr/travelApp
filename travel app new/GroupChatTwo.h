//
//  GroupChatTwo.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/15/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupChatTwo : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray* messages;
    NSMutableArray* responses;
    NSMutableData* responseData;
    int count;
    int state;
}
@property (strong, nonatomic) IBOutlet UITextField *txtMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat lastContentOffset;

@end
