//
//  OutcomeCategory.h
//  unstabud
//
//  Created by fredformout on 08.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OutcomeCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * budget;
@property (nonatomic, retain) NSNumber * budgetIsDefined;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * outcome;
@property (nonatomic, retain) NSSet *outcomes;
@end

@interface OutcomeCategory (CoreDataGeneratedAccessors)

- (void)addOutcomesObject:(NSManagedObject *)value;
- (void)removeOutcomesObject:(NSManagedObject *)value;
- (void)addOutcomes:(NSSet *)values;
- (void)removeOutcomes:(NSSet *)values;

@end
