//
//  ListTableViewCell.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "ListTableViewCell.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //初始化控件
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        _picImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_picImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, ScreenWidth-60, 25)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"歌曲名称";
        [self.contentView addSubview:_titleLabel];
        
        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, ScreenWidth-60, 20)];
        _authorLabel.font = [UIFont systemFontOfSize:14];
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.text = @"歌手名称";
        [self.contentView addSubview:_authorLabel];
        
        
        
        
    }

    return self;
}

//设置cell的数据用的
- (void)setInfo {
    
    _titleLabel.text = _musicModel.songName;
    _authorLabel.text = _musicModel.singerName;
    
}



@end
