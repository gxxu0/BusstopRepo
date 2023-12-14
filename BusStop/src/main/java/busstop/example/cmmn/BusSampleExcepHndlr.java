package busstop.example.cmmn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

public class BusSampleExcepHndlr implements ExceptionHandler{
	private static final Logger LOGGER = LoggerFactory.getLogger(BusSampleExcepHndlr.class);
	
	public void occur(Exception ex, String packageName) {
		LOGGER.debug(" BusServiceExceptionHandler run...............");
	}
}
