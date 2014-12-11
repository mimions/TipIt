//
//  DatabaseManager.h
//  TipIt!
//
//  Created by Sara on 12/9/14.
//  Copyright (c) 2014 SkinnyHamsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject

@property (nonatomic) sqlite3 *database;


-(void)openDatabase:(NSString *)dbname;

-(void)executeNonQuery:(NSString *)sql;

-(NSArray *)executeQuery:(NSString *)sql;

@end
