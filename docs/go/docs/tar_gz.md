# 压缩解压tar.gz

## 说明

本文说明如何压缩和解压tar.gz包。

## 例子


```go 
package main

import (
	"archive/tar"
	"compress/gzip"
	"io"
	"os"
	"path"
)

//解压tar.gz
//srcFilePath - 源路径
//destDirPath - 目标路径
func UnCompress(srcFilePath string, destDirPath string) error {
	os.Mkdir(destDirPath, os.ModePerm)


	fr, err := os.Open(srcFilePath)
	if err != nil {
		return err
	}
	defer fr.Close()


	gr, err := gzip.NewReader(fr)
	if err != nil {
		return err
	}
	defer gr.Close()


	tr := tar.NewReader(gr)
	for {
		hdr, err := tr.Next()
		if err == io.EOF {
			break
		}


		if hdr.Typeflag != tar.TypeDir {
			os.MkdirAll(destDirPath+"/"+path.Dir(hdr.Name), os.ModePerm)


			fw, _ := os.OpenFile(destDirPath+"/"+hdr.Name, os.O_CREATE|os.O_WRONLY, os.FileMode(hdr.Mode))
			if err != nil {
				return err
			}
			_, err = io.Copy(fw, tr)
			if err != nil {
				return err
			}
		}
	}
	return nil
}


//srcDirPath 源文件路径
//destFilePath 压缩后到文件
func Compress(srcDirPath string, destFilePath string) error {
	fw, err := os.Create(destFilePath)
	if err != nil {
		return err
	}
	defer fw.Close()


	gw := gzip.NewWriter(fw)
	defer gw.Close()


	tw := tar.NewWriter(gw)
	defer tw.Close()


	f, err := os.Open(srcDirPath)
	if err != nil {
		return err
	}
	fi, err := f.Stat()
	if err != nil {
		return err
	}
	if fi.IsDir() {
		err = compressDir(srcDirPath, path.Base(srcDirPath), tw)
		if err != nil {
			return err
		}
	} else {
		err := compressFile(srcDirPath, fi.Name(), tw, fi)
		if err != nil {
			return err
		}
	}
	return nil
}

func compressDir(srcDirPath string, recPath string, tw *tar.Writer) error {
	dir, err := os.Open(srcDirPath)
	if err != nil {
		return err
	}
	defer dir.Close()


	fis, err := dir.Readdir(0)
	if err != nil {
		return err
	}
	for _, fi := range fis {
		curPath := srcDirPath + "/" + fi.Name()


		if fi.IsDir() {
			err = compressDir(curPath, recPath+"/"+fi.Name(), tw)
			if err != nil {
				return err
			}
		}


		err = compressFile(curPath, recPath+"/"+fi.Name(), tw, fi)
		if err != nil {
			return err
		}
	}
	return nil
}

func compressFile(srcFile string, recPath string, tw *tar.Writer, fi os.FileInfo) error {
	if fi.IsDir() {
		hdr := new(tar.Header)
		hdr.Name = recPath + "/"
		hdr.Typeflag = tar.TypeDir
		hdr.Size = 0
		hdr.Mode = int64(fi.Mode())
		hdr.ModTime = fi.ModTime()


		err := tw.WriteHeader(hdr)
		if err != nil {
			return err
		}
	} else {
		fr, err := os.Open(srcFile)
		if err != nil {
			return err
		}
		defer fr.Close()


		hdr := new(tar.Header)
		hdr.Name = recPath
		hdr.Size = fi.Size()
		hdr.Mode = int64(fi.Mode())
		hdr.ModTime = fi.ModTime()


		err = tw.WriteHeader(hdr)
		if err != nil {
			return err
		}


		_, err = io.Copy(tw, fr)
		if err != nil {
			return err
		}
	}
	return nil
}

func main() {
	//压缩
	srcDirPath := "/home/zzy/go/src/test/aaa.go"
	destFilePath := "/home/zzy/go/src/test/test.tar.gz"
	Compress(srcDirPath, destFilePath)
	//解压
	srcFilePath := "/home/zzy/go/src/test/test.tar.gz"
	destDirPath := "/home/zzy/go/src/test/."
	UnCompress(srcFilePath, destDirPath)
}

```