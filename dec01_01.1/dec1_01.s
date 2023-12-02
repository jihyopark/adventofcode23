	.data

sum:		.word 0
buffer:		.space 81
	
	.text
	
main:
	li	$t3, 0
	li	$t4, 0

	j	loop

loop:	li	$v0, 12		# scanf char
	syscall

	beqz	$v0, end	# if eof then go to end

	beq	$v0, 10, nl		# if newline

	# else 

	blt	$v0, 48, loop	# if char not between ascii 48 - 57
	bgt	$v0, 57, loop

	sub	$t1, $v0, 48	# make the numbers themselves

	bnez	$t3, skip	# if char is not first number

	mul	$t3, $t1, 10	# multiply first number by 10

	lw	$t2, sum		# add first * 10 to sum
	add	$t2, $t2, $t3
	sw	$t2, sum

	j	skip

skip:	move	$t4, $t1	# set second digit to the currently read number

	j	loop		# read new char
	
nl:	lw	$t2, sum	# add second to sum
	add	$t2, $t2, $t4
	sw	$t2, sum

	li	$t3, 0
        li	$t4, 0

	j	main		# read new line

end:
	lw      $t2, sum        # add second to sum
        add     $t2, $t2, $t4
        sw      $t2, sum
	
	li	$v0, 1		# print sum
	lw	$a0, sum
	syscall

	li	$v0, 10		# quit program
	syscall
