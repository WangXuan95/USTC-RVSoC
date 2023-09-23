	.section .init; /*声明此处段名为.init*/
	.globl _start; /*声明_start是全局的*/
	.type _start,@function  /*声明_start是函数*/

_start:
.option push /*保存编译设置*/
.option norelax /*禁用相对寻址*/
	nop /*空操作*/

	la gp, __global_pointer$ /*设置gp全局指针，__global_pointer$来源于链接脚本，与data段关联，指向全局变量*/
.option pop
	la sp, _sp /*设置sp堆栈指针，_sp来源于链接脚本，指向普通的局部变量*/

	/*加载data段，存储需要初始化的全局变量和静态变量*/
	la a0, _data_lma /*程序存储器的data段起始地址 加载至 a0*/
	la a1, _data     /*数据存储器的data段起始地址 加载至 a1*/
	la a2, _edata    /*数据存储器的data段结束地址 加载至 a2*/
	bgeu a1, a2, 2f  /*a1大于等于a2，跳转至往下第一个2标签；否则向下执行*/
1:
	lw t0, (a0)      /*a0指向的地址 写入 t0*/
	sw t0, (a1)      /*t0的数据 写入 a1指向的地址 */
	addi a0, a0, 4   /*a0+4*/
	addi a1, a1, 4   /*a1+4*/
	bltu a1, a2, 1b  /*a1小于a2，跳转至往上第一个1标签；否则向下执行*/
	/*加载data段*/
2:

	/*清空bss段，存储不用初始化的全局变量和静态变量*/
	la a0, __bss_start /*bss段起始地址 加载至 a0*/
	la a1, _end        /*bss段结束地址 加载至 a1*/
	bgeu a0, a1, 2f    /*a0大于等于a1，跳转至往下第一个2标签；否则向下执行*/
1:
	sw zero, (a0)      /*a0指向的地址 写入 0*/
	addi a0, a0, 4     /*a0+4*/
	bltu a0, a1, 1b    /*a0小于a1，跳转至往上第一个1标签；否则向下执行*/
	/*清空bss段*/
2:

	call _init  /*初始化函数*/
	call main   /*main函数*/

loop:  /*无限循环*/
	j loop


