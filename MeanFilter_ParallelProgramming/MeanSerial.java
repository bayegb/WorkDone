import java.io.*;
import java.util.*;
import java.lang.*;
import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;



public class MeanSerial 
{
   public static void main(String[] args) throws IOException
   {
   
      String inputImage = args[0];
      String outputImage = args[1];
      String windowWidth = args[2];   

      //get an image 
      File fl; 
      fl = new File(inputImage);
      BufferedImage ig = ImageIO.read(fl);//reads image file (input)
      
      int width = ig.getWidth();
      int height = ig.getHeight();
      
      BufferedImage img = new BufferedImage(width, height ,BufferedImage.TYPE_INT_RGB);//writes output
      
      int windowlength = Integer.parseInt(windowWidth);
      
      //used to store the values of RGB for the window pixels
      int rvalues =0;
      int gvalues =0;
      int bvalues =0;
      
      int surroundingPixels = (int)Math.floor(windowlength/2);//the number of pixels above, below and beside the middle pixel
      int p1=0;//pixel one (pixel on the input image)
      int p2=0;//pixel two (pixel on the output image)
      int averageCal = windowlength*windowlength;//the value to divide by when calculating the average of RGB
      
      try{

         //get coordinates of p1(pixel 1) - middle pixel in a window    
         for(int y = surroundingPixels; y < height-surroundingPixels; y++){
            for (int x = surroundingPixels; x < width-surroundingPixels; x++){   
               
               //get window pixels
               for (int z=0 ; z< windowlength ;z++){
                  for ( int u=0 ; u< windowlength ; u++){
                     p1 = ig.getRGB(x+u-surroundingPixels,y+z-surroundingPixels);
                     
                     //get red 
                     int r = (p1>>16) & 0xff;

                     //get green
                     int g = (p1>>8) & 0xff;

                     //get blue
                     int b = p1 & 0xff;
                
                     rvalues += r;
                     gvalues += g;
                     bvalues += b;
                  }   
               }

               // calculation of the avarage of the window
               int ravg = ((rvalues)/averageCal);
               int gavg = ((gvalues)/averageCal);
               int bavg = ((bvalues)/averageCal);
               
               //pixel of the output image 
               p2 = (255<<24)|(ravg<<16)|(gavg<<8)|bavg;
               img.setRGB(x,y ,p2);
               
               //initialize for next pixel calculation 
               rvalues = 0;
               gvalues = 0;
               bvalues = 0;
                  
            }
         }
          
     //write output image 
     fl  = new File(outputImage);
     ImageIO.write(img, "jpg", fl);
     System.out.println("Done");

   }catch (Exception e){
      e.printStackTrace();
   }
   
   }
}