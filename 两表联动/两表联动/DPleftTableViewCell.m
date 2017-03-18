//
//  DPleftTableViewCell.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "DPleftTableViewCell.h"

@implementation DPleftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.yellowLabel];
    }
    return self;
}

#pragma mark - 懒加载 
-(UILabel *)yellowLabel {

    if (!_yellowLabel) {
        _yellowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 5, 45)];
        _yellowLabel.backgroundColor = [UIColor yellowColor];
    }
    return _yellowLabel;

}
-(UILabel *)nameLabel {

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 40)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.highlightedTextColor = [UIColor yellowColor];
    }
    return _nameLabel;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.nameLabel.highlighted = selected;
    self.highlighted = self;
    self.yellowLabel.hidden = !selected;
}

@end
