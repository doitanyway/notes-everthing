urpcs_recovered
UrpcsRecovered


RecoveredRepository


	private  Boolean firstReg = null; //首次注册 - true  二次注册 - false
	private Integer staticTimeTs = null;//静止时间，时间戳


    System.out.println("test:"+TimeUtils.timeFormat(1529547711));
    if(report.isTagLeave()){//如果当前标签为离开状态
					report.setTagLeaveTime(DataUtil.getElementToInt(list, pos, 4));
				}