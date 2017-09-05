# Pie chart

```
<html>

<head>
    <meta charset="utf-8">
    <link href="../build/nv.d3.css" rel="stylesheet" type="text/css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.2/d3.min.js" charset="utf-8"></script>
    <script src="../build/nv.d3.js"></script>
    <style>
        text {
            font: 12px sans-serif;
        }

        svg {
            display: block;
            float: left;
            height: 500px !important;
            width: 500px !important;
        }

        html,
        body {
            margin: 0px;
            padding: 0px;
            height: 100%;
            width: 100%;
        }
    </style>
</head>

<body>
    <svg id="test1" class="mypiechart"></svg>
    <script>
        var testdata2 = [
            { key: "One", y: 5 },
            { key: "Two", y: 2 },
            { key: "Three", y: 9 },
            { key: "Four", y: 7 },
            { key: "Five", y: 4 },
            { key: "Six", y: 3 },
            { key: "Seven", y: 0.5 }
        ];

        var height = 500;
        var width = 500;

        nv.addGraph(function () {
            var chart = nv.models.pieChart()
                .x(function (d) { return d.key })
                .y(function (d) { return d.y })
                .width(width)
                .height(height)
                .showTooltipPercent(true);

            d3.select("#test1")
                .datum(testdata2)
                .transition().duration(1200)
                .attr('width', width)
                .attr('height', height)
                .call(chart);
            return chart;
        });

    </script>

</body>

</html>
```