//
//  DataManager.m
//  BlogsReader
//
//  Created by ybon on 16/3/2.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "DataManager.h"
#import "FMDB.h"
#import "Tools.h"

NSString *_dbPath = @"/data.sqlite";
@implementation DataManager

NSString *blogInfoTable = @"create table IF NOT EXISTS 'BlogInfoTable' (name text, addTime text, address text, id integer primary key autoincrement)";

+ (void)createDataBase {
    FMDatabase* _dataBase = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
    DLog(@"dbPath = %@", [NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]);
    
    if (![_dataBase open]) {
        DLog(@"数据库打开失败");
        return;
    }
    BOOL bRet = [_dataBase executeUpdate:blogInfoTable];
    if (!bRet) {
        DLog(@"创建 blogInfoTable 失败");
    }
    [_dataBase close];
}

+ (instancetype)sharedDBManager {
    static DataManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    return manager;
}

- (NSArray *)queryBlogInfo {
    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
    if (![db open]) {
        DLog(@"打开数据库失败");
        return NULL;
    }
    db.shouldCacheStatements = YES;

    NSMutableArray *blogListData = [[NSMutableArray alloc] init];
    FMResultSet* result = [db executeQuery:@"Select * from 'BlogInfoTable' "];
    while ([result next]) {
        BlogInfoModel *dataModel = [[BlogInfoModel alloc] init];
        dataModel.name = [result stringForColumn:@"name"];
        dataModel.addTime = [result stringForColumn:@"addTime"];
        dataModel.address = [result stringForColumn:@"address"];
        [blogListData addObject:dataModel];
    }
    return blogListData;
}

- (BOOL)addBlogInfo:(BlogInfoModel *)blogInfo; {
    if (!blogInfo) {
        return NO;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
    if (![db open]) {
        DLog(@"打开数据库失败");
        return NO;
    }
    NSString *checkSql = [NSString stringWithFormat:@"Select * from 'BlogInfoTable' Where address = '%@' ", blogInfo.address];
    FMResultSet* result = [db executeQuery:checkSql];
    if ([result next]) {//update
       NSString *sqlstr = [NSString stringWithFormat:@"UPDATE 'BlogInfoTable' SET name = '%@', addTime = '%@' WHERE address = '%@' ", blogInfo.name, blogInfo.addTime, blogInfo.address];
        [db executeUpdate:sqlstr];
    }else {//insert
        NSString *sqlstr = [NSString stringWithFormat:@"INSERT INTO 'BlogInfoTable' (name, addTime, address) VALUES ('%@', '%@', '%@') ", blogInfo.name, blogInfo.addTime, blogInfo.address];
        [db executeUpdate:sqlstr];
    }
    
    [db close];
    return true;
}

- (void)deleteBlogInfoWithAddress:(NSString *)address {
    if (!address) {
        return;
    }
    FMDatabase* db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@%@",PATH_OF_DOCUMENT, _dbPath]];
    if (![db open]) {
        DLog(@"打开数据库失败");
        return;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"Delete FROM 'BlogInfoTable' Where address = '%@' ", address];
    DLog(@"deleteSql = %@", deleteSql);
    BOOL bRet = [db executeUpdate: deleteSql];
    if (bRet) {
        DLog(@"删除blog = %@", address);
    }
}
@end
