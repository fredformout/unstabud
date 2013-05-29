//
//  CIncomeScreenViewController.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CIncomeScreenViewController.h"
#import "AppDelegate.h"
#import "CDao+CashState.h"
#import "CDao+OutcomeCategory.h"

@interface CIncomeScreenViewController ()

@end

@implementation CIncomeScreenViewController

@synthesize incomeValueTextField = _incomeValueTextField;
@synthesize resetBudgetsSwitch = _resetBudgetsSwitch;
@synthesize payOffDebtsSwitch = _payOffDebtsSwitch;
@synthesize valueOfDebtsLabel = _valueOfDebtsLabel;
@synthesize debtsValueTextField = _debtsValueTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)pressDoneAction
{
    if (![_incomeValueTextField.text isEqualToString:@""])
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if (_resetBudgetsSwitch.on == YES)
        {
            [delegate.dataAccessManager saveDataInForeignContext:^(NSManagedObjectContext *context)
            {
                CDao *dao = [CDao daoWithContext:context];
                NSArray *outcomeCategories = [dao allOutcomeCategories];
                
                for (OutcomeCategory *outcomeCategory in outcomeCategories)
                {
                    outcomeCategory.outcome = [NSNumber numberWithDouble:0.0];
                }
            }];
        }
        
        [delegate.dataAccessManager saveDataInForeignContext:^(NSManagedObjectContext *context)
         {
             CDao *dao = [CDao daoWithContext:context];
             CashState *cashState = [dao cashState];
             
             double result = [cashState.value doubleValue] + [_incomeValueTextField.text doubleValue] - [_debtsValueTextField.text doubleValue];
             
             cashState.value = [NSNumber numberWithDouble:result];
         }];
    }
    
    [self closeScreen];
}

- (IBAction)closeScreen
{
    [self dismissViewControllerAnimated:YES completion:^
     {
         //
     }];
}

- (IBAction)resetBudgetsSwitchValueChangedAction
{
    //
}

- (IBAction)payOffDebtsSwitchValueChangedAction
{
    if (_payOffDebtsSwitch.on == YES)
    {
        [_valueOfDebtsLabel setHidden:NO];
        [_debtsValueTextField setHidden:NO];
    }
    else
    {
        [_valueOfDebtsLabel setHidden:YES];
        [_debtsValueTextField setHidden:YES];
        [_debtsValueTextField setText:@""];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
