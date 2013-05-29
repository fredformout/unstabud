//
//  CDao+OutcomeCategory.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CDao+OutcomeCategory.h"

@implementation CDao (OutcomeCategory)

- (NSArray *)allOutcomeCategories
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"OutcomeCategory"
                                   inManagedObjectContext:self.dataContext]];
    
	NSError *error = nil;
	NSArray *result = [self.dataContext executeFetchRequest:fetchRequest error:&error];
    
	if (result == nil)
	{
		NSLog(@"Method <%@> failed: %@", NSStringFromSelector(_cmd), error);
	}
    
	return result;
}

@end
