//
//  BoardViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 14/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardRepository.h"
#import "SectionViewController.h"
@interface BoardViewController ()
{
    NSMutableArray *sections;
    Section *selectedSection;
}
@end

@implementation BoardViewController
@synthesize boardName, boardUrl;

-(void) setBoardname:(NSString *)boardName{
    self.boardName = boardName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    SectionService *sectionService = [[SectionService alloc] init];
    BoardService *boardservice = [[BoardService alloc] initWithSectionService:sectionService];
    BoardRepository *boardRepository = [[BoardRepository alloc] initWithBoardService:boardservice andSectionService:sectionService];
    sections = [boardRepository getSectionsForBoard:self.boardUrl];
    boardName = [boardUrl substringFromIndex:1];
    boardName = [boardName stringByDeletingLastPathComponent];
    self.title = boardName;
    
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
    return [sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Sticky *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    NSString *sectionName = [[sections objectAtIndex:indexPath.row] name];
    cell.ideaLabel.text = sectionName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectedSection = [sections objectAtIndex:indexPath.row];
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)self.colors.count;
    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIndex andLabel:selectedSection.name];
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showIdeas"] ){

        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        selectedSection = [sections objectAtIndex:indexpath.row];
        
        [[segue destinationViewController]setSelectedSection:selectedSection andAllSections:sections];
        
    }
}
@end