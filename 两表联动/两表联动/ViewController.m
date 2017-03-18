//
//  ViewController.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "ViewController.h"
#import "DPTableViewController.h"
#import "DPCollectionViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *tbBtn = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2, 200, 150, 50)];
        [btn setTitle:@"tableview联动" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [btn addTarget:self action:@selector(tableviewLink) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:tbBtn];
    
    UIButton *tbBtn1 = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-250)/2, 300, 250, 50)];
        [btn setTitle:@"collectionView联动" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(collectionViewLink) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        btn;
    });
    [self.view addSubview:tbBtn1];
}

/**
 tableview联动
 */
- (void)tableviewLink{

    NSLog(@"点击tableview联动了");
    DPTableViewController *vc = [[DPTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

/**
 collenctionview联动
 */
- (void)collectionViewLink{

    NSLog(@"点击collectionView联动了");
    DPCollectionViewController *collectionView = [[DPCollectionViewController alloc]init];
    [self.navigationController pushViewController:collectionView animated:YES];
    
}


@end
