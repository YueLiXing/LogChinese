//
//  Logger.h
//
//  Created by yuelixing on 16/5/9.
//  Copyright © 2016年 tutu. All rights reserved.
//

#ifndef Logger_h
#define Logger_h

#define StarDebug DEBUG         // DEBUG环境下使用

#if StarDebug /* Debug Begin */

static const char * NSLogTitle = "Info";

static const char * InfoTitle = "Info";

static const char * DebugTitle = "Debug";

static const char * WarningTitle = "Warning";

static const char * ErrorTitle = "Error";

static const char * SuccessTitle = "Success";

static const char * FailureTitle = "Failure";

static const char * AssertTitle = "Assert";

static const char * BackTraceTitle = "BackTrace";

static const int StarBackTrace = 0;        // 开关方法调用栈输出
static const int StarBackTraceDepth = 4;    // 栈深度

#define PrivateLog(color, title, stack, format, ...)\
printf("<%s> [%s][%s:%d] %s %s\n",\
star_current_time(),\
title,\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],\
__LINE__,\
[[NSString stringWithFormat:format,##__VA_ARGS__] UTF8String],\
star_back_trace(stack, StarBackTraceDepth)\
);\

// NSLog
#define NSLog(format, ...) \
PrivateLog(0, NSLogTitle, StarBackTrace, format, ##__VA_ARGS__)

#define NSLogCMD \
NSLog(@"%s", __PRETTY_FUNCTION__);

// Information
#define LogInfo(format, ...) \
PrivateLog(0, InfoTitle, StarBackTrace, format, ##__VA_ARGS__)

// Debug
#define LogDebug(format, ...) \
PrivateLog(0, DebugTitle, StarBackTrace, format, ##__VA_ARGS__)

// Warning
#define LogWarning(format, ...) \
PrivateLog(0, WarningTitle, StarBackTrace, format, ##__VA_ARGS__)

// Error
#define LogError(format, ...) \
PrivateLog(0, ErrorTitle, StarBackTrace, format, ##__VA_ARGS__)

// Success
#define LogSuccess(format, ...) \
PrivateLog(0, SuccessTitle, StarBackTrace, format, ##__VA_ARGS__)

// Failure
#define LogFailure(format, ...) \
PrivateLog(0, FailureTitle, StarBackTrace, format, ##__VA_ARGS__)

// Assert
#define LogAssert(condition, format, ...)\
PrivateLog(0, FailureTitle, StarBackTrace, format, ##__VA_ARGS__);\
NSAssert(condition, format, ##__VA_ARGS__)

// Stack
#define LogBackTrace(format, ...) \
PrivateLog(0, BackTraceTitle, 1, format, ##__VA_ARGS__)\

#else /* Debug Else */

#define PrivateLog(color, title, format, ...) while(0){}
#define NSLog(...) while(0){}
#define NSLogCMD while(0){}
#define LogInfo(...) while(0){}
#define LogDebug(...) while(0){}
#define LogError(...) while(0){}
#define LogWarning(...) while(0){}
#define LogSuccess(...) while(0){}
#define LogFailure(...) while(0){}
#define LogAssert(condition, format, ...) while(0){}
#define LogBackTrace(...) while(0){}

#endif /* Debug End */




/* Function Begin */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <execinfo.h>
#include <time.h>
#include <sys/timeb.h>


static const int STAR_BACK_TRACE_BUFFER = 4096;
static const int STAR_TIME_BUFFER = 255;


static inline const char * star_back_trace(int open, int depth) {
    
    if (!open) {
        return "";
    }
    
    static char star_back_trace_str[STAR_BACK_TRACE_BUFFER];
    
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    memset(star_back_trace_str, 0, STAR_BACK_TRACE_BUFFER * sizeof(char));
    strcat(star_back_trace_str, "\n<BackTrace Begin>");
    for (int i = 1; i < frames; i++) {
        // if (strlen(star_back_trace_str) + strlen(strs[i]) + 16 > STAR_BACK_TRACE_BUFFER)
        //     break;
        strcat(star_back_trace_str, "\n\t");
        strcat(star_back_trace_str, strs[i]);
        if (i == depth)
            break;
    }
    strcat(star_back_trace_str, "\n<End>");
    
    free(strs);
    strs = NULL;
    
    return star_back_trace_str;
}

static inline const char * star_current_time() {
    
    static char star_time_str[STAR_TIME_BUFFER];
    
    struct timeb timeinfo;
    ftime(&timeinfo);
    
    struct tm * second_timeinfo;
    second_timeinfo = localtime(&timeinfo.time);
    
    memset(star_time_str, 0, STAR_TIME_BUFFER * sizeof(char));
    strftime(star_time_str, STAR_TIME_BUFFER, "%Y-%m-%d %H:%M:%S", second_timeinfo);
    
    char millitm[16];
    sprintf(millitm, ".%03d", timeinfo.millitm);
    strcat(star_time_str, millitm);
    return star_time_str;
}



#endif /* Logger_h */
