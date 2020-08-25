//
//  ViewController.m
//  ProperTree
//
//  Created by PC on 2020/8/21.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak) IBOutlet NSTextField *lab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self runShell];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (void)runShell
{
//    NSString *command = [NSString stringWithFormat:@"python %@/ProperTree/ProperTree.command",[[NSBundle mainBundle] resourcePath]];
    NSString *command = [NSString stringWithFormat:@"%@/ProperTree/ProperTree.command",[[NSBundle mainBundle] resourcePath]];
    self.lab.stringValue = command;

    [self runExecutablePath:command];
//    [self shellScriptWithCommand:command];
//    [self shellExecutablePath:command];

    exit(0);
}

/**
 直接执行某个文件，
 PS:文件路径允许有空格
 */
- (void)runExecutablePath:(NSString *)path
{
    NSTask *task =  [NSTask launchedTaskWithLaunchPath:path arguments:@[]];
    [task resume];
}

/*
 直接执行某个文件
 path:可执行文件路径
 PS:文件路径不允许有空格
 */
- (void)shellExecutablePath:(NSString *)path
{
    path = [NSString stringWithFormat:@"file://%@",path];
    NSLog(@"path: %@ ",path);
    NSTask *shellTask = [[NSTask alloc]init];
    [shellTask setLaunchPath:@"/bin/sh"];
    [shellTask setExecutableURL:[NSURL URLWithString:path]];
    [shellTask launchAndReturnError:nil];
}

/**
 终端shell调用
 @param command 终端中执行的命令字符串
 如：
 sh shell.sh
 python python.py
 PS:文件路径允许有空格
 */
- (void)shellScriptWithCommand:(NSString *)command
{
    NSTask *shellTask = [[NSTask alloc]init];
    [shellTask setLaunchPath:@"/bin/sh"];
//    NSString *shellStr = [NSString stringWithFormat:@"sh %@ 参数1",shellScriptPath];
    [shellTask setArguments:[NSArray arrayWithObjects:@"-c",command, nil]];
    NSPipe *pipe = [[NSPipe alloc]init];
    [shellTask setStandardOutput:pipe];
    [shellTask launchAndReturnError:nil];
    
//    NSFileHandle *file = [pipe fileHandleForReading];
//    NSData *data =[file readDataToEndOfFile];
//    NSString *strReturnFromShell = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"The return content from shell script is: %@",strReturnFromShell);
//    return strReturnFromShell;
}




@end
