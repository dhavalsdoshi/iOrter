#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
# import "BoardRepository.h"
@interface MasterViewController : BaseTableViewController <UIAlertViewDelegate>
@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, strong) BoardRepository *boardRepository;
@end
