//
//  DPTableViewController.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "DPTableViewController.h"
#import "DPRightTableViewCell.h"
#import "DPleftTableViewCell.h"
#import "DPDataModel.h"
#import "DPSectionModel.h"
typedef NS_ENUM(NSInteger,ScrollDiretion) {
    ScrollDiretionUp = 0,
    ScrollDiretionDown = 1
};
static ScrollDiretion scrollDirecton;
static NSString  *leftCellId = @"leftCellId";
static NSString  *rightCellId = @"rightCellId";
@interface DPTableViewController ()

@end

@implementation DPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    // 获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arr = dic[@"data"][@"food_spu_tags"];
    for (NSDictionary *dic in arr) {
        DPSectionModel *sectionModel = [DPSectionModel  modelWithDictionary:dic];
        [self.sectionArray addObject:sectionModel];
        NSMutableArray *foodArr = [NSMutableArray array];
        for (DPDataModel *dataModel in sectionModel.spus) {
            
            [foodArr addObject:dataModel];
        }
        [self.dataArray addObject:foodArr];
        
    }
    
}
#pragma mark - tableview代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _leftTableView) {
        DPleftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellId forIndexPath:indexPath];
        DPSectionModel *sectionModel = self.sectionArray[indexPath.row];
        cell.nameLabel.text = sectionModel.name;
        
        return cell;
    }
    else{
        DPRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellId forIndexPath:indexPath];
        NSArray *arr = self.dataArray[indexPath.section];
        DPDataModel *model = arr[indexPath.row];
        cell.model = model;
        return cell;
        
    }
    return [UITableViewCell new];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _leftTableView) {
       
        return self.sectionArray.count;
        
    }
    else{
    
        return [self.dataArray[section] count];
    }
   
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _rightTableView) {
        UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        view.backgroundColor = [UIColor lightGrayColor];
        [view setTextAlignment:NSTextAlignmentLeft];
        [view setTextColor:[UIColor whiteColor]];
        DPSectionModel *sectionModel = self.sectionArray[section];
        [view setText:sectionModel.name];
        return view;
    }
    else {
    
        return nil;
    }
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    static CGFloat lastOffset = 0;
    if ((UITableView *)scrollView == _rightTableView) {
        NSLog(@"%f",scrollView.contentOffset.y);
        
            scrollDirecton = scrollView.contentOffset.y > lastOffset;
            lastOffset = scrollView.contentOffset.y;
      
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _leftTableView) {
        return 1;
    }
    else{
    
        return self.dataArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (tableView == _rightTableView) {
        return 20;
    }
    else {
    
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 选中左边tableview的时候，右边要滑动到对应的位置
    if (tableView == _leftTableView) {
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    else {
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}
#pragma mark - 显示headerView的时候
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{

    if (tableView == _rightTableView && tableView.dragging && !scrollDirecton ) {
        [self changeHeaderViewWithSection:section];
    }
}
#pragma mark - 变换headerView的时候
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (tableView == _rightTableView && tableView.dragging && scrollDirecton ) {
        [self changeHeaderViewWithSection:section+1];
    }

}
#pragma mark - 当滑动右边的tableView的时候，左边也要对应做变换
- (void)changeHeaderViewWithSection:(NSInteger )indexPath {

    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark - 懒加载
-(NSMutableArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;

}
-(NSMutableArray *)sectionArray {

    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return  _sectionArray;
}
-(UITableView *)leftTableView {

    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, self.view.frame.size.height) style:UITableViewStylePlain];
        _leftTableView.rowHeight = 80;
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor whiteColor];
        [_leftTableView registerClass:[DPleftTableViewCell class] forCellReuseIdentifier:leftCellId];
        
    }
    return  _leftTableView;
}
-(UITableView *)rightTableView {
    
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width-80, self.view.frame.size.height) style:UITableViewStylePlain];
        _rightTableView.rowHeight = 80;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[DPRightTableViewCell class] forCellReuseIdentifier:rightCellId];
        
    }
    return  _rightTableView;
}
@end
