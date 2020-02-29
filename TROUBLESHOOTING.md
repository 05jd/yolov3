## 1. Installation


### pytorch 1.4 install error

Install pytorch 1.4 by the following command.  
```bash
 $ pip install torch===1.4.0 torchvision===0.5.0 -f https://download.pytorch.org/whl/torch_stable.html
```

### No module named Cython. 

If you got installation error with `Cypthon` module during dependency installation through `pip install -r requirements.txt`
Separately install `cpython` package.
```bash
 $ pip install cpython 
```

## 2. Training 

### AssertionError. No label found. (Data path error) 

`get_cocoxxxx.sh` downloads COCO dataset with information files,
but those files have hard-coded paths.
So COCO data path should be located at the parent of yolov3 repository.
```
  parent directory
  -- yolov3
  -- coco
```
Please move `coco/` to the right location, then this issue will be resolved. 
