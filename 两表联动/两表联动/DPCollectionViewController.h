//
//  DPCollectionViewController.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPleftTableViewCell.h"
#import "DPCollectionViewCell.h"
#import "DPCollectionReusableView.h"
#import "DPCollectionModel.h"
#import "DPleftTableViewCell.h"
@interface DPCollectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
/******  tableView *****/
@property(nonatomic,strong)UITableView *tableView;
/******  collectView *****/
@property(nonatomic,strong)UICollectionView *collectionView;
/******  tableViewArray *****/
@property(nonatomic,strong)NSMutableArray *tableViewArray;
/******  collectionViewArray *****/
@property(nonatomic,strong)NSMutableArray *collectionViewArray;
@end
