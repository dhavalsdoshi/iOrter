//
//  IdeaCell.m
//  iOrter
//
//  Created by Nikita Deshmukh on 06/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "Sticky.h"

@implementation Sticky
@synthesize ideaView;
@synthesize ideaLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
