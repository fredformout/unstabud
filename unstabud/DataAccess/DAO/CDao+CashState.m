//
//  CDao+CashState.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CDao+CashState.h"

@implementation CDao (CashState)

- (CashState *)cashState
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"CashState"
                                   inManagedObjectContext:self.dataContext]];
    
	NSError *error = nil;
	NSArray *result = [self.dataContext executeFetchRequest:fetchRequest error:&error];
    
	if (result == nil)
	{
		NSLog(@"Method <%@> failed: %@", NSStringFromSelector(_cmd), error);
	}
    else if ([result count] > 0)
    {
        return [result objectAtIndex:0];
    }
    
    return nil;
}

@end
