//
//  DSCTableViewCell.m
//  DynamicSizedCells
//
//  Created by Ankur Oberoi on 9/9/13.
//  Copyright (c) 2013 Ankur Oberoi. All rights reserved.
//

#import "DSCTableViewCell.h"

@implementation DSCTableViewCell

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
