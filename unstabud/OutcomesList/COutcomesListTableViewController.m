//
//  COutcomesListTableViewController.m
//  unstabud
//
//  Created by fredformout on 14.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "COutcomesListTableViewController.h"
#import "COutcomeItemCell.h"
#import "AppDelegate.h"

@interface COutcomesListTableViewController () {
    NSFetchedResultsController *_fetchedResultsController;
}

@end

@implementation COutcomesListTableViewController
{
    NSIndexPath *indexPathOfSelected;
    CGFloat rowHeight;
    CGFloat rowHeightForSelected;
}

@synthesize outcomeCategory = _outcomeCategory;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rowHeight = HEIGHT_OF_CLOSED_CELL;
    rowHeightForSelected = HEIGHT_OF_CLOSED_CELL;
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"appBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile]]];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setTitle:_outcomeCategory.name];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger)section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OutcomeItemCell";
    COutcomeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell configureCellWithOutcomeItem:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == indexPathOfSelected.row)
    {
        return rowHeightForSelected;
    }
    else
    {
        return rowHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == indexPathOfSelected.row && rowHeightForSelected != rowHeight)
    {
        rowHeightForSelected = HEIGHT_OF_CLOSED_CELL;
    }
    else
    {
        indexPathOfSelected = indexPath;
        
        COutcomeItemCell *cell = (COutcomeItemCell *)[tableView cellForRowAtIndexPath:indexPath];
        rowHeightForSelected = [[cell heightForFullCell] floatValue];
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil)
    {
        AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CashMove"];
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"outcomeCategory == %@ AND isOutcome == %@", _outcomeCategory, [NSNumber numberWithBool:YES]]];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        BOOL success = [_fetchedResultsController performFetch:&error];
        if (!success)
        {
            NSLog(@"Can't fetch indicators data: %@", [error userInfo]);
        }
    }
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate behavior

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type)
    {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
            
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
