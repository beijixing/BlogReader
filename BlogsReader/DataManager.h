//
//  DataManager.h
//  BlogsReader
//
//  Created by ybon on 16/3/2.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogInfoModel.h"

@interface DataManager : NSObject
+ (instancetype)sharedDBManager;
+ (void)createDataBase;


- (NSArray *)queryBlogInfo;
- (BOOL)addBlogInfo:(BlogInfoModel *)blogInfo;
- (void)deleteBlogInfoWithAddress:(NSString *)address;
@end
