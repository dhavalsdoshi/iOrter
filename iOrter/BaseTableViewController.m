//
//  BaseTableViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 10/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController()
{
     MBProgressHUD *hud;
}
@end

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
    
    [self.colors addObject:[self colorWithHexString:@"C3EE8F"]];
    [self.colors addObject:[self colorWithHexString:@"CCFFFF"]];
    [self.colors addObject:[self colorWithHexString:@"FFFF88"]];
    [self.colors addObject:[self colorWithHexString:@"EED2FE"]];
    [self.colors addObject:[self colorWithHexString:@"DCFFE0"]];
    [self.colors addObject:[self colorWithHexString:@"FFC690"]];
    
    self.tableView.separatorColor = [UIColor clearColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

#pragma mark - Table view delegate

- (void)styleStickyCell:(Sticky *)cell withColorIdx:(NSInteger)colorIdx andLabel:(NSString *)label {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.ideaLabel.font = [UIFont fontWithName:@"Handwritten Crystal V2" size:25.0];
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

- (void) displayMessage: (NSString*) message
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
}

- (void) displayProgressMessage: (NSString*) message
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
}

- (void) clearProgressMessage {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Handwritten Crystal V2" size:(24.0)];
//        titleView.font = [UIFont boldSystemFontOfSize:17];
        titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        titleView.lineBreakMode = UILineBreakModeMiddleTruncation;
        titleView.textColor = [UIColor whiteColor];
        UITapGestureRecognizer *navSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationTitleTapped)];
        navSingleTap.numberOfTapsRequired = 1;

        [titleView setUserInteractionEnabled:YES];
        [titleView addGestureRecognizer:navSingleTap];

        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

-(void)navigationTitleTapped
{

}


@end
