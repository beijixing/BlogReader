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
#import "DataManager.h"
#import "BlogContentVC.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, InputBlogInfoDelegate>
{
    NSMutableArray *_blogDataArr;
    BOOL _willlUpdateData;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _blogDataArr = [NSMutableArray arrayWithArray:[[DataManager sharedDBManager] queryBlogInfo]];
    [self configNavigationBar];
    [self.blogList registerNib:[UINib nibWithNibName:@"BlogInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BlogInfoCell"];
    self.blogList.separatorStyle = UITableViewCellSeparatorStyleNone;
    _willlUpdateData = false;
}

- (void)viewWillAppear:(BOOL)animated {
    if (_willlUpdateData) {
        [self.blogList reloadData];
    }
}

- (void)configNavigationBar {
    self.navigationItem.title = @"blogs";
    
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBlog:)];
    rightBarbutton.tintColor = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem = rightBarbutton;
}

- (void)addBlog:(id)sender {
    InputBlogInfoVC *inputInfoVC = [[InputBlogInfoVC alloc] init];
    inputInfoVC.delegate = self;
    [self.navigationController pushViewController:inputInfoVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _blogDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogInfoCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogInfoModel *dataModel = [_blogDataArr objectAtIndex:indexPath.row];
    BlogInfoCell *showCell = (BlogInfoCell *)cell;
    showCell.nameLB.text = dataModel.name;
    showCell.addTimeLB.text = dataModel.addTime;
    showCell.netAddressLB.text = dataModel.address;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogContentVC *vc = [[BlogContentVC alloc] init];
    BlogInfoModel *dataModel = [_blogDataArr objectAtIndex:indexPath.row];
    vc.netAddress = dataModel.address;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){
        BlogInfoModel *dataModel = [_blogDataArr objectAtIndex:indexPath.row];
        [[DataManager sharedDBManager] deleteBlogInfoWithAddress:dataModel.address];
        [_blogDataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)addBlogIfo:(BlogInfoModel *)blogInfo {
    _willlUpdateData = YES;
    [_blogDataArr addObject:blogInfo];
}

@end
