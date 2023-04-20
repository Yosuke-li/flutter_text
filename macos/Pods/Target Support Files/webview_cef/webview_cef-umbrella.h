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

#import "CefWrapper.h"
#import "WebviewCefPlugin.h"

FOUNDATION_EXPORT double webview_cefVersionNumber;
FOUNDATION_EXPORT const unsigned char webview_cefVersionString[];

