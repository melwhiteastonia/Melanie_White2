.data

output: .asciiz "Output:" #this will print the base conversion 
string: .space 1032 #array goes here with 10 elements
newline: .asciiz "\n"
invalid: .asciiz "Invalid Input" #prints invalid input
.text #enables text input

#-----------------------------------------------------------------------------

main:

la $s1, 0  #register for final input
la $s2, 0    #register for tracking space charactar
la $s3, 0  #register for space charactar
la $s4, 0  #for valid charactar after loop



# create the string space and gets the user input

li $v0, 8 #gets the system ready to read the code
la $a0, string #address to store the variable
li $a1, 1000 #a string of 1000 integers

syscall 
 


#----------------------------------------------------------------------------

move $t0, $a0 #a pointer to the temporary space


loop: #loop to iterate over a string

lb $a0, ($t0)	#loads the string
addi $t0, $t0, 1 #increments one to the string
beqz $a0, end #if it's null the program will go to terminate
j loop

#beq $a0, 10, end  #if charactar less than 10 is found goes to end
#beq $a0, 9, tab #if tab is found then goes to loop
#beq $a0, 32, spacecharactar
#bne, $s3, 1, checkpoint  #if the charactar is a space then it will go to offset
#bne, $s2, 1, checkpoint  #if it is true that the charactar is valid then it will go to the offset


#j invalid #jumps to invalid loop



j invalid 

checkpoint: #loop to check if the charactar is valid 

la $s4, 1 #basically affirming the existence of a charactar 

blt $a0, 48, invalid
blt $a0, 58, valid_digit   #if ascii is less than 57 (valid), but if less than 48 (invalid), so 48<n<58

blt $a0, 65, invalid
blt $a0, 85, valid_upper     #65<n(ascii#)<84

blt $a0, 97, invalid
blt $a0, 117, valid_lower #97<n(ascii#)<117

j invalid #the end of the loop 

#----------------------------------------------------------------------------------------------------------------------

end: 
#beqz $s2, checkpoint
subi $t0, $t0, 1       #iterates over the string position
lb $a0 ($t0)  #loads bits for the $a0 position
beq $a0, 32, end
j print

#---------------------------------------------------------------------------------------------------------------

print: #if the charactar is invalid 

li $v0, 4
la $a0, newline
syscall

move $a0, $s1      #this is the call to move the result to the register
li $v0, 1          #call to print an integer
syscall 

li $v0, 10         #program exits here 
 
syscall 

#----------------------------------------------------------------------

valid_digit: #if the valid charactar is a digit

subu $s2, $a0, 48 #subtract 48 to find the real value
addu $s1, $s1, $s2 #add the real value to a register which holds the result

j loop

#---------------------------------------------------------------------------------

valid_upper:

subu $s2, $a0, 55 #subtract 55 to find the real value
addu $s1, $s1, $s2 #add the real value to the register holding the result

j loop

#----------------------------------------------------------------------------------------


valid_lower: 

subu $s2, $a0, 87 #subtract 87 to find the real value
addu $s1, $s1, $s2 #add the real value to the register holding the result


j loop


#-------------------------------------------------------------------------------------------
 
invalid: #if the ascii value is invalid 


li $v0, 4 #prints out a string
la $a0, newline #skips line
syscall

li $v0, 4  #prints out a string
la $a0, invalid #prints invalid input message
syscall

li $v0, 10  #exits the program
syscall 

jal subprogram 

#-----------------------------------------------------------------------------------------------



spacecharactar: #in the instance of a space



j loop



#beq $a0, 10, end #if it's longer than 10 spaces then the program will go to terminate

#-----------------------------------------------------------------------


subprogram: 

addi $sp, $sp, -4 #stack pointer
sw $s0, 0($sp)
jr $ra



final: 
li $v0, 4 #if charactar is valid it runs
la $a0, endl #prints new lie charactar
syscall 


move $a0, $s1 
li $v0, 1               #prints out an integer
syscall

li $v0, 10							



#-----------------------------------------------------------------------------------------------------------------------------------------------------------------

