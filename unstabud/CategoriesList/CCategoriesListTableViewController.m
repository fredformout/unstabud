//
//  CCategoriesListTableViewController.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CCategoriesListTableViewController.h"
#import "COutcomeCell.h"
#import "AppDelegate.h"
#import "CDao+CashState.h"
#import "CDao+OutcomeCategory.h"
#import "CStringUtility.h"
#import "CAddOutcomeScreenViewController.h"

@interface CCategoriesListTableViewController () {
    NSFetchedResultsController *_fetchedResultsController;
}

@end

@implementation CCategoriesListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CDao *dao = [CDao daoWithContext:delegate.dataAccessManager.managedObjectContext];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@ р.",[CStringUtility spacedMoneyString:[[dao cashState].value stringValue]]]];
    [self reloadTable];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"SegueToAddOutcomeScreen"])
    {
        UINavigationController *temp = segue.destinationViewController;
        CAddOutcomeScreenViewController *destination = [temp.viewControllers objectAtIndex:0];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        destination.outcomeCategory = [self.fetchedResultsController objectAtIndexPath:path];
    }
}

- (void)reloadDataSource
{
    _fetchedResultsController = nil;
}

- (void)reloadTable
{
    [self reloadDataSource];
    [self.tableView reloadData];
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
    static NSString *CellIdentifier = @"OutcomeCell";
    COutcomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell configureCellWithOutcomeCategory:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 22.0)];
    [view setBackgroundColor:[UIColor blackColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appBackground"]];
    [imageView setFrame:view.frame];
    [view addSubview:imageView];
    
    NSString *textForLabel;
    
    OutcomeCategory *outcomeCategory = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    if ([outcomeCategory.budgetIsDefined boolValue] == YES)
    {
        textForLabel = @"Мои Бюджеты";
    }
    else
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        CDao *dao = [CDao daoWithContext:delegate.dataAccessManager.managedObjectContext];
        CashState *cashState = [dao cashState];
        
        double budgetForOthers = [cashState.value floatValue];
        
        NSArray *outcomeCategories = [dao allOutcomeCategories];
        
        for (OutcomeCategory *outcomeCategory in outcomeCategories)
        {
            if ([outcomeCategory.budgetIsDefined boolValue] == YES)
            {
                budgetForOthers -= [outcomeCategory.budget floatValue] - [outcomeCategory.outcome floatValue];
            }
        }
        
        textForLabel = [NSString stringWithFormat:@"Осталось %@ р.", [CStringUtility spacedMoneyString:[NSString stringWithFormat:@"%.0f", budgetForOthers]]];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, tableView.frame.size.width, 22.0)];
    [view addSubview:label];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [label setText:textForLabel];
    
    return view;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        [delegate.dataAccessManager saveState];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Удалить";
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil)
    {
        AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"OutcomeCategory"];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"budgetIsDefined" ascending:YES];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, sortDescriptor2, nil]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:@"budgetIsDefined" cacheName:nil];
        
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
