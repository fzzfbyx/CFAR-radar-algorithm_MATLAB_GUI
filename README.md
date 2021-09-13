## 1、内容简介
 &nbsp;  &nbsp; &nbsp;  &nbsp;利用MATLAB GUI设计平台，设计多算法雷达一维恒虚警检测CFAR可视化界面，通过选择噪声类型、目标类型、算法类型，手动输入相关参数，可视化显示噪声波形与目标检测的回波-检测门限波形图。运行cfar.m即可调用GUI进行参数输入输出。
 ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513184019391.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyNjc5NTcz,size_16,color_FFFFFF,t_70)
## 2、原理简介
 &nbsp;  &nbsp; &nbsp;  &nbsp;恒虚警检测技术（CFAR）是指雷达系统在保持虚警概率恒定条件下对接收机输出的信号与噪声作判别以确定目标信号是否存在的技术。
  &nbsp;  &nbsp; &nbsp;  &nbsp;前提：由于接收机输出端中肯定存有噪声(包括大气噪声、人为噪声、内部噪声和杂波等)，而信号一般是叠加在噪声上的。这就需要在接收机输出的噪声或信号加噪声条件下，采用检测技术判别是否有目标信号。
    &nbsp;  &nbsp; &nbsp;  &nbsp;误差概率：任何形式的判决必然存在着两种误差概率：发现概率和虚警概率。当接收机输出端存在目标回波信号，而判决时判为有目标的概率为Pd，判为无目标的概率为1-Pad。当接收机输出端只有噪声时，而判为有目标的概率为Pfa。由于噪声是随机变量，其特征可用概率密度函数表示，因此信号加噪声也是一随机变量
  &nbsp;  &nbsp; &nbsp;  &nbsp; 具体过程：恒虚警检测器首先对输入的噪声进行处理后确定一个门限，将此门限与输入端信号相比，如输入端信号超过了此门限，则判为有目标，否则，判为无目标。  
   &nbsp;  &nbsp; &nbsp;  &nbsp;  算法：①均值类CFRA：核心思想是通过对参考窗内采样数据取平均来估计背景功率。CA-CFAR（单元平均恒虚警）、GO-CFAR（最大选择恒虚警）、SO-CFAR（最小选择恒虚警）算法这三个是最经典的均值类CFAR算法。
      &nbsp;  &nbsp;     &nbsp;  &nbsp; &nbsp;  &nbsp;     &nbsp;  &nbsp; &nbsp;  ②统计有序CFAR：核心思想：通过对参考窗内的数据由小到大排序选取其中第K个数值假设其为杂波背景噪声。OS-CFAR（有序统计恒虚警）为其经典算法。
      
## 3、实现功能
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513175854839.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyNjc5NTcz,size_16,color_FFFFFF,t_70)
实现的功能有：

1、类型选择：① 噪声类型：均匀背景噪声和杂波边缘背景噪声。均匀背景噪声为单一功率的噪声，在参数输入界面输入噪声功率2，噪声长度2，噪声方差即可（噪声功率1、噪声长度1被禁用）；杂波边缘背景噪声为两种不同功率噪声的组合，需要分别输入噪声1和噪声2的功率与长度，方差两噪声共用。
 &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;②目标类型：单目标与多目标。选择单目标时只需输入目标1的信噪比与位置即可（其他目标被禁用）；选择多目标时，需要分别输入目标1-4的信噪比与位置，其中当噪声类型为杂波边缘背景噪声时，还需分别输入靠近杂波边缘与杂波内目标的信噪比与位置，便于区别对比。
  &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;③算法类型：CA-CFAR、GO-CFAR、SO-CFAR、OS-CFAR，四种算法任选一种即可。

2、产生噪声&噪声波形图：完成噪声类型选择与噪声参数输入后，单击产生噪声按钮即可产生噪声波形图，在左下方进行显示。

3、参数输入：① 噪声功率1/2:噪声功率大小，单位db，变量名为db1、db2。
 &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;②噪声长度1/2:噪声的长度，其中噪声长度2为噪声总长（包括了噪声长度1），变量名为shape1、shape2。
  &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;③噪声方差：两段噪声共用的方差，变量名为varience。
    &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;④信噪比1/2/3/4/5/6:每个目标的信噪比，变量名为SNR1/2/3/4/5/6。
    &nbsp;   &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;⑤目标位置1/2/3/4、杂波边缘位置，杂波内位置：各目标位置，需要小于最大噪声长度，其中杂波边缘位置应为两段噪声交界处，杂波内位置应在杂波内，变量名为des1/2/3/4/5/6。
   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;⑥单元数目：总检测单元个数，变量名为N。
   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;⑦保护单元数目：目标的功率可能泄露到相邻的单元中，所以和目标相邻的数个单元不作为背景杂波的估计，作为保护单元，变量名为pro_N。
   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;&nbsp;  &nbsp;⑧虚警概率：恒虚警检测保持的错误检测概率，变量名为PAD。
						 

4、输出结果&回波-检测门限关系图：产生噪声，输入目标参数，选择算法后，单击输出结果按钮，即可在右侧得到回波-检测门限关系图。

5、左/右图导出：分别将噪声波形图与回波-检测门限关系图导出保存，可选的格式有jpg、png、bmp、eps。

## 4、操作实例
选取噪声类型为“杂波边缘背景噪声”，目标类型为多目标，算法类型选择CA-CFAR，参数输入为默认输入（噪声功率1/2：20db、30db；噪声长度1/2:100、200；噪声方差：200；信噪比1/2/3/4/5/6:15、12、8、5、5、5；目标位置1/2/3/4、杂波边缘位置、杂波内位置：30、40、50、60、95、120；单元个数：36；保护单元个数：2；虚警概率：0.001），得到结果如下图所示：![在这里插入图片描述](https://img-blog.csdnimg.cn/20200513183948353.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQyNjc5NTcz,size_16,color_FFFFFF,t_70)从回波-检测门限图可以看出，该算法在低噪声环境中目标检测性能良好，实现恒虚警检测，但在杂波边缘与杂波内部检测性能显著下降。
## 5、算法与参数分析
算法分析：
CA-CFAR：优点：损失率最少的一种算法；
 &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; 缺点：多目标遮掩，杂波边缘性能也欠佳；
 GO-CFAR：优点：杂波边缘区域虚警概率降低
			 &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; 			缺点：多目标遮掩
SO-CFAR： 优点：多目标效果有改进；
 &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; 			缺点：杂波边缘区域虚警概率提升；
 OS-CFAR：优点：多目标检测性能很好；
 &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp; &nbsp; 	缺点：杂波边缘区域虚警概率提高；
 参数分析：
 检测单元数：在相同信噪比下，检测单元数越多的CFAR对应的检测概率越高，但同时计算量加大。
 虚警概率：在相同检测单元数目下，虚警概率的越高CFAR对应的检测概率越高，但虚警数也增多。
 信噪比：当信噪比不断增加，检测概率也不断增加。
 保护单元数：保护单元过大或过小都会使检测概率降低，应不同实验选取适中的保护单元数。
## 6、声明

本项目是本人基于其他CFAR文章的二次分析与开发，原文地址为：https://www.cnblogs.com/Mufasa/p/10900334.html，若有侵权请及时告知。

CSDN地址为：https://blog.csdn.net/qq_42679573/article/details/106103729

新人学生博主，致力于信号分析。若觉得有用的话请关注一波呦~