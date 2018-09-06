package com.ibm.commerce.sample.commands;

import com.ibm.commerce.command.ControllerCommandImpl;
import com.ibm.commerce.datatype.TypedProperty;
import com.ibm.commerce.ejb.helpers.ECConstants;
import com.ibm.commerce.exception.ECException;

public class MyNewController2CmdImpl extends ControllerCommandImpl implements MyNewController2Cmd {
	
	public void performExecute() throws ECException{
		super.performExecute();
		TypedProperty properties = new TypedProperty();
		
		properties.put(ECConstants.EC_VIEWTASKNAME, "MyNewView2");
		setResponseProperties(properties);
	}
	


}