//
//  CCentralDispatcher.m
//  rfpi_calls
//
//  Created by fredformout on 15.02.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "CCentralDispatcher.h"

@implementation CCentralDispatcher

@synthesize dataUpdateQueue = _dataUpdateQueue;
@synthesize dataSavingQueue = _dataSavingQueue;

- (id)init {
    self = [super init];
    if (self) {
        _dataSavingQueue = dispatch_queue_create("ru.idecide.rfpi_calls.save", NULL);
        _dataUpdateQueue = dispatch_queue_create("ru.idecide.rfpi_calls.update", NULL);
    }
    return self;
}

@end
