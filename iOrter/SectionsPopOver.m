//
//  SectionsPopOver.m
//  iOrter
//
//  Created by Rajdeep Kwatra on 09/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "SectionsPopOver.h"
#import "SectionViewController.h"
#import "Section.h"

@interface SectionsPopOver ()

@end

@implementation SectionsPopOver
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Sections";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate.board.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    Section *section = [self.delegate.board.sections objectAtIndex:indexPath.row];
    NSString *text = section.name;
    cell.textLabel.font = [UIFont fontWithName:@"Delius" size:18.0];
    cell.textLabel.text = text;

    return cell;

}
#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(selectedTableRow:)])
    {
        [self.delegate selectedTableRow:indexPath.row];
    }
}

@end
