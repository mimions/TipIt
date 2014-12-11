//
//  TaxRateData.m
//  TipIt!
//
//  Created by Sara on 12/9/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import "TaxRateData.h"

@implementation TaxRateData

- (void)createFile:(NSString *)fileName {
 
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];

    if (![fileManager createFileAtPath:fileName contents:nil attributes:nil]) {
        NSLog(@"不能创建文件");
    }
}

@end
