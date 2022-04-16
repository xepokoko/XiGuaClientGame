//
//  HomeViewController.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "ListTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (nonatomic, strong) UITableView *listTabelView;

@property (nonatomic, strong) UIButton *dailyRecmdBtn;

@property (nonatomic, strong) UIButton *favoriteBtn;

@end

NS_ASSUME_NONNULL_END
