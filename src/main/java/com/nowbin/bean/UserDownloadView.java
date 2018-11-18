package com.nowbin.bean;

public class UserDownloadView extends UserDownload{
	
	private User applyuser;
	
	private Admin checkuser;
	
	public User getApplyUser() {
        return applyuser;
    }

    public void setApplyUser(User applyuser) {
        this.applyuser = applyuser;
    }
    
    public Admin getCheckUser() {
        return checkuser;
    }

    public void setCheckUser(Admin checkuser) {
        this.checkuser = checkuser;
    }
}
