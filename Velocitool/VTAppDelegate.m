#import "VTAppDelegate.h"
#import "VTDeviceLoader.h"
#import "MainWindowController.h"
#import "DeviceSettingsController.h"


@implementation VTAppDelegate

/**
 Returns the support folder for the application, used to store the Core Data
 store file.  This code uses a folder named "Velocitool" for
 the content, either in the NSApplicationSupportDirectory location or (if the
 former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"Velocitool"];
}



/**
 Primes the USB watch for new devices and launches the the main window
 */

// This is called for user switching, there is a need to release the devices then...
- (void)_switchHandler:(NSNotification*) notification {
    // Get the device loader to clear the USB devices asap.
    if ([[notification name] isEqualToString:NSWorkspaceSessionDidResignActiveNotification]) {
        // FIXME Perform deactivation tasks here.
    } else {
        // FIXME Perform activation tasks here.
    }    
}

- (void)applicationDidFinishLaunching:sender {
    
	// If fast user switching is used I need to release the USB devices. Or at least stop talking to them...
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(_switchHandler:) name:NSWorkspaceSessionDidBecomeActiveNotification object:nil];
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(_switchHandler:) name:NSWorkspaceSessionDidResignActiveNotification object:nil];

	// prime it
    _loader = [VTDeviceLoader loader]; // No need to retain: singleton
	
	// Create the main window
    mainWindowController = [[MainWindowController alloc] init];	
}

/**
 I can't believe I'm doing this.
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}



/**
 Implementation of dealloc, to release the retained variables.
 */

- (void) dealloc {
    
    _loader = nil;
    
    [super dealloc];
}


@end
