# helm dependency list

# 作用


List all of the dependencies declared in a chart.

This can take chart archives and chart directories as input. It will not alter the contents of a chart.

This will produce an error if the chart cannot be loaded. It will emit a warning if it cannot find a requirements.yaml.


## 格式

```
helm dependency list [flags] CHART

Options
  -h, --help   help for list
```