//
//  CCategoriesListViewController.m
//  unstabud
//
//  Created by fredformout on 29.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CCategoriesListViewController.h"

@interface CCategoriesListViewController ()

@end

@implementation CCategoriesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CommandMaster sharedInstance] addButtons:@[
//     [CommandButton createButtonWithImage:[UIImage imageNamed:@"saveIcon"] andTitle:@"save" andMenuListItems:@[@"menu item 1", @"menu item 2", @"menu item 3"]],
     [CommandButton createButtonWithImage:[UIImage imageNamed:@"addIncomeButton"] andTitle:@"Добавить Доход"],
     [CommandButton createButtonWithImage:[UIImage imageNamed:@"addOutcomeCategoryButton"] andTitle:@"Добавить Категорию"],
     [CommandButton createButtonWithImage:[UIImage imageNamed:@"settingsButton"] andTitle:@"Настройки"]]
                                      forGroup:@"TestGroup"];
    
    [[CommandMaster sharedInstance] addToView:self.view andLoadGroup:@"TestGroup"];
    [CommandMaster sharedInstance].delegate = self;
}

- (void)didSelectMenuListItemAtIndex:(NSInteger)index ForButton:(CommandButton *)selectedButton
{
    //
}

- (void)didSelectButton:(CommandButton *)selectedButton
{
    if ([selectedButton.title isEqualToString:@"Добавить Доход"])
    {
        [self performSegueWithIdentifier:@"SegueToIncomeScreen" sender:nil];
    }
    else if ([selectedButton.title isEqualToString:@"Добавить Категорию"])
    {
        [self performSegueWithIdentifier:@"SegueToAddCategoryScreen" sender:nil];
    }
    else if ([selectedButton.title isEqualToString:@"Настройки"])
    {
        
    }
}

@end
