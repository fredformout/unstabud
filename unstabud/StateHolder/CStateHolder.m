//
//  Created by Alexey Rogatkin on 23.10.12.
//  
//

#import "CStateHolder.h"
#import "CDao.h"
#import "AppDelegate.h"

@interface CStateHolder () {
    NSMutableArray *_observers;
}

- (void)initializeBean;

@end

@implementation CStateHolder


- (void)initializeBean {
    _observers = [[NSMutableArray alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        [self initializeBean];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeBean];
}

- (void)callObserversWithSelector:(SEL)selector withObject:(NSObject *)object {
    @synchronized (_observers) {
        for (NSValue *observerContainer in _observers) {
            id observer = [observerContainer nonretainedObjectValue];

            if ([observer respondsToSelector:selector]) {
                [observer performSelectorOnMainThread:selector withObject:object waitUntilDone:NO];
            }
        }
    }
}

- (void)addObserver:(id <IStateHolderObserver>)observer {
    @synchronized (_observers) {
        [self removeObserver:observer];
        [_observers addObject:[NSValue valueWithNonretainedObject:observer]];
    }
}

- (void)removeObserver:(id <IStateHolderObserver>)observerToRemove {
    @synchronized (_observers) {
        NSMutableSet *toRemove = [[NSMutableSet alloc] initWithCapacity:[_observers count]];
        for (NSValue *observerContainer in _observers) {
            id observer = [observerContainer nonretainedObjectValue];
            if (observer == nil || observer == observerToRemove) { // address equality or dead link
                [toRemove addObject:observerContainer];
            }
        }
        for (NSValue *observerContainer in toRemove) {
            [_observers removeObject:observerContainer];
        }
    }
}

@end