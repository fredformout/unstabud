//
//  CAddCategoryScreenViewController.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CAddCategoryScreenViewController.h"
#import "AppDelegate.h"
#import "OutcomeCategory.h"

@interface CAddCategoryScreenViewController ()

@end

@implementation CAddCategoryScreenViewController

@synthesize nameTextField = _nameTextField;
@synthesize budgetIsDefinedSwitch = _budgetIsDefinedSwitch;
@synthesize valueOfBudgetLabel = _valueOfBudgetLabel;
@synthesize budgetValueTextField = _budgetValueTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)pressDoneAction
{
    if (![_nameTextField.text isEqualToString:@""])
    {
        NSString *text = _nameTextField.text;
        NSString *budgetText = _budgetValueTextField.text;
        BOOL switchValue = _budgetIsDefinedSwitch.on;
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.dataAccessManager saveDataInBackgroundInForeignContext:^(NSManagedObjectContext *context)
        {
            OutcomeCategory *outcomeCategory = [NSEntityDescription insertNewObjectForEntityForName:@"OutcomeCategory" inManagedObjectContext:context];
            outcomeCategory.outcome = [NSNumber numberWithDouble:0.0];
            outcomeCategory.name = [text capitalizedString];
            outcomeCategory.budgetIsDefined = [NSNumber numberWithBool:switchValue];
            
            if ([outcomeCategory.budgetIsDefined boolValue] == YES)
            {
                outcomeCategory.budget = [NSNumber numberWithDouble:[budgetText doubleValue]];
            }
            else
            {
                outcomeCategory.budget = [NSNumber numberWithDouble:0.0];
            }
        }
        completion:^
        {
            [self closeScreen];
        }];
    }
    else
    {
        [self closeScreen];
    }
}

- (IBAction)closeScreen
{
    [self dismissViewControllerAnimated:YES completion:^
     {
         //
     }];
}

- (IBAction)budgetIsDefinedSwitchValueChangedAction
{
    if (_budgetIsDefinedSwitch.on == YES)
    {
        [_valueOfBudgetLabel setHidden:NO];
        [_budgetValueTextField setHidden:NO];
    }
    else
    {
        [_valueOfBudgetLabel setHidden:YES];
        [_budgetValueTextField setHidden:YES];
        [_budgetValueTextField setText:@""];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
