//
//  CIncomeScreenViewController.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIncomeScreenViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *incomeValueTextField;
@property (nonatomic, strong) IBOutlet UISwitch *resetBudgetsSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *payOffDebtsSwitch;
@property (nonatomic, strong) IBOutlet UILabel *valueOfDebtsLabel;
@property (nonatomic, strong) IBOutlet UITextField *debtsValueTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameOfIncomeTextField;

- (IBAction)pressDoneAction;
- (IBAction)closeScreen;
- (IBAction)resetBudgetsSwitchValueChangedAction;
- (IBAction)payOffDebtsSwitchValueChangedAction;

@end
