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
    colors = [NSMutableArray array];
    
    [colors addObject:@"stickyBlue.png"];
    [colors addObject:@"stickyGreen.png"];
    [colors addObject:@"stickyYellow.png"];
    [colors addObject:@"stickyOrange.png"];
    
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
    CGSize  textSize = { 260.0, 10000.0 };
    CGSize size = [label sizeWithFont:[UIFont fontWithName:@"Georgia-Italic" size:17.0]
                   constrainedToSize:textSize
                       lineBreakMode:UILineBreakModeWordWrap];
    float padding = 20.0;
    size.width += (padding/2);
    [cell.stickyBg setFrame:CGRectMake(cell.ideaLabel.frame.origin.x - padding/2,
                                       cell.ideaLabel.frame.origin.y - padding/2,
                                       size.width+padding,
                                       size.height+padding)];
    
    NSString *imageName = [colors objectAtIndex:colorIdx];
    UIImage *bgImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 15, 10, 24)];
    cell.stickyBg.image = bgImage;
}


@end
