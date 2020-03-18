//
//  ViewController.m
//  LXAbnormalView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAbnormalViewController.h"
#import "AbnormalView/LXAbnormalViewTool.h"

@interface LXAbnormalViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LXAbnormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    switch (indexPath.row) {
        case 0:
            [LXAbnormalViewTool abnormalViewInView:self.view imgName:@"kongbaiye" text:@"暂无任何数据"];
            break;
        case 1:
        {
            [LXAbnormalViewTool abnormalViewInView:self.view imgName:@"login_zhanghu" text:@"尚未\n登录" btnTitle:@"登录" callback:^(NSInteger idx) {
                [LXAbnormalViewTool removeInView:weakself.view];
            }];
        }
            break;
        case 2:
        {
            [LXAbnormalViewTool abnormalViewInView:self.view imgName:@"gouwuchekong" text:@"购物车为空" subText:@"暂无任何商品信息" btnTitle:@"去购物" callback:^(NSInteger idx) {
                [LXAbnormalViewTool removeInView:weakself.view];
            }];
        }
            break;
        case 3:
        {
            [LXAbnormalViewTool abnormalVerticalQueueViewInView:self.view callback:^(NSInteger idx) {
                [LXAbnormalViewTool removeInView:weakself.view];
            }];
        }
            break;
        case 4:
        {
            [LXAbnormalViewTool abnormalViewInView:self.view text:@"服务器线程拥堵" subText:@"没事，大佬们多搞几台电脑" callback:^{
                [LXAbnormalViewTool removeInView:weakself.view];
            }];
        }
            break;
        case 5:
        {
            [LXAbnormalViewTool abnormalViewInView:self.view text:@"您尚无修改权限，请联系管理员" btnTitle:@"确定" callback:^(NSInteger idx) {
                [LXAbnormalViewTool removeInView:weakself.view];
            }];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
