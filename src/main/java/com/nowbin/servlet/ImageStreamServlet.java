package com.nowbin.servlet;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.nowbin.util.StripXssUtil;

/**
 * Servlet implementation class ImageStreamServlet
 */
@WebServlet("/ImageStreamServlet")
public class ImageStreamServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private String defaultImageFile = "images/close1.png";	//默认图片
	
	private static Logger log = LoggerFactory.getLogger(ImageStreamServlet.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImageStreamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				
		String sessionParam=StripXssUtil.stripXSS(request.getParameter("code"));
		String fileName=(String)request.getSession().getAttribute(sessionParam);
				
		File file = new File(fileName);  		  
	    // 判断文件是否存在如果不存在就返回默认图片
	    if (!(file.exists() && file.canRead())) {  
	        file = new File(request.getSession().getServletContext().getRealPath("/") + this.defaultImageFile);  
	    }  
		
	    /*
		FileInputStream inputStream = new FileInputStream(file);
	    byte[] data = new byte[(int) file.length()];  
	    int length = inputStream.read(data);
	    inputStream.close(); 
	    */
	    Image img = ImageIO.read(file);
	    int width = img.getWidth(null);
        int height = img.getHeight(null);
        int w=900;
        int h=0;
        if(width <= w){
        	h=height;
        }else{
        	h=Integer.parseInt(new java.text.DecimalFormat("0").format(height * w/(width*1.0)));
        }
	    BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
	    Graphics g = bi.getGraphics();
        g.drawImage(img, 0, 0, w, h, Color.LIGHT_GRAY, null);
        g.dispose();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ImageIO.write(bi, "png", out);
        byte[] data=out.toByteArray();	    
	  
	    response.setContentType("image/png");
	    OutputStream stream = response.getOutputStream();  
	    stream.write(data);  
	    stream.flush();  
	    stream.close();
	    
	    //request.getSession().removeAttribute(sessionParam); //注销当前随机code
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
