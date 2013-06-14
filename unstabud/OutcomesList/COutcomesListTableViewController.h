//
//  COutcomesListTableViewController.h
//  unstabud
//
//  Created by fredformout on 14.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OutcomeCategory.h"

@interface COutcomesListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) OutcomeCategory *outcomeCategory;
@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@end
