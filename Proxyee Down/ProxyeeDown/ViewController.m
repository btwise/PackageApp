//
//  ViewController.m
//  Proxyee Down
//
//  Created by PC on 2020/8/25.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self runShell];
    [self runProxyeeDown];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}



- (void)runShell
{
    NSString *path = [NSString stringWithFormat:@"%@/ProxyeeDown/proxyee-down-main.jar",[[NSBundle mainBundle] resourcePath]];
    [self InvokingShellScriptAtPath:path];
    exit(0);
}


-(void) InvokingShellScriptAtPath :(NSString*) shellScriptPath
{
    NSTask *shellTask = [[NSTask alloc]init];
    [shellTask setLaunchPath:@"/bin/sh"];
    NSString *shellStr = [NSString stringWithFormat:@"java -jar %@",shellScriptPath];

//    -c 表示将后面的内容当成shellcode来执行
    [shellTask setArguments:[NSArray arrayWithObjects:@"-c",shellStr, nil]];
    NSPipe *pipe = [[NSPipe alloc]init];
    [shellTask setStandardOutput:pipe];
//    [shellTask launch];
    [shellTask launchAndReturnError:nil];


//    NSFileHandle *file = [pipe fileHandleForReading];
//    NSData *data =[file readDataToEndOfFile];
//    NSString *strReturnFromShell = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"The return content from shell script is: %@",strReturnFromShell);
//    return strReturnFromShell;
}

- (void)runProxyeeDown
{
    NSString *path = [NSString stringWithFormat:@"%@/ProxyeeDown/proxyee-down-main.jar",[[NSBundle mainBundle] resourcePath]];
    NSString *java = [self jrePath];
    NSTask *task =  [NSTask launchedTaskWithLaunchPath:java arguments:@[@"-jar",path]];
    [task resume];

    exit(0);
}

/**
 获取jre 的具体路径
 */
- (NSString *)jrePath
{
    NSTask *shellTask = [[NSTask alloc]init];
    [shellTask setLaunchPath:@"/bin/sh"];
    NSString *shellStr = @"/usr/libexec/java_home";
    //    -c 表示将后面的内容当成shellcode来执行
    [shellTask setArguments:[NSArray arrayWithObjects:@"-c",shellStr, nil]];
    NSPipe *pipe = [[NSPipe alloc]init];
    [shellTask setStandardOutput:pipe];
    [shellTask launchAndReturnError:nil];

    NSFileHandle *file = [pipe fileHandleForReading];
    NSData *data =[file readDataToEndOfFile];
    NSString *strReturnFromShell = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *java = [NSString stringWithFormat:@"%@/jre/bin/java",strReturnFromShell];
    java = [java stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return java;
}


@end
