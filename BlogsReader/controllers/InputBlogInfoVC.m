//
//  InputBlogInfoVC.m
//  BlogsReader
//
//  Created by 郑光龙 on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "InputBlogInfoVC.h"
#import "BlogInfoModel.h"
#import "Tools.h"
#import "DataManager.h"

@interface InputBlogInfoVC ()

@end

@implementation InputBlogInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加";
    typeof (self) __weak weakSef = self;
    [self setLeftNavigationBarButtonItemWithImage:@"icon_left" andAction:^{
        [weakSef.navigationController popViewControllerAnimated:YES];
    }];
}



- (IBAction)addButtonClicked:(UIButton *)sender {
    if (self.blogNameTF.text.length == 0) {
        [ToolBox showAlertInfo:@"请输入博客名"];
        return;
    }else if(self.blogAddressTF.text.length == 0 ) {
        [ToolBox showAlertInfo:@"请输入博客地址"];
    }else {
        BlogInfoModel *blogModel = [[BlogInfoModel alloc] init];
        blogModel.name = self.blogNameTF.text;
        blogModel.address = self.blogAddressTF.text;
//        @"yyyy-MM-dd HH:mm:ss z" destFormat:@"yyyy.MM.dd HH:mm:ss"
       NSString *dateStr = [ToolBox getDateStringWithDate:[NSDate date].description dateFormat:@"yyyy-MM-dd HH:mm:ss z" destFormat:@"yyyy.MM.dd"];
        blogModel.addTime = dateStr;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[DataManager sharedDBManager] addBlogInfo:blogModel];
        });
        

        if (self.delegate) {
            [self.delegate addBlogIfo:blogModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
