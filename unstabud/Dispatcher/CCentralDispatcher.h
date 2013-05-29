//
//  CCentralDispatcher.h
//  rfpi_calls
//
//  Created by fredformout on 15.02.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCentralDispatcher : NSObject

@property (nonatomic, readonly) dispatch_queue_t dataUpdateQueue;
@property (nonatomic, readonly) dispatch_queue_t dataSavingQueue;

@end
