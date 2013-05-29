//
//  AppDelegate.h
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDataAccessManager.h"
#import "CCentralDispatcher.h"
#import "CStateHolder.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) CDataAccessManager *dataAccessManager;
@property (nonatomic, readonly) CCentralDispatcher *dispatcher;
@property (nonatomic, readonly) CStateHolder *stateHolder;

@end
