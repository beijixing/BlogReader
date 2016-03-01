//
//  InputBlogInfoVC.h
//  BlogsReader
//
//  Created by 郑光龙 on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputBlogInfoVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *blogNameTF;

@property (weak, nonatomic) IBOutlet UITextField *blogAddressTF;
- (IBAction)addButtonClicked:(UIButton *)sender;
@end
