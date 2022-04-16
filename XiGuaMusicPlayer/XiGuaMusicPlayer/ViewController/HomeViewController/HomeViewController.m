//
//  HomeViewController.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "HomeViewController.h"

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
    
    
}
#pragma mark - 重写get
- (UIButton *)dailyRecmdBtn {
    if (_dailyRecmdBtn == nil) {
        
        _dailyRecmdBtn = [[UIButton alloc]initWithFrame:CGRectMake(44, 95, 112, 90)];
        [_dailyRecmdBtn setBackgroundColor:[UIColor greenColor]];
        [_dailyRecmdBtn setTitle:@"每日推荐" forState:UIControlStateNormal];
        [_dailyRecmdBtn addTarget:self action:@selector(touchUpInsideDailyRecmdBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dailyRecmdBtn;
}

- (UIButton *)favoriteBtn {
    if (_favoriteBtn == nil) {
        _favoriteBtn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 44-112, 95, 112, 90)];
        [_favoriteBtn setBackgroundColor:[UIColor yellowColor]];
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


#pragma mark - Table Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = @"ListCell";
    
    ListTableViewCell *cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - 按钮响应方法

- (void)touchUpInsideDailyRecmdBtn:(UIButton *)dailyRecmdBtn {
    NSLog(@"点击每日推荐按钮");
}

- (void)touchUpInsideFavorateBtn:(UIButton *)favorateBtn {
    NSLog(@"点击收藏列表按钮");
}


@end

