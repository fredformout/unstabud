//
//  OutcomeCategory.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OutcomeCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * budget;
@property (nonatomic, retain) NSNumber * outcome;
@property (nonatomic, retain) NSNumber * budgetIsDefined;

@end
