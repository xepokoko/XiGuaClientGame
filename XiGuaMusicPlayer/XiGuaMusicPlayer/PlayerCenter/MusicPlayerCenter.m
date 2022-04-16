//
//  MusicPlayerCenter.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "MusicPlayerCenter.h"

static MusicPlayerCenter *playerCenter;

@interface MusicPlayerCenter () <AVAudioPlayerDelegate>

@end

@implementation MusicPlayerCenter


- (BOOL)isPlaying {
    if (!_playing) {
        _playing = YES;
    }
    return _playing;
}

- (MusicPlayMode)playMode {
    if (!_playMode) {
        _playMode = MusicPlayModeRepeat;
    }
    return _playMode % 3;
}

- (void)setMusic:(MusicModel *)music {
    _music = music;
    
    [self loadMusic];
}

/// 加载音乐
- (void)loadMusic {
    NSString *songPath = [[NSBundle mainBundle] pathForResource:_music.songName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:songPath];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    self.player.volume = 0.5;
    self.player.currentTime = 0;
}

/// 播放音乐
- (void)playMusic {
    [self.player prepareToPlay];
    [self.player play];
}

/// 单例
+ (instancetype)defaultCenter {
    if (playerCenter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            playerCenter = [[self alloc] init];
        });
    }
    return playerCenter;
}


/// 播放或暂停
- (void)togglePlayPause {
    if ([self isPlaying]) {
        [_player pause];
    } else {
        [_player play];
    }
}


/// 播放下一首歌
- (void)playNextMusic {
    
}

/// 播放完毕，player 的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (_playMode != MusicPlayModeRepeat) { //不是循环播放，播放下一首
        [self playNextMusic];
    } else {    //继续播放当前歌曲
        [self playMusic];
    }
}

- (void)updateProgress {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateProgressNotification" object:nil];
}

- (NSTimer *)progressTimer {
    if (!_progressTimer) {
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self updateProgress];
        }];
    }
    return _progressTimer;
}

@end
