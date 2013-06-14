//
//  Period.h
//  unstabud
//
//  Created by fredformout on 08.06.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Period : NSManagedObject

@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSDate * end;

@end
