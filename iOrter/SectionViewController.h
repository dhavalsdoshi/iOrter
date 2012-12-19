#import <UIKit/UIKit.h>
#import "Model/Section.h"
#import "FPPopoverController.h"
#import "ContributeIdeaViewController.h"
#import "BaseTableViewController.h"
#import "Board.h"


@interface SectionViewController : BaseTableViewController<FPPopoverControllerDelegate>{
    FPPopoverController *popover;
    NSMutableArray *sections;
}
@property(nonatomic, retain) IBOutlet UIButton *sectionsButton;
@property(nonatomic, retain) NSMutableArray *sections;

@property(nonatomic, retain) IBOutlet UILabel *sectionTitle;
@property(nonatomic, retain) IBOutlet UIView *titleView;
@property (nonatomic,strong) Board *board;

-(void)setSelectedSection:(Section *)section  andAllSections:(NSMutableArray *)allSections;


-(IBAction)showPopOver:(id)sender;
-(void)selectedTableRow:(NSUInteger)rowNum;
@end
