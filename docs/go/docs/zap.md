# zap-日志


* [官方地址](https://github.com/uber-go/zap) 

## 安装 

```bash 
go get -u go.uber.org/zap
```

## 快速开始


In contexts where performance is nice, but not critical, use the SugaredLogger. It's 4-10x faster than other structured logging packages and includes both structured and printf-style APIs.

```go 
logger, _ := zap.NewProduction()
defer logger.Sync() // flushes buffer, if any
sugar := logger.Sugar()
sugar.Infow("failed to fetch URL",
  // Structured context as loosely typed key-value pairs.
  "url", url,
  "attempt", 3,
  "backoff", time.Second,
)
sugar.Infof("Failed to fetch URL: %s", url)
```

When performance and type safety are critical, use the Logger. It's even faster than the SugaredLogger and allocates far less, but it only supports structured logging.


```go 
logger, _ := zap.NewProduction()
defer logger.Sync()
logger.Info("failed to fetch URL",
  // Structured context as strongly typed Field values.
  zap.String("url", url),
  zap.Int("attempt", 3),
  zap.Duration("backoff", time.Second),
)
```
