//
//  CreateGroupTwo.m
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/30/15.
//  Copyright © 2015 tusher. All rights reserved.
//

#import "CreateGroupTwo.h"

@implementation CreateGroupTwo

@synthesize txtDate,txtGroupName,txtMemberNumber,tableView,addRow;

-(void)viewDidLoad{
    num=0;
    [addRow addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [[self tableView] setEditing:YES animated:YES];
    recipes = [NSMutableArray arrayWithObjects:@"Dhaka",@"Chittagong",@"Dahagram",  nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];


}

-(void)dismissKeyboard {
    [txtDate resignFirstResponder];
    [txtGroupName resignFirstResponder];
    [txtMemberNumber resignFirstResponder];
}


-(void)add{
    num++;
    [tableView reloadData];
}

- (IBAction)action:(UIStepper *)sender {
    double value = [sender value];
    
    [txtMemberNumber setText:[NSString stringWithFormat:@"%d", (int)value]];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        num--;
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
       

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return num;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"ss"] ;
    }
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    //set the position of the button
//    button.frame = CGRectMake(cell.frame.origin.x + cell.frame.size.width -20, cell.frame.origin.y + 20, 20, 30);
//    [button setTitle:@"X" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(customActionPressed) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor= [UIColor clearColor];
//    [cell.contentView addSubview:button];
    
    cell.textLabel.text = @"My Text";
    return cell;
}

-(void)customActionPressed{
    
}

@end
