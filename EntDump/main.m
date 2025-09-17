//
//  main.m
//  EntDump
//
//  Created by Dora Orak on 13.09.2025.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    
    
    AppDelegate* appDelegate;
    
    appDelegate = [[AppDelegate alloc] init];
    
    [[NSApplication sharedApplication] setDelegate:appDelegate];
    
    [[NSApplication sharedApplication]  run];
    
    return 0;
}
