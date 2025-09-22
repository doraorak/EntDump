#import "MachODropView.h"
#import "ResultWindow.h"

@implementation MachODropView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    }
    return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        return NSDragOperationCopy;
    }
    
    return NSDragOperationNone;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    if ([[pboard types] containsObject:NSPasteboardTypeFileURL]) {
        NSArray *files = [pboard readObjectsForClasses:@[[NSURL class]] options:nil];
        for (NSURL *fileURL in files) {
            NSString *filePath = [fileURL path];
            
            NSLog(@"Dropped file: %@", filePath);

            if ([self isAppOrMachOFile:filePath]) {
                //NSLog(@"dropped file is app or macho");
                [self handleDroppedFile:filePath];
                return YES;
            }
            else {
                NSLog(@"dropped file is not app or macho");
            }
        }
    }
    return NO;
}

- (BOOL)isAppOrMachOFile:(NSString *)filePath {
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:0];
    
    if (!exists){
        NSLog(@"file does not exist");
        return NO;
    }
    
    // Check for .app bundle
    if ([[filePath pathExtension] isEqualToString:@"app"]) {
        NSLog(@"dropped file is app");
        self.isApp = YES;
        return YES;
    }
    
    // Check for Mach-O file
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (fh) {
        NSData *magic = [fh readDataOfLength:4];
        [fh closeFile];
        if (magic.length == 4) {
            const uint32_t *magicNum = (const uint32_t *)magic.bytes;
            switch (magicNum[0]) {
                case 0xFEEDFACE: // 32-bit Mach-O
                case 0xFEEDFACF: // 64-bit Mach-O
                case 0xCAFEBABE: // Fat binary
                case 0xCEFAEDFE: // 32-bit Mach-O (little)
                case 0xCFFAEDFE: // 64-bit Mach-O (little)
                case 0xBEBAFECA: // Fat binary (little)
                    NSLog(@"dropped file is macho");
                    self.isApp = NO;
                    return YES;
            }
        }
    }
    
    return NO;
}

- (void)handleDroppedFile:(NSString *)filePath {
    
    NSArray* arr = nil;
    
    if (self.isApp) {
        // If it's an app, find the main executable
        NSURL *appURL = [NSURL fileURLWithPath:filePath];
        appURL = [NSURL URLByResolvingAliasFileAtURL:appURL options:0 error:0];
        filePath = [appURL path];
        
        NSBundle *bundle = [NSBundle bundleWithPath:filePath];
        NSString *executableName = [bundle objectForInfoDictionaryKey:@"CFBundleExecutable"];
  
        if (executableName) {
            filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Contents/MacOS/%@", executableName]];
            arr = GetEntitlements(filePath);
        } else {
            NSLog(@"Could not find CFBundleExecutable in Info.plist");
            return;
        }
    } else {
        // If it's a Mach-O file, use it directly
        arr = GetEntitlements(filePath);
    }
    
    if (arr == nil) {
        NSLog(@"No entitlements found or error occurred.");
        return;
    }
    
    NSLog(@"Entitlements: %@", arr);
    
    ResultWindow *resultWindow = [[ResultWindow alloc] initWithEntitlements:arr ContentRect:NSMakeRect(0, 0, 400, 400) styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable) backing:NSBackingStoreBuffered defer:NO title:[NSString stringWithFormat:@"Entitlements for %@", [filePath lastPathComponent]] path:filePath];
    
    [resultWindow center];
    [resultWindow makeKeyAndOrderFront:nil];
    
}

@end
