//
//  BaseTableViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 10/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "BaseTableViewController.h"


@implementation BaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.colors = [NSMutableArray array];
    
    [self.colors addObject:@"stickyBlue.png"];
    [self.colors addObject:@"stickyGreen.png"];
    [self.colors addObject:@"stickyYellow.png"];
    [self.colors addObject:@"stickyOrange.png"];
    
    self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    return [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
}


#pragma mark - Table view delegate

- (void)styleStickyCell:(Sticky *)cell withColorIdx:(NSInteger)colorIdx andLabel:(NSString *)label {
    CGFloat cornerRadius = 2;
    cell.layer.cornerRadius = cornerRadius;
    cell.clipsToBounds = YES;
    [[cell layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [[cell layer] setBorderWidth:1.50];

    cell.layer.masksToBounds = NO;
    cell.layer.shadowOffset = CGSizeMake(-4, 6);
    cell.layer.shadowRadius = cornerRadius;
    cell.layer.shadowOpacity = 0.5;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cornerRadius].CGPath;

}


@end
