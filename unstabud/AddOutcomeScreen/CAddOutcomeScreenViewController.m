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

@interface CAddOutcomeScreenViewController ()

@end

@implementation CAddOutcomeScreenViewController

@synthesize outcomeCategory = _outcomeCategory;
@synthesize outcomeValueTextField = _outcomeValueTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)pressDoneAction
{
    if (![_outcomeValueTextField.text isEqualToString:@""])
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.dataAccessManager saveDataInForeignContext:^(NSManagedObjectContext *context)
         {
             OutcomeCategory *outcomeCategory = (OutcomeCategory *)[context objectWithID:_outcomeCategory.objectID];
             outcomeCategory.outcome = [NSNumber numberWithDouble:[outcomeCategory.outcome floatValue] + [_outcomeValueTextField.text floatValue]];
             
             CDao *dao = [CDao daoWithContext:context];
             
             CashState *cashState = [dao cashState];
             double result = [cashState.value floatValue] - [_outcomeValueTextField.text floatValue];
             
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

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
