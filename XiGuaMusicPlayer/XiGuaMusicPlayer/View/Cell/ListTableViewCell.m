//
//  ListTableViewCell.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "ListTableViewCell.h"
#import "Common.h"

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
        CGFloat padding = 10;

        //初始化控件
        
        self.indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-30, 10, 30, 30)];
        _indexLabel.font = [UIFont systemFontOfSize:14];
        _indexLabel.textColor = [UIColor systemGrayColor];
        _indexLabel.text = @"2";
        [self.contentView addSubview:_indexLabel];
        
        
        
        CGFloat picW = 70;
        CGFloat picH = picW;
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding,
                                                                         padding,
                                                                         picW,
                                                                         picH)];
        _picImageView.layer.cornerRadius = 10;
        _picImageView.clipsToBounds = YES;
        _picImageView.backgroundColor = [UIColor systemGray6Color];
        [self.contentView addSubview:_picImageView];
        
        CGFloat labelX = CGRectGetMaxX(_picImageView.frame) + padding;
        CGFloat titleLabelY = padding;
        CGFloat labelW = SCREENWIDTH - padding;
        CGFloat labelH = picH / 2;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX,
                                                                   titleLabelY,
                                                                   labelW,
                                                                   labelH)];
        _titleLabel.font = [UIFont systemFontOfSize:24 weight:8];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"歌曲名称";
        [self.contentView addSubview:_titleLabel];
        
        CGFloat authorLabelY = CGRectGetMaxY(_titleLabel.frame);
        self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX,
                                                                    authorLabelY,
                                                                    labelW,
                                                                    labelH)];
        _authorLabel.font = [UIFont systemFontOfSize:18 weight:6];
        _authorLabel.textColor = [UIColor lightGrayColor];
        _authorLabel.text = @"歌手名称";
        [self.contentView addSubview:_authorLabel];
            
    }

    return self;
}

//设置cell的数据用的
- (void)setInfo {
    
    _titleLabel.text = _musicModel.songName;
    _titleLabel.accessibilityLabel = _titleLabel.text;//无障碍设置
    
    _authorLabel.text = _musicModel.singerName;
    
    
    _picImageView.image = [UIImage imageNamed:_musicModel.songName];
}



@end
