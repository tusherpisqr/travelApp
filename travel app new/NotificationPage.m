//
//  NotificationPage.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 12/10/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "NotificationPage.h"
#import "cellDetail.h"

@interface NotificationPage ()

@end

@implementation NotificationPage

@synthesize tableViewGroups,tableViewNotifications;

-(void)viewWillAppear:(BOOL)animated{
    notificationCounts=[[NSMutableArray alloc]init];
    groupCounts=[[NSMutableArray alloc]init];
    [notificationCounts addObject:@"f wants to join your group"];
    [notificationCounts addObject:@"g wants to join your group"];
    [groupCounts addObject:@"group a"];
    [groupCounts addObject:@"group b"];
    tableViewNotifications.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableViewGroups.separatorStyle=UITableViewCellSeparatorStyleNone;
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag==0) {
       return [notificationCounts count];
    }
    else{
       return [groupCounts count];
    }
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES or NO
    if (tableView.tag==0) {
        return(YES);
    }
    else{
        return NO;
    }
   
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag==0) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [notificationCounts removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            NSLog(@"Unhandled editing style! %d", editingStyle);
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"cellDetail";
    
    cellDetail *cell = (cellDetail *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellDetail" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if (tableView.tag==0) {
        
    }
    else{
      cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
}



@end
