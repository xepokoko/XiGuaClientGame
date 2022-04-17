//
//  ListTableViewCell.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ListTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *indexLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) MusicModel *musicModel;

- (void)setInfo;
@end

NS_ASSUME_NONNULL_END
