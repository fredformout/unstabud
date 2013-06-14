//
//  CAddOutcomeScreenViewController.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CAddOutcomeScreenViewController.h"
#import "AppDelegate.h"
#import "CDao+CashState.h"
#import "CashMove.h"

@interface CAddOutcomeScreenViewController ()

@end

@implementation CAddOutcomeScreenViewController

@synthesize outcomeCategory = _outcomeCategory;
@synthesize outcomeValueTextField = _outcomeValueTextField;
@synthesize nameOfOutcomeTextField = _nameOfOutcomeTextField;
@synthesize moodSegmentedControl = _moodSegmentedControl;

- (IBAction)pressDoneAction
{
    if (![_outcomeValueTextField.text isEqualToString:@""])
    {
        NSString *text = _outcomeValueTextField.text;
        NSString *nameOfOutcomeText = _nameOfOutcomeTextField.text;
        int selectedMood = _moodSegmentedControl.selectedSegmentIndex;
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.dataAccessManager saveDataInBackgroundInForeignContext:^(NSManagedObjectContext *context)
         {
             OutcomeCategory *outcomeCategory = (OutcomeCategory *)[context objectWithID:_outcomeCategory.objectID];
             outcomeCategory.outcome = [NSNumber numberWithDouble:[outcomeCategory.outcome floatValue] + [text floatValue]];
             
             CDao *dao = [CDao daoWithContext:context];
             
             CashState *cashState = [dao cashState];
             double result = [cashState.value floatValue] - [text floatValue];
             
             cashState.value = [NSNumber numberWithDouble:result];
             
             CashMove *cashMove = [NSEntityDescription insertNewObjectForEntityForName:@"CashMove" inManagedObjectContext:context];
             if (![nameOfOutcomeText isEqualToString:@""])
             {
                 cashMove.name = [nameOfOutcomeText capitalizedString];
             }
             else
             {
                 cashMove.name = @"Без комментариев";
             }
             cashMove.date = [NSDate date];
             cashMove.mood = [NSNumber numberWithInt:selectedMood];
             cashMove.value = [NSNumber numberWithDouble:[text doubleValue]];
             cashMove.isOutcome = [NSNumber numberWithBool:YES];
             cashMove.outcomeCategory = outcomeCategory;
             cashMove.nameOfCategory = cashMove.outcomeCategory.name;
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

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
