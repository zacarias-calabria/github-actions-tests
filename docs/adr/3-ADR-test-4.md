---
status: "approved"
date: 2024-12-15
decision-makers: [Zacarías Blanco, Maria Rodriguez, Carlos Silva]
consulted: [ReactPHP Community, Senior PHP Developers, DevOps Team]
informed: [Development Team, QA Team, Product Manager]
---

# Use ReactPHP for Real-time Socket Server Implementation

## Context and Problem Statement

Our e-learning platform needs to implement a real-time notification system to deliver instant updates to students and teachers about course activities, assignments, and messages. The current synchronous PHP architecture cannot handle the concurrent connection requirements efficiently. We need to choose a technology that can handle thousands of simultaneous connections while maintaining low latency and integrating seamlessly with our existing PHP-based infrastructure.

<!-- This is an optional element. Feel free to remove. -->
## Decision Drivers

* Need to support 5000+ concurrent WebSocket connections
* Maintain compatibility with existing PHP codebase and team expertise
* Low memory footprint and efficient resource utilization
* Real-time message delivery with sub-second latency
* Easy deployment and monitoring in our current Docker infrastructure
* Strong community support and long-term maintenance
* Integration with existing authentication and user management systems

## Considered Options

* ReactPHP with Ratchet WebSocket library
* Swoole PHP extension with coroutines
* Node.js with Socket.IO framework
* Go with Gorilla WebSocket implementation
* Laravel WebSockets (based on ReactPHP)

## Decision Outcome

Chosen option: "ReactPHP with Ratchet WebSocket library", because it provides the best balance between performance requirements and team expertise, while offering seamless integration with our existing PHP ecosystem and minimal infrastructure changes.

<!-- This is an optional element. Feel free to remove. -->
### Consequences

* Good, because leverages existing PHP knowledge and reduces learning curve
* Good, because provides event-driven, non-blocking I/O for high concurrency
* Good, because integrates naturally with Composer and existing libraries
* Good, because maintains consistency with current codebase architecture
* Good, because offers excellent debugging tools and error handling
* Bad, because may require careful memory management in long-running processes
* Bad, because PHP performance may not match compiled languages for CPU-intensive tasks
* Bad, because debugging asynchronous code can be more complex than synchronous flow

<!-- This is an optional element. Feel free to remove. -->
### Confirmation

The implementation compliance will be confirmed through:
- Load testing with 5000+ concurrent connections using Artillery.io
- Memory profiling during 24-hour stress tests to ensure no memory leaks
- Code review checklist ensuring proper event loop usage and error handling
- Integration tests validating authentication flow and message delivery
- Performance benchmarks comparing latency with previous synchronous implementation
- Monitoring dashboards tracking connection count, memory usage, and response times

<!-- This is an optional element. Feel free to remove. -->
## Pros and Cons of the Options

### ReactPHP with Ratchet WebSocket library

Event-driven, non-blocking I/O library for PHP with WebSocket support through Ratchet package.

* Good, because utilizes existing PHP team expertise and reduces training overhead
* Good, because provides mature event loop implementation with excellent documentation
* Good, because integrates seamlessly with Composer dependency management
* Good, because offers built-in support for WebSocket protocol and HTTP upgrade handling
* Good, because maintains compatibility with existing authentication and session systems
* Neutral, because requires understanding of asynchronous programming concepts
* Bad, because PHP may have performance limitations compared to compiled languages
* Bad, because long-running processes require careful memory management

### Swoole PHP extension with coroutines

High-performance PHP extension providing coroutines and async I/O capabilities.

* Good, because offers superior raw performance compared to pure PHP solutions
* Good, because provides built-in HTTP and WebSocket server implementations
* Good, because coroutines simplify asynchronous code compared to callbacks
* Bad, because requires installing C extension which complicates deployment
* Bad, because smaller community and less mature ecosystem compared to ReactPHP
* Bad, because potential compatibility issues with existing PHP libraries

### Node.js with Socket.IO framework

JavaScript runtime with real-time bidirectional event-based communication library.

* Good, because JavaScript is naturally suited for event-driven programming
* Good, because Socket.IO provides excellent browser compatibility and fallback mechanisms
* Good, because large ecosystem and mature tooling for real-time applications
* Bad, because requires complete technology stack change from PHP
* Bad, because team would need extensive training on Node.js ecosystem
* Bad, because integration with existing PHP authentication system would be complex

### Go with Gorilla WebSocket implementation

Compiled language with built-in concurrency support and WebSocket library.

* Good, because compiled language offers excellent performance and memory efficiency
* Good, because Go's goroutines provide natural concurrency model for WebSocket handling
* Good, because static binary deployment simplifies infrastructure management
* Bad, because requires complete rewrite and technology stack migration
* Bad, because team has no existing expertise in Go programming language
* Bad, because integration with PHP systems would require API-based communication

### Laravel WebSockets (based on ReactPHP)

Laravel package providing WebSocket server functionality built on ReactPHP.

* Good, because provides Laravel integration and familiar API patterns
* Good, because leverages ReactPHP performance with Laravel conventions
* Neutral, because adds another abstraction layer over ReactPHP
* Bad, because our project doesn't use Laravel framework
* Bad, because introduces unnecessary Laravel dependencies for non-Laravel project

<!-- This is an optional element. Feel free to remove. -->
## More Information

This decision will be implemented in Phase 1 of the real-time features roadmap (Q1 2025). The team has allocated 2 weeks for initial prototype development and performance testing. A fallback plan using traditional polling mechanisms will be maintained during the transition period. The decision should be re-evaluated if connection requirements exceed 10,000 concurrent users or if significant performance issues emerge during production deployment.

Related documentation:
- [ReactPHP Official Documentation](https://reactphp.org/)
- [Ratchet WebSocket Documentation](http://socketo.me/)
- [Internal PHP Performance Guidelines](../guidelines/php-performance.md)
- [Load Testing Procedures](../testing/load-testing.md)

## Test changes
- Change 1: Don't trigger ADR notification.
- Change 2: Don't trigger ADR notification.
- Change 3: Triger ADR notification.
- Change 4: Don't trigger ADR notification.
- Change 5: Triger ADR notification.
- Change 6: Triger ADR notification.
- Change 7: Triger ADR notification.