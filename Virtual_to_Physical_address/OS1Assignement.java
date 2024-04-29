import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import java.io.FileReader;
import java.io.FileWriter;

public class OS1Assignement {

    public static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (int i = bytes.length-1; i>=0; i--) {
            sb.append(String.format("%02X", bytes[i]));
        }
        return sb.toString();
    }

    public static void main(String[] args) throws IOException {
        File fl = new File(args[0]); //input file name

        ArrayList<String> virtual_addresses = new ArrayList<String>();
        
        try{

            FileInputStream fis = new FileInputStream(fl);
            byte[] buffer = new byte[8];
            
            int i=0;
            while (fis.read(buffer) != -1) 
            {
                String address = bytesToHex(buffer); 
            
                //take last 8 bits of the address hexidecimal value
                virtual_addresses.add(address.substring(address.length() -8));
            }
            fis.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
       
        int[] pageTable = {2,4,1,7,3,5,6};
        ArrayList<String> physical_addresses = new ArrayList<String>();

        for (int y =0; y<virtual_addresses.size(); y++){
            
            // Parse the hexadecimal string to an integer
            int decimalValue = Integer.parseInt((virtual_addresses.get(y).toString()), 16);

            // Convert the integer to binary
            String binaryString = Integer.toBinaryString(decimalValue);

            // Pad with leading zeros to ensure a 12-bit representation
            String paddedBinary = String.format("%12s", binaryString).replace(' ', '0');

            // Extract the offset (rightmost 7 bits)    
            String offset = paddedBinary.substring(paddedBinary.length() -7);
            
            //Determine the memory block/page number (remaining 5 bits)
            String pageNum = paddedBinary.substring(0,paddedBinary.length() -7);

            //memory location pointer - index for page table array 
            int decimal = Integer.parseInt(pageNum, 2);

            //convert physical frame to binary value
           
            while (decimal>10){ //if the value is greater than the values 0 to 6
                decimal%=10;    //compute modulus to reduce it
            }
            if (decimal>6){
                decimal=0;
            }

            String physicalFrame = Integer.toBinaryString(pageTable[decimal]);

            //add the offset to the physical frame
            String physicalAddress = physicalFrame+offset;

            //adjust it to 12 bits
            physicalAddress = String.format("%12s", physicalAddress).replace(' ', '0');
            
            //convert it to hexidecimal value
            int physicalAddress_Decimal = Integer.parseInt(physicalAddress,2);
            String physicalAddress_Hex = (Integer.toHexString(physicalAddress_Decimal)).toUpperCase();

            // add the physical address to an arrayList
            physical_addresses.add("0x"+physicalAddress_Hex);
        }

        //write the physical addresses to output file 
        String filePath = "output.txt";

        // Convert ArrayList to the text file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String str : physical_addresses) {
                writer.write(str);
                writer.newLine();
            }
            System.out.println("ArrayList written to "+filePath+" successfully.");
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        
    }

    


}