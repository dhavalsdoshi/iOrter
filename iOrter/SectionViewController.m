//
//  DetailViewController.m
//  iOrter
//
//  Created by Akshay Mankar on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "SectionViewController.h"
#import "Service/SectionService.h"
@interface SectionViewController ()
- (void)configureView;
@end

@implementation SectionViewController
{
    NSMutableArray *sections;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
    sections = [[[SectionService alloc] init] getSectionsForBoard:@"abcd"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Section" forIndexPath:indexPath];
    if(cell == Nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Section"];
    cell.textLabel.text = [[sections objectAtIndex:[indexPath row]] name];
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sections.count;
}

@end
