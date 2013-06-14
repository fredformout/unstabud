//
//  CashMove.h
//  unstabud
//
//  Created by fredformout on 14.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OutcomeCategory;

@interface CashMove : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * isOutcome;
@property (nonatomic, retain) NSNumber * mood;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nameOfCategory;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) OutcomeCategory *outcomeCategory;

@end
