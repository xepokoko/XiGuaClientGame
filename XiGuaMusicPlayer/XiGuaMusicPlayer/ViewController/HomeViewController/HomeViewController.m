//
//  HomeViewController.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "HomeViewController.h"
#import "PlayViewController.h"
#import "MusicPlayerCenter.h"
#import "MusicModel.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAndLayoutViews];
    
    
    
    
}
//初始化和布局
- (void)setAndLayoutViews {
    
    self.title = @"xxMusicPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listTabelView];
    
    [self.view addSubview:self.favoriteBtn];
    
    [self.view addSubview:self.dailyRecmdBtn];
    
    NSLog(@"%@", self.musicList);
    
}
#pragma mark - 重写get
- (UIButton *)dailyRecmdBtn {
    if (_dailyRecmdBtn == nil) {
        
        _dailyRecmdBtn = [[UIButton alloc]initWithFrame:CGRectMake(44, 95, 112, 90)];
        [_dailyRecmdBtn setBackgroundColor:[UIColor systemGreenColor]];
        [_dailyRecmdBtn setTitle:@"每日推荐" forState:UIControlStateNormal];
        [_dailyRecmdBtn addTarget:self action:@selector(touchUpInsideDailyRecmdBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dailyRecmdBtn;
}

- (UIButton *)favoriteBtn {
    if (_favoriteBtn == nil) {
        _favoriteBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 44-112, 95, 112, 90)];
        [_favoriteBtn setBackgroundColor:[UIColor systemYellowColor]];
        [_favoriteBtn setTitle:@"收藏列表" forState:UIControlStateNormal];
        [_favoriteBtn addTarget:self action:@selector(touchUpInsideFavorateBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favoriteBtn;
}

- (UITableView *)listTabelView {
    if (_listTabelView == nil) {
        CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
        CGFloat naviHeight = 91; //直接在图层获取的。
        CGFloat globalPlayerHeight = 50;//全局控制音乐播放的那个view的高度
        CGFloat spaceHeight = 120; //table上面预留的空位
        
        
        _listTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, naviHeight+spaceHeight, ScreenWidth, ScreenHeight-naviHeight-globalPlayerHeight-tabHeight-spaceHeight)];
        
        _listTabelView.backgroundColor = [UIColor whiteColor];
        _listTabelView.delegate = self;
        _listTabelView.dataSource = self;
        
    }
    return _listTabelView;
}

- (NSMutableArray *)musicList {
    if (_musicList == nil) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"musicList" ofType:@"plist"];
        
        
        NSMutableArray *dictArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            MusicModel *model = [MusicModel musicModelWithDict:dict];
            [modelArray addObject:model];
        }
        _musicList = modelArray;
        
        
    }
    
    
    return _musicList;
}


#pragma mark - Table Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _musicList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = @"ListCell";
    
    ListTableViewCell *cell = [self.listTabelView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.musicModel = _musicList[indexPath.row];
    
    [cell setInfo];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicModel *music = self.musicList[indexPath.row];
    [MusicPlayerCenter defaultCenter].music = music;
    PlayViewController *controller = [[PlayViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - 按钮响应方法

- (void)touchUpInsideDailyRecmdBtn:(UIButton *)dailyRecmdBtn {
    NSLog(@"点击每日推荐按钮");
}

- (void)touchUpInsideFavorateBtn:(UIButton *)favorateBtn {
    NSLog(@"点击收藏列表按钮");
}


@end

