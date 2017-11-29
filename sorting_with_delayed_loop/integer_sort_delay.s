############################ Test Cases ###########################################################
.data

#list0:      .word 4, 5, 6, 7, 8, 9, 11, 2, 1, 3
#len0:       .word 10


list0:      .word 782, 80, 873, 574, 491, 132, 799, 318, 795, 845, 97, 995, 188, 264, 571, 702, 253, 881, 986, 226, 631, 74, 23, 200, 970, 500, 186, 675, 165, 885, 552, 924, 466, 696, 745, 129, 654, 465, 749, 243, 111, 843, 231, 795, 274, 502, 42, 773, 454, 109, 914, 553, 171, 227, 796, 207, 518, 282, 246, 591, 860, 893, 995, 36
len0:       .word 64
delay:		.word 10000


.text
.globl main
main: 
la $a0, list0
la $a1, len0

addi $s1, $zero, 0
addi $s2, $zero, 1
addi $t0, $zero, 0

lw $a1, 0($a1) #a1=length of array
addi $t0, $zero, 4
addi $s0, $zero, 0
mul $a1, $a1, $t0 #a1= total array memory locations
addi $a1,$a1, -4
outerloop:         # for i in range(len):
 sub $s1, $a1, $s0 # $s1 = len-i, $s0 = i
 addi $t0, $zero, 0 # $t0 = j, j = 0
 innerloop:
  add $t1, $t0, $a0  # $t1= address(a[j] )
  lw  $t2, 0($t1)  #read first word $t2= a[j]
  addi $t1, $t1, 4 # $t1= address(a[j+1]) 
  lw $t3, 0($t1)  #read first word $t3= a[j+1]
  slt $t4, $t3, $t2
  bne $t4, $s2, noswap
  sw $t2, 0($t1)    #a[j+1] = $t2
  addi $t1, $t1, -4
  sw $t3, 0($t1)    #a[j] = $t3 
  noswap:
  addi $t0, $t0, 4 #j = j + 1
  slt $t4, $t0, $s1
  bne $t4, $zero, innerloop 
  addi $s0, $s0, 4 #i = i + 1
 slt $t4, $s0, $a1
 bne $t4, $zero, outerloop
 
 addi $t0, $zero, 0
 addi $a1, $a1, 4
 add $s1, $a0, $zero
 
 la $t4, display
 read_data:
 lw $s0, 0($s1)
 lw $t5, 0($t4)
 display:
 addi $t5, $t5, -1
 bne $t5, $zero, display
 addi $s1, $s1, 4
 addi $t0, $t0, 4
 bne $t0, $a1, read_data
 here: bne $zero, $s2, here
 
 
 
 
 
