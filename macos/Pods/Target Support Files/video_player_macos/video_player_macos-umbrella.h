#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLTVideoPlayerPlugin.h"
#import "messages.g.h"

FOUNDATION_EXPORT double video_player_macosVersionNumber;
FOUNDATION_EXPORT const unsigned char video_player_macosVersionString[];

