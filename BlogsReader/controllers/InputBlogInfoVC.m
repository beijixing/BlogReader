//
//  InputBlogInfoVC.m
//  BlogsReader
//
//  Created by 郑光龙 on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "InputBlogInfoVC.h"

@interface InputBlogInfoVC ()

@end

@implementation InputBlogInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)addButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
