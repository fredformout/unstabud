//
//  Created by Alexey Rogatkin on 23.10.12.
//  
//


#import <Foundation/Foundation.h>
#import "IStateHolderObserver.h"

@interface CStateHolder : NSObject

- (void)addObserver:(id <IStateHolderObserver>)observer;

- (void)removeObserver:(id <IStateHolderObserver>)observer;

@end