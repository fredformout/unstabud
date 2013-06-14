//
//  COutcomeCell.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutcomeCategory.h"
#import "TTTAttributedLabel.h"

@interface COutcomeCell : UITableViewCell

@property (nonatomic, strong) OutcomeCategory *outcomeCategory;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *valueLabel;

- (void)configureCellWithOutcomeCategory:(OutcomeCategory *)outcomeCategory;

@end
