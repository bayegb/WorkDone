import java.io.*;
import java.util.*;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;
import java.lang.*;
import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class PMean extends RecursiveAction{

   private int srd;//the number of pixels above, below and beside the middle pixel
   private int p1;
   private int p2;
   private int meanCal;//the index of the median after the ArrayLists are sorted
   private int width;
   private int height;
   private int windowlength;
   private int OFFSET= 150000; //offset to determine the num,ber of threads used
   private int rvalues; //used to store the values of RGB for the window pixels
   private int gvalues;
   private int bvalues;
   private BufferedImage ig;
   private BufferedImage img;
   private int r,g,b;

   //Constructor- takes input image ,output image(the one to write the output) ,offset( makes sure x value is written at correct coordinates in the general output image)  
   PMean(BufferedImage image, BufferedImage image2, int windowLength){
      ig = image; //inputImage
      img = image2; //outputImage
      width = image.getWidth();
      height = image.getHeight();
      windowlength = windowLength;
      srd =(int)Math.floor(windowlength/2);//the number of pixels above, below and beside the middle pixel
      meanCal = windowlength*windowlength;
      rvalues =0;
      gvalues =0;
      bvalues =0;
      p1=0;
      p2=0;
      r=0;
      g=0;
      b=0;
   }

   protected void compute(){
     
      try{
      
         if ((width)*(height) < OFFSET){
            
            for(int x=srd ; x < width-srd; x++){
               for(int y=srd ; y < height-srd; y++){
               
                  //get window pixels 
                  for (int u =0; u< windowlength ; u++){
                     for (int z =0; z< windowlength ; z++){
                        p1 = ig.getRGB(x+z-srd,y+u-srd);
                        //get red
                        r = (p1>>16) & 0xff;

                        //get green
                        g = (p1>>8) & 0xff;

                        //get blue
                        b = p1 & 0xff;
                
                        rvalues += r;
                        gvalues += g;
                        bvalues += b;
                     }  
                  }

                  // calculation of the avarage of the window
                  int ravg = ((rvalues)/meanCal);
                  int gavg = ((gvalues)/meanCal);
                  int bavg = ((bvalues)/meanCal);
               
                  //pixel of the output image 
                  p2 = (255<<24)|(ravg<<16)|(gavg<<8)|bavg;
                  img.setRGB(x,y ,p2);
               
                  //initialize for next pixel calculation 
                  rvalues = 0;
                  gvalues = 0;
                  bvalues = 0;
               }
            }
            
      
         }else {
            int split = (width)/2;//x coordinate where image is separated into two
            
            //input image subImages
            BufferedImage leftSubimage = ig.getSubimage(0,0, split+(srd*2), height);//(srd*2) makes sure the edges(on the right of subimages) are filtered when images are split
            BufferedImage rightSubimage = ig.getSubimage(split, 0, width-split,height);
            
            //output image subImages
            BufferedImage outleftSubimage = img.getSubimage(0,0, split+(srd*2), height);//(srd*2) makes sure the edges(on the right of subimages) are filtered when images are split
            BufferedImage outrightSubimage = img.getSubimage(split, 0, width-split,height);

            PMean left = new PMean(leftSubimage, outleftSubimage, windowlength);//offset is zero - left region will always start at x=0,y=0 in the subimage and output image
            PMean right = new PMean(rightSubimage, outrightSubimage, windowlength);
         
            left.fork();
            right.compute();
            left.join();
            
         
          }
      }catch (Exception e) {
         e.printStackTrace();
       }
        
   }

   public static void main(String[] args) throws IOException {
      
      String inputImage = args[0];
      String outputImage = args[1];
      String windowWidth = (args[2]);
      
      File fl; 
      fl = new File(inputImage);
      BufferedImage ig1 = ImageIO.read(fl); //input image 
      int width = ig1.getWidth();
      int height = ig1.getHeight();
      
      BufferedImage img1 = new BufferedImage(width, height ,BufferedImage.TYPE_INT_RGB);
      
      int windowlength = Integer.parseInt(windowWidth); 
      
      PMean pmean = new PMean(ig1,img1, windowlength);
      ForkJoinPool fpool = new ForkJoinPool();
      fpool.invoke(pmean); 
      pmean.join();//wait the main thread until the other threads finish the filtering
      
      //write out after the filtering is done
      try{
         File fl2 = new File(outputImage);
         ImageIO.write(img1, "jpg", fl2); 
         System.out.println("Done");
      }catch (Exception e){
         e.printStackTrace();
      }
   }
}
          