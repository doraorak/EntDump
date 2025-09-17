//
//  AppDelegate.m
//  EntDump
//
//  Created by Dora Orak on 13.09.2025.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <dlfcn.h>

@interface AppDelegate ()

@property (strong) NSWindow* window;
@property (strong) NSViewController* vc;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
   // dlopen("/Library/TweakInject/test/xpcdictionarygetsniff.dylib", 0);
   // dlopen("/Library/TweakInject/test/spoofxpc.dylib", 0);
    
    // Insert code here to initialize your application
    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 800, 600)
                                                styleMask:(NSWindowStyleMaskTitled |
                                                              NSWindowStyleMaskClosable |
                                                              NSWindowStyleMaskResizable |
                                                              NSWindowStyleMaskMiniaturizable)
                                                      backing:NSBackingStoreBuffered
                                                     defer:NO];
    [self.window setTitle:@"EntDump"];
    
    self.vc = [[ViewController alloc] init];
    
    [self.window setContentViewController:self.vc];
    
    [self.window makeKeyAndOrderFront:nil];
    
    //NSPasteboard* dpb = [NSPasteboard pasteboardWithName:NSPasteboardNameDrag];
    
   /* dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *files = [dpb readObjectsForClasses:@[[NSURL class]] options:nil];
        for (NSURL *fileURL in files) {
            NSString *filePath = [fileURL path];
            NSLog(@"test: %@", filePath);
            NSLog(@"test: %d", access([filePath UTF8String], 4));
        }
    });
    */
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
