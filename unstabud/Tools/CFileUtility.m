//
//  Created by Alexey Rogatkin on 23.12.12.
//  
//


#import "CFileUtility.h"

@interface CFileUtility () {

}

@end

@implementation CFileUtility

+ (NSString *)makeDocumentsPathForFilename:(NSString *)filename {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
    return fullPath;
}

+ (void)deleteFile:(NSString *)fileName {
    NSString *fullPath = [self makeDocumentsPathForFilename:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        NSError *err = nil;
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&err];
        if (!success) {
            NSLog(@"Unable to delete file %@. Error: %@", fileName, err.userInfo);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}

@end