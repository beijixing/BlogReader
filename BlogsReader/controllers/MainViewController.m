//
//  MianViewController.m
//  BlogsReader
//
//  Created by ybon on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "MainViewController.h"
#import "BlogInfoCell.h"
#import "InputBlogInfoVC.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self configNavigationBar];
    [self.blogList registerNib:[UINib nibWithNibName:@"BlogInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BlogInfoCell"];
    self.blogList.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configNavigationBar {
    self.navigationItem.title = @"blogs";
    
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBlog:)];
    self.navigationItem.rightBarButtonItem = rightBarbutton;
}

- (void)addBlog:(id)sender {
    InputBlogInfoVC *inputInfoVC = [[InputBlogInfoVC alloc] init];
    [self.navigationController pushViewController:inputInfoVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogInfoCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
