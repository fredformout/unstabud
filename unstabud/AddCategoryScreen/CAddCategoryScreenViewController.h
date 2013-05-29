//
//  CAddCategoryScreenViewController.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAddCategoryScreenViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UISwitch *budgetIsDefinedSwitch;
@property (nonatomic, strong) IBOutlet UILabel *valueOfBudgetLabel;
@property (nonatomic, strong) IBOutlet UITextField *budgetValueTextField;

- (IBAction)pressDoneAction;
- (IBAction)closeScreen;
- (IBAction)budgetIsDefinedSwitchValueChangedAction;

@end
