//
//  COutcomeItemCell.m
//  unstabud
//
//  Created by fredformout on 14.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "COutcomeItemCell.h"
#import "CStringUtility.h"

static CGFloat PADDING = 10.0;

@implementation COutcomeItemCell

@synthesize nameLabel = _nameLabel;
@synthesize cashMoveValueLabel = _cashMoveValueLabel;
@synthesize dateLabel = _dateLabel;
@synthesize moodImageView = _moodImageView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground"]];
    self.backgroundView = imageView;
}

- (void)configureCellWithOutcomeItem:(CashMove *)outcomeItem
{
    [_nameLabel setText:outcomeItem.name];
    [_cashMoveValueLabel setText:[NSString stringWithFormat:@"%@ р.", [CStringUtility spacedMoneyString:[outcomeItem.value stringValue]]]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm dd.MM.yyyy"];
    [_dateLabel setText:[dateFormatter stringFromDate:outcomeItem.date]];
    
    NSString *imageName;
    switch ([outcomeItem.mood intValue])
    {
        case 0:
            imageName = @"sadMood";
            break;
        case 1:
            imageName = @"noMood";
            break;
        case 2:
            imageName = @"happyMood";
            break;
        default:
            break;
    }
    [_moodImageView setImage:[UIImage imageNamed:imageName]];
}

- (NSNumber *)heightForFullCell
{
    CGSize sizeOfLabel = [_nameLabel.text sizeWithFont:_nameLabel.font constrainedToSize:CGSizeMake(_nameLabel.frame.size.width, MAXFLOAT) lineBreakMode:_nameLabel.lineBreakMode];
    
    CGFloat result = sizeOfLabel.height + 2 * PADDING;
    
    if (result < HEIGHT_OF_CLOSED_CELL)
    {
        return [NSNumber numberWithFloat:HEIGHT_OF_CLOSED_CELL];
    }
    else
    {
        return [NSNumber numberWithFloat:result];
    }
}
    
@end
