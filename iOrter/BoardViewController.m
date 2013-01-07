//
//  BoardViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 14/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "BoardViewController.h"
#import "SectionViewController.h"
#import "IdeaboardzService.h"

@interface BoardViewController ()
{
    NSMutableArray *sections;
    Section *selectedSection;
}
@end

@implementation BoardViewController

-(void)setBoardId:(NSInteger)identifier name:(NSString *)name{
    self.board =[[Board alloc] initWithId:identifier name:name];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_boardUrl!=nil) {
    _board = [[Board alloc] initWithUrl:_boardUrl];    
    }
    
    IdeaboardzService *boardservice = [[IdeaboardzService alloc] initWithBoard:_board];
    _board.sections = [boardservice getSections];
    self.title = _board.boardName;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_board.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Sticky *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    NSString *sectionName = [[_board.sections objectAtIndex:indexPath.row] name];
    cell.ideaLabel.text = sectionName;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectedSection = [_board.sections objectAtIndex:indexPath.row];
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)self.colors.count;
    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIndex andLabel:selectedSection.name];
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showIdeas"] ){

        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        selectedSection = [_board.sections objectAtIndex:indexpath.row];
        
        [[segue destinationViewController]setSelectedSection:selectedSection andBoard:_board];
        
    }
}
@end
