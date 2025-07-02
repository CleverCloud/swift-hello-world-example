import Foundation
import Glibc

// Create socket
let s = socket(2, 1, 0)
var reuse: Int32 = 1
setsockopt(s, 1, 2, &reuse, 4)

// Setup address
var addr = sockaddr_in()
addr.sin_family = 2
addr.sin_port = htons(8080)
addr.sin_addr.s_addr = 0

// Bind socket
_ = withUnsafePointer(to: &addr) {
    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        bind(s, $0, 16)
    }
}

listen(s, 10)
print("Server running on http://0.0.0.0:8080")

// Handle Ctrl+C
signal(2) { _ in exit(0) }

// Main server loop
while true {
    // Accept connection
    var clientAddr = sockaddr_in()
    var len = socklen_t(16)
    let c = withUnsafeMutablePointer(to: &clientAddr) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            accept(s, $0, &len)
        }
    }

    // Read request (ignore content)
    var buf = [UInt8](repeating: 0, count: 1024)
    recv(c, &buf, 1024, 0)

    // Send response
    let resp = "HTTP/1.1 200 OK\r\nContent-Length: 14\r\n\r\nHello, from Swift on Clever Cloud!\n"

    _ = resp.data(using: .utf8)?.withUnsafeBytes {
        send(c, $0.bindMemory(to: UInt8.self).baseAddress, $0.count, 0)
    }

    // Close connection
    close(c)
}

