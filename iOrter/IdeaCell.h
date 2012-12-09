//
//  IdeaCell.h
//  iOrter
//
//  Created by Nikita Deshmukh on 06/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdeaCell : UITableViewCell
@property (nonatomic) IBOutlet UIView *ideaView;
@property (nonatomic) IBOutlet UILabel *ideaLabel;
@property (nonatomic) IBOutlet UIImageView *stickyBg;
@end
