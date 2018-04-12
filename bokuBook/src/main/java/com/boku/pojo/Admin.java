package com.boku.pojo;

public class Admin {
    
    private String adminUsername;

    
    private String adminPassword;

    
    public String getAdminUsername() {
        return adminUsername;
    }

    
    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername == null ? null : adminUsername.trim();
    }

    
    public String getAdminPassword() {
        return adminPassword;
    }

    
    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword == null ? null : adminPassword.trim();
    }


	@Override
	public String toString() {
		return "Admin [adminUsername=" + adminUsername + ", adminPassword=" + adminPassword + "]";
	}
    
}