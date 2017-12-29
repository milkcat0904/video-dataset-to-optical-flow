从视频数据集提取光流图，RGB,warped光流图 
=
Extract optical flow，RGB，warped optical flow from video dataset
=

### 1.下载和解压 Download & Unzip

* 直接下载或者使用指令下载：
		
		$ git clone --recursive https://github.com/milkcat0904/video-dataset-to-optical-flow.git
	
* $ unzip video-dataset-to-optical-flow-master.zip

* 下载数据集 [UCF-101][ucf101]，[HMDB51][hmdb51] 等

### 2.编译环境 Build
	
	build opencv 2.4.13 和 dense_flow 环境

		$ bash build_all.sh
		
	终端输出"All tools built. Happy experimenting!" 表示build成功


### 3.提取光流 Etract optical flow

	$ bash scripts/extract_optical_flow.sh DATASET_PATH OUT_PATH NUMBER_OF_WORKER
	
	DATASET_PATH : 数据集的地址
	
	OUT_PATH ：生成光流图的地址
	
	NUMBER_OF_WORKER ：工作的显卡数量，一般设置为2
	
### 4.提取warped光流图 Etract warped flow

* 将`tools/build_of.py`的第89行`--flow_type`的默认值改为`warped_tv11`：

```python
parser.add_argument("--flow_type", type=str, default='warped_tvl1', choices=['tvl1', 'warp_tvl1'])
```

* $ bash scripts/extract_optical_flow.sh DATASET_PATH OUT_PATH NUMBER_OF_WORKER



[ucf101]:http://crcv.ucf.edu/data/UCF101.php
[hmdb51]:http://serre-lab.clps.brown.edu/resource/hmdb-a-large-human-motion-database/


	
	
