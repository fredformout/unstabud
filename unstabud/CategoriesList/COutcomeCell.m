//
//  COutcomeCell.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "COutcomeCell.h"
#import "CStringUtility.h"

@implementation COutcomeCell

@synthesize outcomeCategory = _outcomeCategory;
@synthesize nameLabel = _nameLabel;
@synthesize valueLabel = _valueLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(revertViewOfValueLabel)];
    [_valueLabel addGestureRecognizer:tapGestureRecognizer];
}

- (void)revertViewOfValueLabel
{
    NSArray *components = [_valueLabel.text componentsSeparatedByString:@"/"];
    if ([components count] == 2)
    {
        NSString *resultString = [NSString stringWithFormat:@"%.0f р.", [_outcomeCategory.budget floatValue] - [_outcomeCategory.outcome floatValue]];
        [_valueLabel setText:[CStringUtility spacedMoneyString:resultString]];
        [_valueLabel setTextColor:[UIColor greenColor]];
    }
    else
    {
        [_valueLabel setText:[NSString stringWithFormat:@"%@ р. / %@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.outcome stringValue]], [CStringUtility spacedMoneyString:[_outcomeCategory.budget stringValue]]]];
        [_valueLabel setTextColor:[UIColor redColor]];
    }
}

- (void)configureCellWithOutcomeCategory:(OutcomeCategory *)outcomeCategory
{
    if (outcomeCategory)
    {
        self.outcomeCategory = outcomeCategory;
        
        [_nameLabel setText:_outcomeCategory.name];
        
        if ([_outcomeCategory.budgetIsDefined boolValue] == YES)
        {
            [_valueLabel setText:[NSString stringWithFormat:@"%@ р. / %@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.outcome stringValue]], [CStringUtility spacedMoneyString:[_outcomeCategory.budget stringValue]]]];
            [_valueLabel setUserInteractionEnabled:YES];
        }
        else
        {
            [_valueLabel setText:[NSString stringWithFormat:@"%@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.outcome stringValue]]]];
            [_valueLabel setUserInteractionEnabled:NO];
        }
        
        [_valueLabel setTextColor:[UIColor redColor]];
    }
}

@end
