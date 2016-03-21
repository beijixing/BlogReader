//
//  InputBlogInfoVC.h
//  BlogsReader
//
//  Created by 郑光龙 on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class BlogInfoModel;
@protocol InputBlogInfoDelegate <NSObject>

- (void)addBlogIfo:(BlogInfoModel *)blogInfo;

@end

@interface InputBlogInfoVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *blogNameTF;
@property (weak, nonatomic) IBOutlet UITextField *blogAddressTF;
@property (assign, nonatomic) id<InputBlogInfoDelegate> delegate;
- (IBAction)addButtonClicked:(UIButton *)sender;
@end
