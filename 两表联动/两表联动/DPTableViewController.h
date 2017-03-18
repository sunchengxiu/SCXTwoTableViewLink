//
//  DPTableViewController.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPCollectionViewController.h"
@interface DPTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
/******  dataArray *****/
@property(nonatomic,strong)NSMutableArray *dataArray;

/******  sectionArray *****/
@property(nonatomic,strong)NSMutableArray *sectionArray;

/******  leftTableView *****/
@property(nonatomic,strong)UITableView *leftTableView;

/******  rightTableView *****/
@property(nonatomic,strong)UITableView *rightTableView;
@end
