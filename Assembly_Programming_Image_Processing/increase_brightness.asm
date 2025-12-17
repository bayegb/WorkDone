.data
    filename: .asciiz "C:/Users/Baye Saliou Fall/OneDrive - University of Cape Town/CSC2002S/Assignments2023/ArchAssignment2023/ArchitectureAssignment/sample_images/house_64_in_ascii_crlf.ppm"
    v1:  .space  50000    # used to store the converted integers (from string to int)
    file:   .space 100000
    .align  2
    values:     .space 100000    #store the output string(the new RGB values)
    .align  2
    output:   .asciiz "C:/Users/Baye Saliou Fall/OneDrive - University of Cape Town/CSC2002S/Assignments2023/ArchAssignment2023/ArchitectureAssignment/sample_images/output.ppm"
    nl: .asciiz "\n" 
    msg1: .asciiz "Average pixel value of the original image:\n"
    msg2: .asciiz "Average pixel value of new image:\n"
    header: .asciiz "P2\n"    #for the new image

.text
.globl main

main:
#open ...
    li      $v0,13      #service to open a file
    la      $a0,filename
    li      $a1,0       #file flag = read(0)
    syscall
    move    $s0,$v0     #file descriptor
 
#and read the file ...
    li      $v0,14      #service to read a file
    move    $a0,$s0
    la      $a1,file    #space to store what is read from file
    la      $a2,100000  #max number of characters to read
    syscall

#and close the file
    li      $v0,16      #service to close the file
    move    $a0,$s0
    syscall

    li	    $s1,1
    move    $t1,$zero   #sum of RGB values for new image
    la      $t3,file    #input file
    la      $t4,values  #the string for the new image (output)
    li      $t7,3       
    move    $s3,$zero   #line iterator
    move    $s2,$zero   #line iterator for RGB values(rgbValues)
    li      $t5,10      #used to convert str to int
    li      $s7,48      #used to convert str to int
    move    $s1,$zero   #sum of RGB values for original image
    la      $t8, v1     #space used to store the string for the output
    move    $s3,$zero   #line iterator for file
    move    $s1,$zero   #used when shifting $t8 pointer
    move    $t0,$zero   #number of characters stored in values(to print)
    

loop: #Loop through file until first RGB value
    beq     $s3,4,rgbValues     # RGB values start after line 4

    lb      $t2,($t3)
    sb      $t2,($t4)

    addi    $t0,$t0,1           #increment number of characters stored

    beq     $t2,10,nextLine     #if its the end of the line move to the next
    
    addi    $t3,$t3,1
    addi    $t4,$t4,1

    j       loop

nextLine: #move to the next line on image file
    addi    $s3,$s3,1        #increment line iterator
    
    addi    $t3,$t3,1

    #add "\n"
    li      $t2,10
    sb      $t2,($t4)
    addi    $t0,$t0,1          #increment number of characters stored

    addi    $t4,$t4,1          #increment output file pointer

    lb      $t2,($t3)
    bne     $t2,10,loop      #if its not the end of the line, then its a character (begining of next line)

    j       nextLine

startRGBvalues:
    move    $t2,$zero


rgbValues:
    #first covert the RGB value to integer
    beq     $s2,12289,Done      #$s2(line iterator) and 64x64x3+1=12289
    lb      $t6,($t3)

    beq     $t6,10,nextRGB      #if its the end of the line move to the next line (RGB value)
    
    #convert to int 
    sub     $s6, $t6,$s7
    mul     $s5, $s5, $t5
    add     $s5, $s5, $s6

    addi    $t3,$t3,1

    j       rgbValues

nextRGB:    #move to next RGB value after adding ten to this RGB value

    add     $t2,$t2,$s5     #sum of RGB values for original image
    
    addi    $s5,$s5,10      #increment RGB value by 10 for new image (write to new file???)
    bgt     $s5,255,adjust
    
    add     $s4,$s5,$zero   #RGB value for the new image

    add     $t1,$t1,$s5     #sum of RGB values for new image
    
    jal     newImage

    move    $s5,$zero
    addi    $s2,$s2,1     
    addi    $t3,$t3,1

    lb      $t6,($t3)
    bne     $t6,10,rgbValues  #if its not the end of the line, then its a character (begining of next line)

    j       nextRGB

adjust: #if RGB value plus 10 is greater than 255, set the new value to 255
    addi    $t1,$t1,255        #sum of RGB values for new image

    addi    $s4,$zero,255      #RGB value for the new image

    jal     newImage

    move    $s5,$zero
    addi    $s2,$s2,1     
    addi    $t3,$t3,1

    lb      $t6,($t3)
    bne     $t6,10,rgbValues    #if its not the end of the line, then its a character (begining of next line)

    j       nextRGB

newImage:   #store the average as the R,G and B values of this pixel in the output image 
    move    $s6,$zero
    move    $s7,$zero
    move    $s1,$s4	

    int_length:  #length of the average value
        div     $s1,$t5         #decrement the digits ,i.e, 182 to 18
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
	
            div     $s7,$t5

            mfhi    $t9             #remainder (the digits of the int(average))
            mflo    $s7             #quotient 

            sb      $t9,0($t8)
	        addi    $t8,$t8,-1
            beq     $t8,0,store

            j       convert
	
	    store:	#store the string value of the int(average) to $t4(values array)
		    addi	$t8,$t8,1       #adjust pointer
            addi    $s3,$s3,-1      
		    lb	    $t9,($t8)

		    bltz    $s3,store_nlc   #if the digits are added/stored, add "\n" $s3(RGB value length)
		    addi    $t9,$t9,48      #change to ascii i.e, 1 to 49
		    sb	    $t9,($t4)

            addi    $t0,$t0,1           #increment number of characters stored

	        addi	$t4,$t4,1
		
		    j	    store
		
	    store_nlc: #store new line character 
		    li	    $s1,10
		    sb	    $s1,($t4)   # $s1 = "\n"

            addi    $t0,$t0,1           #increment number of characters stored

	        addi	$t4,$t4,1

            #move to the next pixel 
            li	     $s7,48
            li       $t7,3
            move     $s4,$zero
            jr       $ra

Done:
    #calculate average for original image 
    li      $s3,12288     #number of RGB values
    
    mtc1.d  $s3, $f12     #convert integer to double
    cvt.d.w $f12, $f12

    mtc1.d  $t2, $f2      #convert integer to double ($t2 has sum of RGB values for the original image)
    cvt.d.w $f2, $f2

    div.d   $f4,$f2,$f12

    li      $s3,255 
    
    mtc1.d  $s3, $f10     #convert integer to double
    cvt.d.w $f10, $f10

    div.d   $f4,$f4,$f10  #average for original image

    #calculate average for new image 
    li      $s3,12288     #number of RGB values
    
    mtc1.d  $s3, $f12     #convert integer to double
    cvt.d.w $f12, $f12

    mtc1.d  $t1, $f2      #convert integer to double ($t1 has sum of RGB values for the new image)
    cvt.d.w $f2, $f2

    div.d   $f6,$f2,$f12

    li      $s3,255 
    
    mtc1.d  $s3, $f10     #convert integer to double
    cvt.d.w $f10, $f10

    div.d   $f6,$f6,$f10  #average for new image

#output
    la      $a0,msg1
    li      $v0,4
    syscall

    mov.d   $f12,$f4      
    li      $v0,3
    syscall

    la      $a0,nl
    li      $v0,4
    syscall

    la      $a0,msg2
    li      $v0,4
    syscall

    mov.d   $f12,$f6
    li      $v0,3
    syscall

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
    addi    $a2, $t0, 0
    syscall

#close the file
    li      $v0, 16
    move    $a0,$s0  
    syscall

exit:
    li      $v0,10
    syscall
