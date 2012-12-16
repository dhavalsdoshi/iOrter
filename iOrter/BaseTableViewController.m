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
    
    [self.colors addObject:[UIColor cyanColor]];
    [self.colors addObject:[UIColor greenColor]];
    [self.colors addObject:[UIColor yellowColor]];
    [self.colors addObject:[UIColor blueColor]];
    
    self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma mark - Table view delegate

- (void)styleStickyCell:(Sticky *)cell withColorIdx:(NSInteger)colorIdx andLabel:(NSString *)label {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.ideaLabel.font = [UIFont fontWithName:@"Georgia-Italic" size:17.0];
    cell.ideaLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.ideaLabel.numberOfLines = 0;
    cell.ideaLabel.backgroundColor = [UIColor clearColor];

    CGFloat cornerRadius = 4;
    cell.ideaView.backgroundColor = [UIColor redColor];
    cell.ideaView.layer.cornerRadius = cornerRadius;
    cell.ideaView.clipsToBounds = YES;
    [[cell.ideaView layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [[cell.ideaView layer] setBorderWidth:0];

    cell.ideaView.layer.masksToBounds = NO;
    cell.ideaView.layer.shadowOffset = CGSizeMake(-4, 6);
    cell.ideaView.layer.shadowRadius = cornerRadius;
    cell.ideaView.layer.shadowOpacity = 0.5;
    cell.ideaView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.ideaView.bounds cornerRadius:cornerRadius].CGPath;
    cell.ideaView.backgroundColor = [self.colors objectAtIndex:colorIdx];

}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Rotate cell at random angle betwee +2 and -2 degrees
//    int i = (arc4random()%2)+(-2);
//    float rotation = i/100.0;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.2];
//    CGAffineTransform rr=CGAffineTransformMakeRotation(rotation);
//    cell.transform=CGAffineTransformConcat(cell.transform, rr);
//    [UIView commitAnimations];
}

@end
