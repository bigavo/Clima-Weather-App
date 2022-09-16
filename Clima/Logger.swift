import Foundation

public class Logger {
    func debug(_ message: @autoclosure () -> String) {
        #if DEBUG
        NSLog("%@", message())
        #endif
    }

    func info(_ message: @autoclosure () -> String) {
        let msg = message()
        NSLog("%@", msg)
    }

    func error(_ message: @autoclosure () -> String) {
        let msg = message()
        NSLog("%@", "🔴 " + msg)
    }
}

public let logger = Logger()
