# 迷宫算法-广度优先算法程序

## 前言

本文使用广度优先算法计算最短的走完迷宫的路径，所谓广度优先算法，既为每次探索的时候先把周边的所有节点探索了，再去探索新的节点

## 例子

* 迷宫文件``maze/maze.in``  
```
6 5
0 1 0 0 0
0 0 0 1 0
0 1 0 1 0
1 1 1 0 0
0 1 0 0 1
0 1 0 0 0
```


* 程序``maze/maze.go``  

```go 
package main

import (
	"fmt"
	"os"
)

type point struct {
	i,j int
}

func readMaze(filename string) [][]int {
	file, err := os.Open(filename);
	if err != nil{
		panic(err)
	}

	var row,col int
	fmt.Fscanf(file,"%d %d",&row,&col)

	maze := make([][]int ,row)

	for i := range maze{
		maze[i] = make([]int ,col)
		for j := range maze[i] {
			fmt.Fscanf(file,"%d",&maze[i][j])
		}
	}
	return maze
}

//上左下右
var dirs = []point{
	{-1,0},{0,-1},{1,0},{0,1},
}

//值引用规返回一个新的point
func (p point) add(r point) point  {
	return point{p.i + r.i, p.j + r.j}
}

//查看数组内某一个值
func (p point) at(grid [][]int)(int ,bool)  {
	if p.i<0  || p.i >= len(grid){
		return  0 ,false
	}
	if p.j <0 || p.j >= len(grid[p.i]){
		return 0, false
	}
	return grid[p.i][p.j],true
}

func walk(maze [][]int , start,end point) [][]int   {
	steps :=  make([][]int ,len(maze))
	for i:= range  steps {
		steps[i] = make([]int ,len(maze[i]))
	}
	Q := []point{start}

	for len(Q) >0  {
		cur := Q[0]
		Q = Q[1:]

		if cur == end {
			break
		}

		for _,dir := range dirs{
			next := cur.add(dir)
			// maze at next  is 0   (可以走)
			// and step at next  is 0 （已经走过了）
			// next != start
			val, ok := next.at(maze)
			if !ok || val == 1{	//位置合法，不是墙 1
				continue  //继续探索下一个点
			}
			val, ok = next.at(steps)
			if !ok || val != 0{	//还没有探索过
				continue  //继续探索下一个点
			}
			if next == start{//next != start
				continue
			}
			curSteps ,_ := cur.at(steps)
			steps[next.i][next.j] = curSteps+1
			Q= append(Q,next)
		}
	}
	return steps
}


func main() {
	maze := readMaze("maze/maze.in")
	fmt.Println("maze............")
	for _, row := range maze{
		for _, val := range row  {
			fmt.Printf("%d ",val)
		}
		fmt.Println()
	}

	steps := walk(maze,
			point{0,0},
			point{len(maze)-1,len(maze[0])-1})
	fmt.Println("steps............")
	for _, row := range steps{
		for _, val := range row  {
			fmt.Printf("%3d ",val)
		}
		fmt.Println()
	}
}

```