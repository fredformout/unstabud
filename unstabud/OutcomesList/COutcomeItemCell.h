//
//  COutcomeItemCell.h
//  unstabud
//
//  Created by fredformout on 14.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashMove.h"

static CGFloat HEIGHT_OF_CLOSED_CELL = 44.0;

@interface COutcomeItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *cashMoveValueLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *moodImageView;

- (void)configureCellWithOutcomeItem:(CashMove *)outcomeItem;
- (NSNumber *)heightForFullCell;

@end
