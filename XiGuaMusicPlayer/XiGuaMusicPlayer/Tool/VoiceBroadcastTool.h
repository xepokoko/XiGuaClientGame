//
//  VoiceBroadcastTool.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/17.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoiceBroadcastTool : NSObject

@property (nonatomic, strong)AVSpeechSynthesizer* synthesizer;
@property (nonatomic, strong)AVSpeechUtterance* utterance;
@property (nonatomic, copy) NSString* displayPinYinContStr;
- (void)voiceBroadcastWithString:(NSString *)str;


/// 阅读传入的 string
+ (void)voiceBroadCastWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
