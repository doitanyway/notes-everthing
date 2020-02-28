# 接口的组合

## 说明 

go语言中接口可以组合起来形成一个新的接口

## 例子

```go
type Retriever interface {
	Get(url string)string
}

type Poster interface {
	Post(url string, form map[string]string) string
}

type NewObject interface {
	Retriever
	Poster
}
```