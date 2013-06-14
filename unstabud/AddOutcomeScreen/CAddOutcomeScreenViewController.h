//
//  CAddOutcomeScreenViewController.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutcomeCategory.h"

@interface CAddOutcomeScreenViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) OutcomeCategory *outcomeCategory;
@property (nonatomic, strong) IBOutlet UITextField *outcomeValueTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameOfOutcomeTextField;
@property (nonatomic, strong) IBOutlet UISegmentedControl *moodSegmentedControl;

- (IBAction)pressDoneAction;
- (IBAction)closeScreen;

@end
