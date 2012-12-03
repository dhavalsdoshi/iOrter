#import <UIKit/UIKit.h>
#import "Model/Section.h"
@interface SectionViewController : UITableViewController<UIActionSheetDelegate>
- (void)setSelectedSection:(Section *)section  andAllSections:(NSMutableArray *)allSections;
-(IBAction)showActionSheet;
@end
