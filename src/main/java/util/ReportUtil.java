package util;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.ServletContext;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@SuppressWarnings( {"rawtypes", "unchecked"} )
public class ReportUtil implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public byte[] generateReportPDF(List dataList, String nameReportFile, ServletContext servletContext) throws Exception {
		JRBeanCollectionDataSource jrbds = new JRBeanCollectionDataSource(dataList);
		
		String reportJasperWay = servletContext.getRealPath("report") + File.separator + nameReportFile + ".jasper";
		
		JasperPrint jasperPrinter = JasperFillManager.fillReport(reportJasperWay, new HashMap(), jrbds);
		
		return JasperExportManager.exportReportToPdf(jasperPrinter);
	}

}
