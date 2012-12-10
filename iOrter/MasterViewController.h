#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController
@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
