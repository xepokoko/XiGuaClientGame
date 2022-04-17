//
//  MusicPlayerCenter.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "MusicPlayerCenter.h"
#import "VoiceBroadcastTool.h"

static MusicPlayerCenter *playerCenter;

@interface MusicPlayerCenter () <AVAudioPlayerDelegate>

@end

@implementation MusicPlayerCenter


- (BOOL)isPlaying {
    return [self.player isPlaying];
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
    self.player.currentTime = 0;
}

/// 播放音乐
- (void)playMusic {
    [self.player prepareToPlay];
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playAnotherMusicNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePlayPauseBtnNotification" object:nil];
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePlayPauseBtnNotification" object:nil];
}


/// 播放下一首歌
- (void)playNextMusic {
    if (self.playMode == MusicPlayModeRepeatOne) {
        [self replayMusic];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(playNextMusicWithPlayMode:)]) {
        [self.delegate playNextMusicWithPlayMode:self.playMode];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePlayPauseBtnNotification" object:nil];
    
    // 延迟等旁白念完再念歌名
    [self performSelector:@selector(voiceSongName) withObject:nil afterDelay:1];
    
    // 延迟等歌名念完再放歌
    [self performSelector:@selector(playMusic) withObject:nil afterDelay:2];
}

/// 播放上一首歌
- (void)playLastMusic {
    if (self.player.currentTime > 20 || self.playMode == MusicPlayModeRepeatOne) {
        [self replayMusic];
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePlayPauseBtnNotification" object:nil];
    
    if ([self.delegate respondsToSelector:@selector(playLastMusicWithPlayMode:)]) {
        [self.delegate playLastMusicWithPlayMode:self.playMode];
    }
    
    // 延迟等旁白念完再念歌名
    [self performSelector:@selector(voiceSongName) withObject:nil afterDelay:1];
    
    // 延迟等歌名念完再放歌
    [self performSelector:@selector(playMusic) withObject:nil afterDelay:2];
}

/// 播放完毕，player 的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (_playMode != MusicPlayModeRepeat) { //不是循环播放，播放下一首
        [self playNextMusic];
    } else {    //继续播放当前歌曲
        [self replayMusic];
    }
}

/// 重新播放音乐
- (void)replayMusic {
    self.player.currentTime = 0;
}

/// 念歌名
- (void)voiceSongName {
    [VoiceBroadcastTool voiceBroadCastWithString:self.music.songName];
}

@end
