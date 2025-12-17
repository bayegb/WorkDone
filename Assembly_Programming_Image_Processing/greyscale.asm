.data
    filename: .asciiz "C:/Users/Baye Saliou Fall/OneDrive - University of Cape Town/CSC2002S/Assignments2023/ArchAssignment2023/ArchitectureAssignment/sample_images/house_64_in_ascii_crlf.ppm"
    v1:  .space  50000    # used to store the converted integers (from string to int)
    file:   .space 100000
    .align  2
    output:   .asciiz "C:/Users/Baye Saliou Fall/OneDrive - University of Cape Town/CSC2002S/Assignments2023/ArchAssignment2023/ArchitectureAssignment/sample_images/output.ppm"
    .align  2
    values:   .space 100000   #store the output string(the new RGB values)
    nl: .asciiz "\n" 
    header: .asciiz "P2\n"    #for the new image

.text
.globl main

main:
#open ...
    li      $v0,13      #service to open file
    la      $a0,filename
    li      $a1,0       #file flag = read(0)
    li	    $a2,0
    syscall
    move    $s0,$v0     #file descriptor
 
#and read the file ...
    li      $v0,14      #service to read file
    move    $a0,$s0
    la      $a1,file    #space to store the content of the file
    la      $a2,100000  #max number of characters to read
    syscall

#and close the file
    li      $v0,16      #service to close file 
    move    $a0,$s0
    syscall

    li	    $t1,1       #RGB values line iterator
    li      $t7,3       #used in the calculations
    la      $t3,file    #input file 
    li      $t5,10      #used to convert str to int
    li      $s7,48      #used to convert str to int
    la      $t8, v1     #space used to store the string for the output
    la      $t4,values  #store the output string(the new RGB values)
    move    $s3,$zero   #line iterator for file

loop:
    beq     $s3,0,firstline     #add first line(P2)
    beq     $s3,4,rgbValues

    lb      $t2,($t3)           #$t2 = character from input file
    sb      $t2,($t4)

    addi    $t0,$t0,1           #increment number of characters stored

    beq     $t2,10,nextLine     #if its the end of the line move to the next
    
    addi    $t3,$t3,1           #increment input file pointer
    addi    $t4,$t4,1           #increment output file pointer

    j       loop


nextLine: #move to the next line in image file

    addi    $s3,$s3,1           #increment line itarator
    
    addi    $t3,$t3,1           #increment input file pointer

    #add "\n"
    li      $t2,10
    sb      $t2,($t4)
    addi    $t0,$t0,1          #increment number of characters stored

    addi    $t4,$t4,1          #increment output file pointer

    lb      $t2,($t3)
    bne     $t2,10,loop         #if its not the end of the line, then its a character (begining of next line)

    j       nextLine

rgbValues:
    #first covert the RGB value to integer
    beq     $t1,12289,Done          #$t1 is the line iterator for RGB values (12288 RGB values for 64x64 pixels)
    lb      $t6,($t3)
    beq     $t6,10,nextRGB
    
    #convert to int
    sub     $s6, $t6,$s7
    mul     $s5, $s5, $t5
    add     $s5, $s5, $s6           #$s5 has the int 

    addi    $t3,$t3,1

    j       rgbValues

nextRGB: #move to next RGB value
    add     $s1,$s1,$s5   #sum of RGB values for original image

    #check if line is a multiple of three (B value of pixel)
    div     $t1,$t7
    mfhi    $s4            #remainder
    beq     $s4,0,adjust   #if there is no remainder then its a multiple of three (B Value of pixel)

    move    $s5,$zero      #intialize for the next RGB value
    addi    $t1,$t1,1      #increment line iterator
    addi    $t3,$t3,1      #next position in input file(image)

    lb      $t6,($t3) 
    bne     $t6,10,rgbValues    #if its not the end of the line, then its a character (begining of next line)

    j       nextRGB

adjust: #calculate average of RGB values per pixel
    div     $s1,$t7       #$s1(R+G+B) and $t7(3)
    mflo    $s4           #average

    jal     newImage

    move    $s5,$zero
    addi    $t1,$t1,1     
    addi    $t3,$t3,1

    lb      $t6,($t3)
    bne     $t6,10,rgbValues     #if its not the end of the line, then its a character (begining of next line)

    j       nextRGB

newImage:   #store the average as the R,G and B values of this pixel in the output image 
    move    $s6,$zero
    move    $s7,$zero
    move    $s1,$s4	

    int_length:  #length of the average value
        div     $s1,$t5         #decrement the digits ,i.e, 182 - 18
        mflo    $s1             
        
        addi    $s6,$s6,1       #length

        beq     $s1,0,int_to_string
        
        j       int_length

    int_to_string:  #convert the average value to a string
        add     $s7,$s4,$zero   #integer
        addi    $t9,$s6,-1      #adjust for shifting the pointer of $t8
        move    $s3,$s6         #keep track of the end of the line per RGB value
        addi    $s6,$s6,-1      #adjust for shifting the pointer of $t8
        
        shift: #shift $t8, according to the length of the int(string bytes of the int(average) are added backwards in $t8)
        addi	$t8,$t8,1
        addi	$t9,$t9,-1
        
        beq    $t9,0,convert
        
        j	shift

        convert: #convert int(average) to string and store it to address in $t8
            beq     $s7,0,store     #if there are no digits left = done
	
            div     $s7,$t5         #$t5=10 and $s7=integer/average

            mfhi    $t9 #remainder (the digits of the int(average))
            mflo    $s7 #quotient 

            sb      $t9,0($t8)
	        addi    $t8,$t8,-1
            beq     $t8,0,store

            j       convert
	
	    store:	#store the string value of the int(average) to $t4(values array)
		    addi	$t8,$t8,1       #adjust pointer ($t8=#space used to store the string for the output)
            addi    $s3,$s3,-1      
		    lb	    $t9,($t8)

		    bltz    $s3,store_nlc   #if the digits are added/stored, add "\n" $s3(average value length)
		    addi    $t9,$t9,48      #change to ascii i.e, 1 - 49
		    sb	    $t9,($t4)

            addi    $t0,$t0,1       #increment number of characters stored

		    addi	$t4,$t4,1       #increment output file pointer
		
		    j	    store
		
	    store_nlc: #store new line character
		    li	    $s1,10
		    sb	    $s1,($t4)   # "\n"

            addi    $t0,$t0,1   #increment number of characters stored
	        addi	$t4,$t4,1   #increment output file pointer
               
		    j       return_to_adjust		#store the average value for the RGB values of the pixel - 3 times

        return_to_adjust:   #move to the next pixel
            move     $s1,$zero   #to store the RGB values of the next pixel 
            li	     $s7,48      #used to convert str to int
            li       $t7,3
            addi     $t8,$t8,1
            jr       $ra

Done:
    add     $s3,$zero,$t1   #number of RGB values(lines)
    move    $a0,$s3
    li      $v0,1
    syscall

    la      $a0,nl
    li      $v0,4
    syscall

    move    $s4,$zero

#open the file to write to
    li      $v0, 13
    la      $a0, output
    li      $a1, 1           #file flag (write == 1)
    li      $a2, 0
    syscall  
    move    $s0,$v0          #file descriptor

#write to the file
    move    $a0, $s0 
    li      $v0, 15
    la      $a1, values      #values(string for output image)
    addi    $a2,$t0,0      #add the number of characters
    syscall

#close the file
    li      $v0, 16
    move    $a0,$s0  
    syscall

exit:
    li      $v0,10
    syscall

firstline: # add the header
    la      $s3,header

    while:
        beq     $t0,2,start
        lb      $s1,($s3)
        sb      $s1,($t4)
        
        addi    $t0,$t0,1   
        addi    $t4,$t4,1   #increment output file pointer
        addi    $t3,$t3,1   #increment input file pointer
        addi    $s3,$s3,1   #increment header(P2\n) string pointer

        j       while
    
start: 
    #add new line character to values($t4)
    li      $s1,10
    sb      $s1,($t4)
    addi    $t4,$t4,1   #increment output file pointer
    addi    $t3,$t3,1   #increment input file pointer 
    li      $s3,1       #increment line iterator 
    
    li      $t0,3    #number of characters (header(P2\n) has 3characters)
    move    $s1,$zero   #sum of RGB values per pixel

    j       loop