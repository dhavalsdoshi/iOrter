#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@interface MasterViewController : BaseTableViewController
@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
