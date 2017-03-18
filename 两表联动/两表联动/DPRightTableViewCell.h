//
//  DPRightTableViewCell.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPDataModel.h"
@interface DPRightTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
/******  model *****/
@property(nonatomic,strong)DPDataModel *model;
@end
