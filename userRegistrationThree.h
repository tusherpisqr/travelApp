//
//  userRegistrationThree.h
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userRegistrationThree : UIViewController{
    NSMutableData* responseData;
    BOOL ab;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end
