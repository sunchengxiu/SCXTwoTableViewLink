//
//  DPCollectionViewCell.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPCollectionModel.h"
@interface DPCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;
/******  model *****/
@property(nonatomic,strong)SubCategoryModel *model;
@end
