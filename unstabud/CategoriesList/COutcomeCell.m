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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground"]];
    self.backgroundView = imageView;
}

- (void)revertViewOfValueLabel
{
    if (stateOfValueLabel == WASTE)
    {
        [_valueLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0]];
        
        NSString *resultString = [CStringUtility spacedMoneyString:[NSString stringWithFormat:@"%.0f р.", [_outcomeCategory.budget floatValue] - [_outcomeCategory.outcome floatValue]]];
        [_valueLabel setText:resultString];
        
        stateOfValueLabel = LEFT;
    }
    else
    {
        [self setupWasteStateOfValueLabel];
        
        stateOfValueLabel = WASTE;
    }
}

- (void)setupWasteStateOfValueLabel
{
    NSString *outcomeString = [NSString stringWithFormat:@"%@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.outcome stringValue]]];
    NSString *budgetString =  [NSString stringWithFormat:@"%@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.budget stringValue]]];
    
    [_valueLabel setText:[NSString stringWithFormat:@"%@\n%@", outcomeString, budgetString] afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         NSRange whiteRange = NSMakeRange(0, [outcomeString length]);
         NSRange grayRange = NSMakeRange([outcomeString length] + 1, [budgetString length]);;
         
         [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor whiteColor].CGColor range:whiteRange];
         [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor lightGrayColor].CGColor range:grayRange];
         
         return mutableAttributedString;
     }];
}

- (void)configureCellWithOutcomeCategory:(OutcomeCategory *)outcomeCategory
{
    if (outcomeCategory)
    {
        self.outcomeCategory = outcomeCategory;
        [_nameLabel setText:_outcomeCategory.name];
        [self setupValueLabel];
    }
}

- (void)setupValueLabel
{
    stateOfValueLabel = WASTE;
    
    if ([_outcomeCategory.budgetIsDefined boolValue] == YES)
    {
        [self setupWasteStateOfValueLabel];
        
        [_valueLabel setUserInteractionEnabled:YES];
    }
    else
    {
        [_valueLabel setTextColor:[UIColor whiteColor]];
        
        NSString *resultString = [NSString stringWithFormat:@"%@ р.", [CStringUtility spacedMoneyString:[_outcomeCategory.outcome stringValue]]];
        [_valueLabel setText:resultString];
        
        [_valueLabel setUserInteractionEnabled:NO];
    }
}

@end
