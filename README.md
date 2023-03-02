# TLogger

A description of this package.

#### Adding the dependency

`TLogger` is designed for Swift 5. To depend on the logging API package, you need to declare your dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/fanta1ty/TLogger", brand: "master"),
```

#### Let's log

```swift
// 1) let's import the logging API package
import Logger

// 2) we need to create a logger, the label works similarly to a DispatchQueue label
let logger = TLogger()

// 3) we're now ready to use it
logger.log(level: .info, message: "Hello World", tag: "message")
```
#### Output

```
2023-03-02T17:22:57+0700 info TLogger : tag=message [] Hello World
```
