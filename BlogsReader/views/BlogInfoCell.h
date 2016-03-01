//
//  BlogInfoCell.h
//  BlogsReader
//
//  Created by 郑光龙 on 16/3/1.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *netAddressLB;

@property (weak, nonatomic) IBOutlet UILabel *addTimeLB;
@end
