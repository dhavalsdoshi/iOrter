#import <UIKit/UIKit.h>
#import "Model/Section.h"
#import "FPPopoverController.h"
#import "ContributeIdeaViewController.h"
#import "BaseTableViewController.h"


@interface SectionViewController : BaseTableViewController<FPPopoverControllerDelegate>{
    FPPopoverController *popover;
    NSMutableArray *sections;
}
@property(nonatomic, retain) IBOutlet UIButton *sectionsButton;
@property(nonatomic, retain) NSMutableArray *sections;

-(void)setSelectedSection:(Section *)section  andAllSections:(NSMutableArray *)allSections;

-(IBAction)showPopOver:(id)sender;
-(void)selectedTableRow:(NSUInteger)rowNum;
@end
