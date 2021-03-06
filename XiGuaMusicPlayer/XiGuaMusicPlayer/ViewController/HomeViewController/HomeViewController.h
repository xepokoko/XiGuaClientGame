//
//  HomeViewController.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "ListTableViewCell.h"
#import "PlayViewController.h"
#import "FavoriteViewController.h"
#import "DailyRecmViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (nonatomic, strong) UITableView *listTabelView;

@property (nonatomic, strong) UIButton *dailyRecmdBtn;

@property (nonatomic, strong) UIButton *favoriteBtn;

@property (nonatomic, strong) NSMutableArray *musicList;

@end

NS_ASSUME_NONNULL_END
