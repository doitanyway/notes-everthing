#  MySQL计算笔记

*  ``SELECT``两个``datetime``求时间差 以秒为单位  
   ``select (TIME_TO_SEC(tache_end_time) - TIME_TO_SEC(tache_start_time)) sec from evt_t_accept_flow WHERE id='00000000539703670153cefd685f75c8';
   ``  
*  两个``datetime``求时间差 以秒为单位  
   ``select (TIME_TO_SEC('2019-01-23 11:10:10') - TIME_TO_SEC('2019-01-23 10:10:10')) sec ;
   ``  

* 返回两个日期之间的天数差
  ``select DATEDIFF('2019-01-24 13:38:38','2018-11-12 16:48:49');
  ``  
* 用``TIME_TO_SEC``有负数，UNIX_TIMESTAMP这个更合理  
  ``select (UNIX_TIMESTAMP(STR_TO_DATE('2019-01-24 14:20:24','%Y-%m-%d %H:%i:%s')) - UNIX_TIMESTAMP(STR_TO_DATE('2019-01-23 14:20:24','%Y-%m-%d %H:%i:%s'))) sec ; 
  ``