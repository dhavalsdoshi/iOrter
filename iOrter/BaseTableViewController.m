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
    
    [self.colors addObject:[UIColor greenColor]];
    [self.colors addObject:[UIColor cyanColor]];
    [self.colors addObject:[UIColor yellowColor]];
    [self.colors addObject:[self colorWithHexString:@"EE10FF"]];
    [self.colors addObject:[self colorWithHexString:@"4499EE"]];
    [self.colors addObject:[UIColor orangeColor]];
    
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

    [self addShadow:cell.ideaView];
    cell.ideaView.backgroundColor = [self.colors objectAtIndex:colorIdx];
}

- (void) addShadow:(UIView *)viewToStyle
{
    CGFloat cornerRadius = 4;
    viewToStyle.layer.cornerRadius = cornerRadius;
    viewToStyle.clipsToBounds = YES;
    [[viewToStyle layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [[viewToStyle layer] setBorderWidth:0];

    viewToStyle.layer.masksToBounds = NO;
    viewToStyle.layer.shadowOffset = CGSizeMake(-4, 6);
    viewToStyle.layer.shadowRadius = cornerRadius;
    viewToStyle.layer.shadowOpacity = 0.5;
    viewToStyle.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:viewToStyle.bounds cornerRadius:cornerRadius].CGPath;
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
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
