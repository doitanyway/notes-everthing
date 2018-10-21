## PersistentVolumeClaim

### 前言

PersistentVolume(PV，持久卷):对存储抽象实现，使得存储作为集群中的资源。  
PersistentVolumeClaim(PVC，持久卷申请):PVC消费PV的资源。  
Pod申请PVC作为卷来使用，集群通过PVC查找绑定的PV，并Mount给Pod。  

PV 和PVC作为集群资源进行管理和分配。

