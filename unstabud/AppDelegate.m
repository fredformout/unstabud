//
//  AppDelegate.m
//  unstabud
//
//  Created by fredformout on 22.05.13.
//  Copyright (c) 2013 iDecide. All rights reserved.
//

#import "AppDelegate.h"
#import "CDao+CashState.h"

@implementation AppDelegate

@synthesize dataAccessManager = _dataAccessManager;
@synthesize dispatcher = _dispatcher;
@synthesize stateHolder = _stateHolder;

- (void)checkCashState
{
    CDao *dao = [CDao daoWithContext:_dataAccessManager.managedObjectContext];
    CashState *cashState = [dao cashState];
    
    if (cashState == nil)
    {
        [self createCashState];
    }
}

- (void)customizeUI
{
    [[UINavigationBar appearance]
     setBackgroundImage:[UIImage imageNamed:@"navBackground"]
     forBarMetrics:UIBarMetricsDefault];
}

- (void)createCashState
{
    [_dataAccessManager saveDataInForeignContext:^(NSManagedObjectContext *context)
    {
        CashState *cashState = [NSEntityDescription insertNewObjectForEntityForName:@"CashState" inManagedObjectContext:context];
        cashState.value = [NSNumber numberWithDouble:0.0];
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dispatcher = [[CCentralDispatcher alloc] init];
    _dataAccessManager = [[CDataAccessManager alloc] init];
    [_dataAccessManager.persistentStoreCoordinator class];
    _stateHolder = [[CStateHolder alloc] init];
    
    [self customizeUI];
    [self checkCashState];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
