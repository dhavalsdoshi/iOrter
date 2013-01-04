#import <UIKit/UIKit.h>
#import "Model/Section.h"
#import "FPPopoverController.h"
#import "IdeaEditorViewController.h"
#import "BaseTableViewController.h"
#import "Board.h"
#import "Idea.h"


@interface SectionViewController : BaseTableViewController<FPPopoverControllerDelegate>{
    FPPopoverController *popover;
    NSMutableArray *sections;
}
@property(nonatomic, retain) IBOutlet UIButton *sectionsButton;
@property(nonatomic, retain) NSMutableArray *sections;
@property(nonatomic, retain) IBOutlet UILabel *sectionTitle;
@property(nonatomic, retain) IBOutlet UIView *titleView;
@property (nonatomic,strong) Board *board;
@property (nonatomic) Idea *selectedIdea;


- (void)setSelectedSection:(Section *)section  andBoard:(Board *)boardObject;
-(IBAction)showPopOver:(id)sender;
-(void)selectedTableRow:(NSUInteger)rowNum;
@end
