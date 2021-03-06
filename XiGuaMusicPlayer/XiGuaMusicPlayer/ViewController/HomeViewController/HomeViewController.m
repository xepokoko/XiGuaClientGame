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
#import "MusicPlayerView.h"
#import "VoiceSearchCenter.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource,MusicPlayerCenterDelegate>

@property (nonatomic, strong) NSMutableArray *favoriteList;

/// 记录选中的歌曲的 indexPath
@property (nonatomic, strong)NSIndexPath *selectedIndexPath;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [MusicPlayerCenter defaultCenter].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAndLayoutViews];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //设置旁白
    [self setVoiceOver];
    
}
//初始化和布局
- (void)setAndLayoutViews {
    
    self.title = @"xxMusicPlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listTabelView];
    
    [self.view addSubview:self.favoriteBtn];
    
    [self.view addSubview:self.dailyRecmdBtn];
    
}
#pragma mark - 重写get
- (UIButton *)dailyRecmdBtn {
    if (_dailyRecmdBtn == nil) {
        CGFloat padding = 20;
        
        CGFloat buttonX = padding;
        CGFloat buttonY = 91 + padding / 2;
        CGFloat buttonW = (ScreenWidth - padding * 3) / 2;
        CGFloat buttonH = CGRectGetMinY(self.listTabelView.frame) - padding - buttonY;
        _dailyRecmdBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                   buttonY,
                                                                   buttonW,
                                                                   buttonH)];
        [_dailyRecmdBtn setBackgroundColor:[UIColor systemGreenColor]];
        _dailyRecmdBtn.layer.cornerRadius = 10;
        [_dailyRecmdBtn setTitle:@"每日推荐" forState:UIControlStateNormal];
        [_dailyRecmdBtn addTarget:self action:@selector(touchUpInsideDailyRecmdBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _dailyRecmdBtn.accessibilityValue = @"共有两首歌曲";
        _dailyRecmdBtn.accessibilityHint = @"双击进入每日推荐";
    }
    return _dailyRecmdBtn;
}

- (UIButton *)favoriteBtn {
    if (_favoriteBtn == nil) {
        CGFloat padding = 20;
        CGFloat buttonW = self.dailyRecmdBtn.frame.size.width;
        CGFloat buttonH = self.dailyRecmdBtn.frame.size.height;
        CGFloat buttonY = self.dailyRecmdBtn.frame.origin.y;
        CGFloat buttonX = ScreenWidth - padding - buttonW;
        _favoriteBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                 buttonY,
                                                                 buttonW,
                                                                 buttonH)];
        [_favoriteBtn setBackgroundColor:[UIColor systemYellowColor]];
        _favoriteBtn.layer.cornerRadius = 10;
        [_favoriteBtn setTitle:@"收藏列表" forState:UIControlStateNormal];
        [_favoriteBtn addTarget:self action:@selector(touchUpInsideFavorateBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _favoriteBtn.accessibilityValue = @"共有四首歌曲";
        _favoriteBtn.accessibilityHint = @"双击进入我的收藏";
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

//直接在工程文件获取数组了，也没有网络请求，就不存本地了。
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
    
    //暂时设定个假数据，用于语音搜索完了之后就聚焦到某个被搜索到的cell上
    if ([cell.musicModel.songName isEqualToString:@"陀飞轮"]) {
        
        [VoiceSearchCenter defaultCenter].focusObj = cell;
        
    }
    
    //获取model后设置数据。
    cell.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell setInfo];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 90;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndexPath == indexPath) {
        // 正在播放歌曲，且点击的 cell 正在播放
        // 直接 push
        PlayViewController *controller = [[PlayViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    // 没有播放歌曲
    MusicModel *music = self.musicList[indexPath.row];
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    center.music = music;
    if (center.progressTimer == nil) {
        center.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProgressNotification" object:nil];
        }];
    }
    PlayViewController *controller = [[PlayViewController alloc] init];
    _selectedIndexPath = indexPath;
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - 按钮响应方法

- (void)touchUpInsideDailyRecmdBtn:(UIButton *)dailyRecmdBtn {
    
    //用随机数来模拟每日推荐的歌单，重复也没关系
    NSMutableArray *dailyMusicList = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (NSInteger i = 0; i < 2; i++) {
        NSInteger randomNumber = arc4random() % 4;
        
        [dailyMusicList addObject:_musicList[randomNumber]];
        
    }
    
    DailyRecmViewController *recm = [[DailyRecmViewController alloc] init];
    
    recm.musicList = dailyMusicList;
    [self.navigationController pushViewController:recm animated:YES];
    
 
    
    
}

- (void)touchUpInsideFavorateBtn:(UIButton *)favorateBtn {
    
    FavoriteViewController *favo = [[FavoriteViewController alloc] init];
    favo.musicList = self.favoriteList;
    
    [self.navigationController pushViewController:favo animated:YES];
   
}

#pragma mark - MusicPlayerCenterDelegate
- (void)playLastMusicWithPlayMode:(MusicPlayMode)playMode {
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    MusicModel *music = [[MusicModel alloc] init];
    NSInteger newRow = 0;
    switch (playMode) {
        case MusicPlayModeRepeat:
            newRow = _selectedIndexPath.row - 1;
            break;
        case MusicPlayModeShuffle:
            // 防止随到同一首
            newRow = _selectedIndexPath.row - arc4random() % (_musicList.count - 1) - 1;
            break;
        default:
            break;
    }
    if (newRow < 0) {
        newRow += _musicList.count;
    }
    
    music = _musicList[newRow];
    center.music = music;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:newRow inSection:_selectedIndexPath.section];
}

- (void)playNextMusicWithPlayMode:(MusicPlayMode)playMode {
    MusicPlayerCenter *center = [MusicPlayerCenter defaultCenter];
    MusicModel *music = [[MusicModel alloc] init];
    NSInteger newRow = 0;
    switch (playMode) {
        case MusicPlayModeRepeat:
            newRow =_selectedIndexPath.row + 1;
            break;
        case MusicPlayModeShuffle:
            newRow = _selectedIndexPath.row + arc4random() % (_musicList.count - 1) + 1;
            break;
        default:
            break;
    }
    if (newRow >= _musicList.count) {
        newRow -= _musicList.count;
    }
    
    music = _musicList[newRow];
    center.music = music;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:newRow inSection:_selectedIndexPath.section];
}


- (void)setVoiceOver {
    self.dailyRecmdBtn.accessibilityHint = @"双击进入每日推荐的歌曲列表";
    self.favoriteBtn.accessibilityHint = @"双击进入收藏的歌曲列表";
}

@end

