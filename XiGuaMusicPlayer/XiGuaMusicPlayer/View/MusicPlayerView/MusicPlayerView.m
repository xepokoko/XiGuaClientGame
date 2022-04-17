//
//  MusicPlayerView.m
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import "MusicPlayerView.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


@implementation MusicPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
//        self.isAccessibilityElement = YES;//适配无障碍

        CGFloat play_x = ScreenWidth/2-ScreenWidth/6;
        CGFloat last_x = 0;
        CGFloat next_x = ScreenWidth*2/3;
        CGFloat height = self.bounds.size.height;
        CGFloat width = ScreenWidth/3;
        
        
        _lastSongBtn = [[UIButton alloc]initWithFrame:CGRectMake(last_x, 0, width, height)];
        [_lastSongBtn addTarget:self action:@selector(touchUpInsidLastSongBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_lastSongBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_lastSongBtn];
        [_lastSongBtn setImage:[UIImage systemImageNamed:@"backward.fill" configurationWithFontOfSize:30] forState:UIControlStateNormal];

        
        _nextSongBtn = [[UIButton alloc]initWithFrame:CGRectMake(next_x, 0, width, height)];
        [_nextSongBtn addTarget:self action:@selector(touchUpInsidNextSongBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_nextSongBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_nextSongBtn];
        [_nextSongBtn setImage:[UIImage systemImageNamed:@"forward.fill" configurationWithFontOfSize:30] forState:UIControlStateNormal];
        
        _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(play_x, 0, width, height)];
        [_playBtn addTarget:self action:@selector(touchUpInsidPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_playBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_playBtn];
        [_playBtn setImage:[UIImage systemImageNamed:@"play.fill" configurationWithFontOfSize:50] forState:UIControlStateNormal];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlayPauseBtn) name:@"updatePlayPauseBtnNotification" object:nil];
        
    }
    return self;
}
#pragma mark - 按钮点击响应方法
//上一首
- (void)touchUpInsidLastSongBtn: (UIButton *)button {
    
    [[MusicPlayerCenter defaultCenter] playLastMusic];
    
}

- (void)touchUpInsidNextSongBtn: (UIButton *)button {
    
    [[MusicPlayerCenter defaultCenter] playNextMusic];
    
}
- (void)touchUpInsidPlayBtn: (UIButton *)button {
    
    MusicPlayerCenter *playerCenter = [MusicPlayerCenter defaultCenter];
    
    if (playerCenter.music == nil) {
        playerCenter.music = self.music;
    }
    
    if ([playerCenter isPlaying]) {
        [button setImage:[UIImage systemImageNamed:@"play.fill" configurationWithFontOfSize:50] forState:UIControlStateNormal];

    } else {
        [button setImage:[UIImage systemImageNamed:@"pause.fill" configurationWithFontOfSize:50] forState:UIControlStateNormal];
    }
    [playerCenter togglePlayPause];
}


- (void)updatePlayPauseBtn {
    if ([[MusicPlayerCenter defaultCenter] isPlaying]) {
        [self.playBtn setImage:[UIImage systemImageNamed:@"pause.fill" configurationWithFontOfSize:50] forState:UIControlStateNormal];
    } else {
        [self.playBtn setImage:[UIImage systemImageNamed:@"play.fill" configurationWithFontOfSize:50] forState:UIControlStateNormal];
    }
}

#pragma mark - 设置旁白
- (void)setVoiceOver {
    
    _lastSongBtn.accessibilityLabel = @"上一首";
    _lastSongBtn.accessibilityHint = @"点击后将为你播放歌单中的上一首歌曲";
    
    _nextSongBtn.accessibilityLabel = @"下一首";
    _nextSongBtn.accessibilityHint = @"点击后将为你播放歌单中的下一首歌曲";
    
    _playBtn.accessibilityLabel = @"播放或暂停";
    _playBtn.accessibilityHint = @"点击后将为你播放歌曲或暂停播放";

}
@end
