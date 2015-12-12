//
//  Logout.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/11/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "Logout.h"

@interface Logout ()

@end

@implementation Logout

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* userName;
    
    userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    _lblUserName.text=userName;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)abc:(id)sender {
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    
    [prefs2 setObject:@"" forKey:@"username"];
    
    [prefs2 setObject:@"" forKey:@"session_id"];
    
    [prefs2 setObject:@"" forKey:@"pass"];
    
    [prefs2 setObject:@"" forKey:@"email"];
    
    
    [prefs2 synchronize];
}

@end
