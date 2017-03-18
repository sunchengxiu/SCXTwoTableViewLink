//
//  DPCollectionViewController.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "DPCollectionViewController.h"
#import "DPCollectionViewFlowLayout.h"
typedef NS_ENUM(NSInteger,ScrollDiretion) {
    ScrollDiretionUp = 0,
    ScrollDiretionDown = 1
};
static ScrollDiretion scrollDirecton;

static NSString  *leftCellId = @"leftCellId";
static NSString  *rightCellId = @"rightCollectionViewCellId";
static NSString  *headerCellID = @"headerCellID";

@interface DPCollectionViewController ()

@end

@implementation DPCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    // 加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arr = dic[@"data"][@"categories"];
    for (NSDictionary *dict in arr) {
        DPCollectionModel *leftModel = [DPCollectionModel modelWithDictionary:dict];
        [self.tableViewArray addObject:leftModel];
        NSMutableArray *arrr= [NSMutableArray array];
        for (SubCategoryModel *model in leftModel.subcategories) {
            [arrr addObject:model];
        }
        [self.collectionViewArray addObject:arrr];
    }
    [self.tableView reloadData];
    [self.collectionView reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView)
    {
        scrollDirecton = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
#pragma mark - tableView 代理方法 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DPleftTableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftCellId forIndexPath:indexPath];
    DPCollectionModel *model = self.tableViewArray[indexPath.row];
    leftCell.nameLabel.text = model.name;
    return leftCell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

#pragma mark - collectionView 代理方法 
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.collectionViewArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.collectionViewArray[section] count];

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:rightCellId forIndexPath:indexPath];
    SubCategoryModel *model = self.collectionViewArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((self.view.frame.size.width - 80 - 4 - 4) / 3,
//                      (self.view.frame.size.width - 80 - 4 - 4) / 3 + 30);
//}
#pragma mark - 设置headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    DPCollectionReusableView *view = [[DPCollectionReusableView alloc]init];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID forIndexPath:indexPath];
        DPCollectionModel *model = self.tableViewArray[indexPath.section];
        view.title.text = model.name;
    }
    return view;
}
#pragma mark - 结束展示headerView的时候
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (scrollDirecton && collectionView.dragging) {
        [self selectRowAtIndexPath:indexPath.section+1];
    }
}
#pragma mark - 将要展示headerView的时候
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

    if (!scrollDirecton && collectionView.dragging) {
        [self selectRowAtIndexPath:indexPath.section];
    }
}
- (void)selectRowAtIndexPath:(NSInteger )index {
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 懒加载
-(UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, self.view.frame.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight = 55;
        [_tableView registerClass:[DPleftTableViewCell class] forCellReuseIdentifier:leftCellId];
    }
    return _tableView;
}
-(UICollectionView *)collectionView {

    if (!_collectionView) {
        DPCollectionViewFlowLayout *flowLayout = [[DPCollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize =  CGSizeMake(self.view.frame.size.width, 30);
        flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 80 - 4 - 4) / 3,
                                         (self.view.frame.size.width - 80 - 4 - 4) / 3 + 30);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2 + 80, 2 + 64, self.view.frame.size.width - 80 - 4, self.view.frame.size.height - 64 - 4) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[DPCollectionViewCell class] forCellWithReuseIdentifier:rightCellId];
        [_collectionView registerClass:[DPCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID];
    }
    return _collectionView;
}
-(NSMutableArray *)tableViewArray {

    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}
-(NSMutableArray *)collectionViewArray {

    if (!_collectionViewArray) {
        _collectionViewArray = [NSMutableArray array];
    }
    return _collectionViewArray;
}
@end
